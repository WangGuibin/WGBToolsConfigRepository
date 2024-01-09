
#!/bin/bash

export DEVELOPER_DIR="/Applications/XCode.app/Contents/Developer"

RED='\033[31m'      # 红
GREEN='\033[32m'    # 绿
RES='\033[0m'         # 清除颜色

function echoResult() {
	echo -e "${GREEN}${1}${RES}"
}

echoRed(){
	echo -e "${RED}${1}${RES}"
}

if [[ "$#" == "0" ]]; then
	echoResult "请至少输入一个参数：crash文件位置，会自动在电脑上寻找是否有匹配的dSYM文件"
	echoResult "如果想指定dSYM文件：则传第二个参数"
	exit 1
fi


crashFile="$1"
dsymFile="$2"

echoResult "crash文件：$crashFile"

if ! [ -f "$1" ];then
	echoRed "参数1：${1} 文件不存在"
	exit 1
fi

if [ "$#" == "2" ] && [ ! -d "${2}" ];then
	echoRed "参数2：${2} 文件不存在"
	exit 1
fi

function logLine(){
	echo "--------------------------------------------------------------"	
}
logLine
echoResult "                 crash文件中信息"
logLine

process=$(grep Process "$crashFile" | head -n 1)
process=${process%%'['*}
process=${process#*:}
process=${process//" "/""}
if [[ $process == "" ]]; then
	process=$(grep Command "$crashFile" | head -n 1)
	process=${process#*:} 
	process=${process//" "/""}
fi
echo $process

#两种格式解析 
# OS Version:      iPhone OS 13.0 (17A5508m)
# OS Version:       iPhone OS 13.0 (Build 17A5508m)

osVersion=$(grep "OS Version:" "$crashFile" | head -n 1)
osVersion=${osVersion#*"Version:"}
osVersion=${osVersion#*"OS"}
osVersion=${osVersion/"Build "/""} 
osVersion=`echo $osVersion` #去除空格
echo "OS Version：$osVersion"

result=$(grep -n "Binary Images:" "$crashFile")
result2=${result%%:*} #删除第一个:后面的字符串,保留左边
let "line=result2+1"
result=$(sed -n ${line}p "$crashFile")


archResult=`grep Architecture "$crashFile" | head -n 1`
if [[ $archResult != "" ]]; then
	arch=${archResult#*:}
	arch=${arch//" "/""}
else
	arch=${result%%<*}
	arch=${arch#*$process}
	arch=${arch//" "/""}
fi


uuid=${result%%>*} 
uuid=${uuid#*<} 
uuid=${uuid//"-"/""}
uuid=`echo $uuid | tr '[A-Z]' '[a-z]'`

echo ${arch}:$uuid
echo "----------------------------------------------------------------"

function getInfoFromDSYM(){
	firstArch=$(dwarfdump --uuid "$1" | grep UUID | head -n 1)
	secondArch=$(dwarfdump --uuid "$1" | grep UUID | tail -n +2 | head -n 1)

	dsymProcess=${firstArch#*)}
	dsymProcess=`basename $dsymProcess`

	firstResult1=${firstArch:5}
	firstUUID=${firstResult1%(*}
	firstUUID=${firstUUID//"-"/""}
	firstUUID=${firstUUID//" "/""}
	firstUUID=`echo $firstUUID | tr '[A-Z]' '[a-z]'`
	firstResult2=${firstArch#*'('}
	firstArchName=${firstResult2%)*}


	secondResult1=${secondArch:5}
	secondUUID=${secondResult1%(*}
	secondUUID=${secondUUID//"-"/""}
	secondUUID=${secondUUID//" "/""}
	secondUUID=`echo $secondUUID | tr '[A-Z]' '[a-z]'`
	secondResult2=${secondArch#*'('}
	secondArchName=${secondResult2%')'*}

	echo "${dsymProcess}\\n${firstArchName}:${firstUUID}\\n${secondArchName}:${secondUUID}"

}

function checkInfo(){
	result=$(getInfoFromDSYM "$1")
	echo "开始比对：$1"
	echo "$result"
	if [[ ${result} =~ "$uuid" ]];then 
		return "1"
	else 
		return "0";
	fi
}


#没有使用查找的dsym文件
have="0"

function findPathWithResult(){
	list=$1
	IFS=$'\n'
	for s in $list;do
		# echoResult $s
		# continue;
		checkInfo "$s"
		result="$?"
		if [[ ${result} == "1" ]];then 
			echoResult "匹配";
			dsymFile="$s"
			have="1"
			break;
		else 
			echoRed "不匹配";
		fi
		logLine
		done
	IFS=OLD_IFS
}



if [[ "$#" == "1" ]]; then
	echoResult "               开始查找电脑上dSYM文件"
	logLine

	#搜索归档目录
	list=$(find $HOME/Library/Developer/Xcode/Archives -name "*.dSYM" -print)
	findPathWithResult "$list"

	if [[ "$have" == "0" ]];then
		#搜索下载目录
		list=$(find $HOME/Downloads -name "*.dSYM" -print)
		findPathWithResult "$list"	
	fi

	if [[ "$have" == "0" ]];then
		#搜索桌面
		list=$(find $HOME/Desktop -name "*.dSYM" -print)
		findPathWithResult "$list"
	fi

	if [[ "$have" == "0" ]];then
		#搜索用户目录
		list=$(find ~ -path "$HOME/.*" -prune -o -path "$HOME/Library" -prune -o -path "$HOME/Downloads" -prune -o -path "$HOME/Desktop" -prune -o -name "*.dSYM" -print)
		findPathWithResult "$list"	
	fi

	if [[ "$have" == "0" ]]; then
		echo "               结束：在本机未发现符合的dSYM文件"
		exit 1	
	fi
fi


if [[ "$have" == "0" ]];then
	checkInfo "$dsymFile"
	result="$?"
	if [[ ${result} == "1" ]];then 
		echoResult "匹配";
	else 
		echoRed "不匹配";
		exit 1
	fi
fi


dir=`dirname "$crashFile"`
name=`basename "$crashFile"`
newName="${dir}/${name}.txt"


#可通过以下命令查找symbolicatecrash所处位置
#find /Applications/Xcode.app -name symbolicatecrash -type f


cd /Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources
logLine
echoResult "                 开始解析crash文件"
./symbolicatecrash "$crashFile" "$dsymFile" > "$newName" 2> /dev/null
logLine
echoResult "完成：生成新文件目录：${newName}"

haveOS=$(find "${HOME}/Library/Developer/Xcode/iOS DeviceSupport" -name "$osVersion" -print)
if [[ "$haveOS" == "" ]];then
	echoRed "系统符号不存在【 OS ${osVersion} 】：可能无法解析系统调用栈"
	echoRed "系统符号目录：${HOME}/Library/Developer/Xcode/iOS DeviceSupport"
	echoRed "如需解析，请下载系统符号，可以使用：https://github.com/lsmakethebest/LSiOSShell/fetchDeviceSupport.sh"
fi



function replaceContent(){
	#file  content  lineNumber
	fileName="$1"
	content="$2"
	line=$3

	#获取指定字符串的行号
	newLine=$(sed -n "/$content/=" "$fileName" | tail -n +2 | head -n 1)
	newLineContent=`sed -n "${newLine}p" "$fileName"`

	#删除这行
	$(sed -i "" "${line}d" "$fileName")
	#在删除的行插入新字符串
	$(sed -i "" "${line}i\\"$'\n'"${newLineContent}"$'\n' "$fileName")
}


function checkHeaviestStack(){

	fileName="$1"
	startStr="Heaviest stack for the target process:"
	endStr="Powerstats for:"

	lineStart=$(sed -n "/$startStr/=" "$fileName")
	
	if [[ "$lineStart" = "" ]]; then	
		return 
	fi

	echoResult "存在Heaviest stack:再次解析"

	lineStart=$(($lineStart+1))
	lineEnd=$(sed -n "/$endStr/=" "$fileName")
	lineEnd=$(($lineEnd-3))

	while [[ $lineStart -le $lineEnd ]]; do
		lineContent=`sed -n "${lineStart}p" "$fileName"`
		lineContent=${lineContent##*"["}
		lineContent=${lineContent%"]"*}
		replaceContent "$fileName" "$lineContent" $lineStart
		lineStart=$(($lineStart+1))
	done
	echoResult "存在Heaviest stack:解析完成"
}

checkHeaviestStack "$newName"

open "$newName"


