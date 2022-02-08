#! /bin/bash
# 获取Mac应用的图标
function getMacAppLogo() {
cd $1
for path in `ls ./`;
do
    res=`pwd`/$path/Contents/Resources
    if [[ -d $res ]] ;
    then
        cd $res
        logoDirName=${path%.app*}
        mkdir -p ~/Desktop/AppLogo/$logoDirName
        cp -R *.icns  ~/Desktop/AppLogo/$logoDirName/
        cd $1
    fi
done
}
#系统应用
getMacAppLogo /System/Applications
#第三方应用
getMacAppLogo /Applications
#实用工具目录下的
getMacAppLogo /Applications/Utilities




