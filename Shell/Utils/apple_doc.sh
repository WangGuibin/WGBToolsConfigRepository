#!/bin/bash
appledoc \
--output ../../Doc \
-i *.m \
--project-name "PHScreenRecordKit" \
--project-company "xxxx公司" \
--no-create-docset \
./PHScreenRecordKit/SDK

#展示信息
showMessage(){
msg=$1
osascript -e "display notification \"${msg}\" with title \"📩收到一条新的通知\""
}

showMessage "文档生成成功!!"
open ../../Doc