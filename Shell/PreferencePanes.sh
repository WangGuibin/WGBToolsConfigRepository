#! /bin/bash

cd /System/Library/PreferencePanes
for line in `ls ./` ; 
do 
    info_path=`pwd`/$line/Contents/Info.plist
    BundleID=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" $info_path)
    BundleName=$(/usr/libexec/PlistBuddy -c "print CFBundleExecutable" $info_path)      
    echo "面板 ${BundleName} 的BundleId: ${BundleID}" >> ~/Desktop/MacBundleIDs.txt
done

# 收集偏好设置的面板的bundleId 利用applescript可实现快速跳转  当然Alfred直接搜对应面板名也是一个意思
:<<EOF
tell application "System Preferences"
	activate
	delay 2
	set the current pane to pane id "com.apple.preference.datetime"
end tell
EOF