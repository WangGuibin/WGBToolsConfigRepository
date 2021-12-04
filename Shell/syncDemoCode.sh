#!/bin/bash
source ./tipsMessage.sh 

function syncCodeAction(){
cat ${FILE_PATH_1} >> ./temp.m
cat ./temp.m > ${FILE_PATH_2}
cat ./temp.m > ${FILE_PATH_3}
rm -rf ./temp.m
}

CURRENT_DIR=`pwd`

#$1 文件名
function execProcess(){
FILE_PATH_1="${CURRENT_DIR}/phmmas-ios/PHScreenRecordKit/PHLiveRecordDemo/PHLiveRecordDemo/${1}.m"
FILE_PATH_2="${CURRENT_DIR}/phmmas-ios/phRecordPodDemo/TestRecordDemo/${1}.m"
FILE_PATH_3="${CURRENT_DIR}/phmmas-ios/PHRecordFrameworkDemo/PHRecordFrameworkDemo/${1}.m"
syncCodeAction 
}

#调用
files=("ViewController" "PHRecordScreenVideoListViewController" "AppDelegate")
for file in ${files[*]}; do
	 execProcess $file
done

#sleep 1s  #睡1秒
# sleep 1m #睡1分钟 
# sleep 1h #睡1小时
# sleep 1d #睡1天

showMessage "通知" "success" "✅Demo代码同步成功!!"
