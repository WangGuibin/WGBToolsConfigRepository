
#!/bin/bash

RED='\033[31m'      # 红
GREEN='\033[32m'    # 绿
CYAN='\033[36m'     # 蓝
RES='\033[0m'         # 清除颜色

need_verbose=""

echoRed(){
	echo -e "${RED}${1}${RES}"
}

echoGREEN(){
	if [[ "$need_verbose" != "" ]]; then
		echo -e "${GREEN}${1}${RES}"
	fi
}

echoCYAN(){
	if [[ "$need_verbose" != "" ]]; then
		echo -e "${CYAN}${1}${RES}"
	fi
}

echoResult() {
	echo -e "${GREEN}${1}${RES}"
}

usage(){
	echoResult '请输入参数：'
	echoResult '\t必传参数1：ipa目录'
	echoResult '\t必传参数2：描述文件目录'
	echoResult "\t必传参数3：证书SHA-1值，注意用 \"\" 双引号包起来，因为有可能有空格,内部会自动过滤空格"
	echoResult '\t可选参数 -b new_bundle_identifier'
	echoResult '\t可选参数 -e entitlements_file 目录用于签名，不指定则使用描述文件里的配置自动生成 entitlements_file'
	echoResult '\t可选参数 -v 打印详细日志'
	echoResult '\t可选参数 -h 查看使用说明'
}

if [ $# -lt 3 ]; then
	usage
	exit
fi

original_ipa_file=""
mobileprovision_file=""
certificate_name=""
if ! ([ -f "$1" ]); then
	echoRed "参数1：IPA文件不存在 ${1}"
	exit
fi


if ! ([ -f "$2" ]); then
	echoRed "参数2：描述文件不存在 ${2}"
	exit
fi


if ([ "$3" == "" ]); then
	echoRed "参数3：证书名称不能为空 ${3}"
	exit
fi


original_ipa_file=$1
mobileprovision_file=$2
temp_certificate_name=$3
certificate_name=${temp_certificate_name// /}
user_app_entitlements_file=""
new_bundle_identifier=""
sign_entitlements_file=""
user_app_entitlements=""
shift 3
# 解析参数
while [ "$1" != "" ]; do
    case $1 in
        -e | --entitlements )
            shift
            user_app_entitlements_file="$1"
            user_app_entitlements="1"
            ;;
        -b | --bundle-id )
            shift
            new_bundle_identifier="$1"
            ;;
        -n | --version-number )
            shift
            VERSION_NUMBER="$1"
            ;;
        --short-version )
            shift
            SHORT_VERSION="$1"
            ;;
        --bundle-version )
            shift
            BUNDLE_VERSION="$1"
            ;;
        -v | --verbose )
            need_verbose="--verbose"
            ;;
        -h | --help )
            usage
            ;;
        * )
            ;;
    esac

    # Next arg
    shift
done


echoGREEN "-----------------输入参数---------------------"
echoGREEN " 即将签名的IPA文件：${original_ipa_file}"
echoGREEN "    使用的描述文件：${mobileprovision_file}"
echoGREEN "     签名证书名称：${certificate_name}"
echoGREEN "     新bundleID：${new_bundle_identifier}"
echoGREEN "     entitlements文件目录：${user_app_entitlements_file}"
echoGREEN '---------------------------------------------'


if [[ "$user_app_entitlements" == "1" ]]; then
	if ! ([ -e "$user_app_entitlements_file" ]); then
		echoRed "-e 参数：plist文件不存在 -> "${3}
		exit
	else
		sign_entitlements_file="$user_app_entitlements_file"
	fi
fi



IpaFileName=$(basename "$original_ipa_file" .ipa)

#存放ipa的目录
original_ipa_path=$(dirname "$original_ipa_file")
unzip_path="${original_ipa_path}"/temp_unzip

rm -rf ${original_ipa_path}/${IpaFileName}-resign.ipa

unzip -oq "$original_ipa_file" -d "${unzip_path}"


if ([ "$sign_entitlements_file" == "" ]); then
	# 将描述文件转换成plist
	mobileprovision_plist="${unzip_path}/mobileprovision.plist"

	#生成plist主要是查看描述文件的信息
	security cms -D -i "$mobileprovision_file"  > "$mobileprovision_plist"

	teamId=`/usr/libexec/PlistBuddy -c "Print Entitlements:com.apple.developer.team-identifier" "$mobileprovision_plist"`
	application_identifier=`/usr/libexec/PlistBuddy -c "Print Entitlements:application-identifier" "$mobileprovision_plist"`

	#描述文件budnleid
	mobileprovision_bundleid=${application_identifier/$teamId./}
	# echoGREEN '描述文件中的bundleid: '$mobileprovision_bundleid
	mobileprovision_entitlements_plist="${unzip_path}/mobileprovision_entitlements.plist"
	/usr/libexec/PlistBuddy -x -c "Print Entitlements" "$mobileprovision_plist" > "$mobileprovision_entitlements_plist"
	sign_entitlements_file="$mobileprovision_entitlements_plist"
fi

echoGREEN "使用的entitlemetns文件：$sign_entitlements_file"


