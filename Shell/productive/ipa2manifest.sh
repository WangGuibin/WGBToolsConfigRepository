# /bin/bash
# $1 本地ipa文件路径
# $2 ipa服务端地址
# 用法 sh ipa2manifest.sh  /Users/WangGuibin/Desktop/App.ipa  http://10.161.62.123:8081/App.ipa
# $2 没传的话就得自己修改ipa的服务端文件地址了 不然plist取不到ipa啊
# 利用苹果的一个服务协议 放个a标签点击或者直接地址栏访问就行 <itms-services://?action=download-manifest&url=https://xxx/manifest.plist> 注意plist这个要https ipa的倒是无要求

zip_file=${1%.*}.zip
cp -R $1  $zip_file
unzip -o $zip_file > /dev/null 2>&1

#提取Info.plist的有用信息
info_plist=${1%/*}/Payload/*.app/Info.plist 
function getInfo(){
    /usr/libexec/PlistBuddy -c "print $1" $info_plist
}

AppName=$(getInfo "CFBundleDisplayName")
BundleId=$(getInfo "CFBundleIdentifier")
AppVersion=$(getInfo "CFBundleShortVersionString")

xmlText=$(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>items</key>
	<array>
		<dict>
			<key>assets</key>
			<array>
				<dict>
					<key>kind</key>
					<string>software-package</string>
					<key>url</key>
					<string>${2}</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
				<string>${BundleId}</string>
				<key>bundle-version</key>
				<string>${AppVersion}</string>
				<key>kind</key>
				<string>software</string>
				<key>title</key>
				<string>${AppName}</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>
EOF
)

echo $xmlText > ${1%/*}/manifest.plist 
rm -rf $zip_file
rm -rf ${1%/*}/Payload
