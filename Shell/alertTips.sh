#!/bin/bash

function showAlert(){
# $1 title  标题
# $2 items  按钮标题用逗号隔开 
# $3 defaultSelectIndex 默认选中的下标 不传则不选中

array=(${2//,/ })  
for var in ${array[@]}
do
   TEMP_VAR+="\"$var\"," 
done 
items="${TEMP_VAR%*,}" #处理成 "1","2","3"

if [[ -n "$3" ]]; then
	defaultSelectIndex="default button $3"
fi

osascript <<EOT
set titleStr to "$1"
set btns to {$items}
display dialog titleStr buttons btns $defaultSelectIndex --默认选择第1个按钮(按return时就会让弹出框消失)
get the button returned of the result  -- 弹出框
EOT
}

value=$(showAlert "通知" "按钮1,按钮2,按钮3" "1")
echo "主动打印 $value"
showAlert "这样不行啊,\n得想个办法才行\n哈哈哈哈哈哈哈哈哈哈哈哈哈哈\n😃🙄🙄" "OK👌,Cancel" 



#这种解法更优雅感觉...
function showAlert2(){
# $1 title  标题
# $2 items  按钮标题用逗号隔开 
# $3 defaultSelectIndex 默认选中的下标 不传则不选中

if [[ -n "$3" ]]; then
	defaultSelectIndex="default button $3"
fi

osascript <<EOT
set str to "$2"
set oldDelimiters to AppleScript's text item delimiters
set AppleScript's text item delimiters to ","
set buttonList to every text item of str
set AppleScript's text item delimiters to oldDelimiters
get buttonList

set titleStr to "$1"
set btns to buttonList
display dialog titleStr buttons btns $defaultSelectIndex --默认选择第1个按钮(按return时就会让弹出框消失)
get the button returned of the result  -- 弹出框
EOT
}

showAlert2 "通知" "哈哈哈,就是这样,没错了" "2"

