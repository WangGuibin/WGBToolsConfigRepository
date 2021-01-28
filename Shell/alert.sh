#!/bin/bash

# 1. 自定义通知消息 
# 传参 $1:消息描述 $2:通知标题 $3:通知副标题
function showNoteMessage(){
  osascript -e "display notification \"${1}\" with title \"${2}\" subtitle \"${3}\" sound name \"Funk\""
}
#test case:
#showNoteMessage "消息内容" "通知" "通知副标题"

# 2. 自定义弹窗(统一通用方法)
# 传参$1 弹窗消息内容
# 传参$2 弹窗标题
# 传参$3 按钮标题,多个用英文逗号隔开 
# 传参$4 默认选中的按钮标题或者按钮数字下标
# 传参$5 是否为输入框类型 传"0"或者"1" 默认"0"
# 传参$6 输入框默认占位内容,传不传无所谓,默认为空字符串 ""
# 传参$7 默认图标note/stop/caution 或者自定义文件路径(:格式路径可以通过choose file获取)  
# tips: 重要! 如果为输入框模式,那么输出结果就是{button returned:button,text returned:text} 否则只有按钮或者false 
function showCustomAlertMessage(){

if [[ -n "$4" ]]; then

	if [[ ${4} == *[!0-9]* ]]; then
     	defaultButton="default button \"${4}\""
     	else
     	defaultButton="default button ${4}"
	fi
else
	defaultButton=""
fi

#是否为输入框模式
if [[ "$5" = "1" ]]; then
	IS_InputMode="default answer \"${6}\""
	ReturnValue="get result"
else
	IS_InputMode=""
	ReturnValue="get the button returned of the result"
fi

if [[ -n "$7" ]]; then
  case ${7} in
	note)
	ICON="with icon note"
	;;
	stop)
	ICON="with icon stop"
	;;
	caution)
	ICON="with icon caution"
	;;
	*)
	ICON="with icon file \"${7}\""
	;;
 esac
else
 ICON="with icon file \"Macintosh HD:Applications:Xcode.app:Contents:Resources:Xcode.icns\""
fi

osascript <<EOF
	set buttonStr to "${3}"
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ","
	set buttonList to every text item of buttonStr
	set AppleScript's text item delimiters to oldDelimiters
	get buttonList
	set btns to buttonList
	display dialog "${1}" with title "${2}" buttons btns ${IS_InputMode} ${defaultButton} ${ICON}
	${ReturnValue}  
EOF
}

# showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2"  "1" "占位内容" "note"
# showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" 2  "0" "占位内容" "note"
#showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2" "0" "占位内容" "stop" 
#showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2" "0" "占位内容" "Macintosh HD:Applications:Xcode.app:Contents:Resources:Xcode.icns"

# 普通弹窗 一个ok就够了 就是一个确认的那种
function onlyConfirmButton(){
	showCustomAlertMessage "$1" "温馨提示" "好的" 1
} 
#onlyConfirmButton "登录成功!\n弹窗成功!"

# 多按钮弹窗 最多三个按钮 多了会报错
function mostButtons(){
	showCustomAlertMessage "$1" "温馨提示" "按钮1,按钮2,按钮3" "按钮3"
}
#mostButtons "最多只能定义三个按钮哦"

# 输入框弹窗
function showInputAlertMessage(){
	showCustomAlertMessage "$1" "$2" "取消,确认" 2 "1" ""
}
showInputAlertMessage "请输入密码" "登录验证"




