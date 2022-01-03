#!/bin/bash
# 参数说明: $1 标题  $2 副标题  $3 消息内容 
function showMessage(){
osascript -e "display notification \"${3}\" with title \"$1\" subtitle \"$2\" sound name \"Funk\""
}

# 参数说明: $1 标题  $2 内容 
function showAlertMessage(){
result=$(osascript <<EOF 
display dialog "${2}" with title "$1" buttons {"好的👌"} default button 1 with icon file "MAC:Users:wangguibin:Desktop:Xcode.icns"
EOF
)
}