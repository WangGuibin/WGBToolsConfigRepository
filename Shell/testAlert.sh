#!/bin/bash

function showInputAlert(){

osascript <<EOT
set titleStr to "测试文本输入框"
set btns to {"button1", "button2", "button3"}
display dialog titleStr buttons btns default button 1 default answer "这是默认文本"
--set returnRecord to the result --获取返回的record类型的值
--get the text returned of returnRecord  -- 获取输入的文本
EOT
#返回值=> button returned:button2, text returned:这是默认文本
}

 showInputAlert