#filePath  例如  xx.app   xx.appex  xx.dylib  xx.framework
signFile(){
	filePath="$1";
	suffixStr=${filePath##*.};
	newID=$new_bundle_identifier;
	echoCYAN "正在签名  ${filePath}"
	if [ "$newID" != "" ] && [ "$suffixStr" != "framework" ] && [ "$suffixStr" != "dylib" ];then
		
		bundleId=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier " "${filePath}/Info.plist")
		ExtensionID=${bundleId/"$OldbundleId"/"$new_bundle_identifier"} 
		/usr/libexec/PlistBuddy -c "Set CFBundleIdentifier $ExtensionID" "${filePath}/Info.plist"

		echoCYAN "bundlieId 旧ID：${bundleId}  新ID：${ExtensionID}"

		WKCompanionAppBundleIdentifier=`/usr/libexec/PlistBuddy -c "Print WKCompanionAppBundleIdentifier" "${filePath}/Info.plist" 2> /dev/null`
		if [ "$WKCompanionAppBundleIdentifier" != "" ];then
			echoCYAN "WKCompanionAppBundleIdentifier 旧ID：${WKCompanionAppBundleIdentifier}  新ID：${new_bundle_identifier}"
			/usr/libexec/PlistBuddy -c "Set WKCompanionAppBundleIdentifier $new_bundle_identifier" "${filePath}/Info.plist"
		fi
		WKAppBundleIdentifier=`/usr/libexec/PlistBuddy -c "Print NSExtension:NSExtensionAttributes:WKAppBundleIdentifier" "${filePath}/Info.plist" 2> /dev/null`
		if [ "$WKAppBundleIdentifier" != "" ];then
			NEW_WKAppBundleIdentifier=${WKAppBundleIdentifier/"$OldbundleId"/"$new_bundle_identifier"} 
			echoCYAN "WKAppBundleIdentifier 旧ID：${WKAppBundleIdentifier}  新ID：${NEW_WKAppBundleIdentifier}"
			/usr/libexec/PlistBuddy -c "Set NSExtension:NSExtensionAttributes:WKAppBundleIdentifier ${NEW_WKAppBundleIdentifier}" "${filePath}/Info.plist"
		fi

	fi


	


	if [ "$suffixStr" != "dylib" ];then
		rm -rf "${filePath}/_CodeSignature"
		#拷贝配置文件到Payload目录下
		cp "$mobileprovision_file" "${filePath}/embedded.mobileprovision"
	fi
	

	(/usr/bin/codesign $need_verbose -f -s "$certificate_name" --entitlements="$sign_entitlements_file" "$filePath") || {
		echoRed "签名失败 ${filePath}"
		rm -rf "${unzip_path}"
		exit
	}
	echoCYAN "签名结束 ${filePath}"
}



AppPackageName=$(ls "${unzip_path}/Payload" | grep ".app$" | head -1)
AppPackageName=$(basename $AppPackageName .app)
echoGREEN '包名：'$AppPackageName
OldbundleId=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier " "${unzip_path}/Payload/${AppPackageName}.app/Info.plist")
echoGREEN '旧bundleid：'$OldbundleId;
echoGREEN '---------------------------------------------'

frameworkPath="${unzip_path}/Payload/${AppPackageName}.app/Frameworks"

if [ -d "${frameworkPath}" ]; then
	echoCYAN '存在Frameworks'
	echoGREEN '开始签名Frameworks'
	for file in "$frameworkPath"/*; do
	    signFile "$file"
	done
	echoGREEN '签名Frameworks结束'
fi

PlugInsPath="${unzip_path}/Payload/${AppPackageName}.app/PlugIns"

if [ -d "${PlugInsPath}" ]; then
	echoCYAN '存在普通扩展'
	echoGREEN '开始签名普通扩展'
	for file in "$PlugInsPath"/*; do
		signFile "$file"
	done
	echoGREEN '普通扩展签名结束'
fi

WatchAppPath="${unzip_path}/Payload/${AppPackageName}.app/Watch"
if [ -d "${WatchAppPath}" ]; then
	WatchAppName=$(ls ${WatchAppPath} | grep ".app$" | head -1)
	watchPlugInsPath=${WatchAppPath}/${WatchAppName}/PlugIns
	if [ -d "${watchPlugInsPath}" ]; then
		echoCYAN 'Watch APP 存在扩展'
		echoGREEN '开始签名Watch App的扩展'
		for file in "$watchPlugInsPath"/*; do
			signFile "$file"
		done
		echoGREEN 'Watch App的扩展签名结束'
	fi
	echoGREEN '存在Watch App'
	echoGREEN '开始签名Watch App'
	signFile "${WatchAppPath}/${WatchAppName}"
	echoGREEN 'Watch App签名结束'

fi

#设置文件共享
#/usr/libexec/PlistBuddy -c "Set :UIFileSharingEnabled true" "${unzip_path}/Payload/${AppPackageName}.app/Info.plist"

echoGREEN '开始签名主App'
signFile "${unzip_path}/Payload/${AppPackageName}.app"
echoGREEN '主App签名结束'

cd "$unzip_path"
echoGREEN '开始压缩生成ipa'
zip -rq "${original_ipa_path}/${IpaFileName}-resign.ipa" ./*
rm -rf "${unzip_path}/"
echoGREEN '压缩完成'
echoGREEN "新IPA目录：${original_ipa_path}/${IpaFileName}-resign.ipa"
echoResult "######################  重新签名成功  ##############################"

