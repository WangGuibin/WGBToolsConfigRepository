#!/bin/bash

<<QA
##### 第一种写法 ######   注意 第一种写法是不能加语句的
if(表达式);
fi


##### 第二种写法 #####
if(表达式);then
    语句
elif(表达式)
    语句
else
    语句
fi
QA


echo << EOF
#条件测试的表达式：
[ expression ]  括号两端必须要有空格
[[ expression ]] 括号两端必须要有空格

组合测试条件：
-a and
-o or
!  非

#整数比较:
&& 与
|| 或
-eq 测试两个整数是否相等
-ne 测试两个整数是否不等
-gt 测试一个数是否大于另一个数
-lt 测试一个数是否小于另一个数
-ge 大于或等于
-le 小于或等于

#字符串比较:
== 等于  两边要有空格
!= 不等
>  大于
<  小于

#文件测试:
-z string 测试指定字符是否为空，空则真，非空为假
-n string 测试指定字符串是否为不空，空为假 非空为真
-e file 测试文件是否存在
-f file 测试文件是否为普通文件
-d file 测试指定路径是否为目录
-r file 测试文件对当前用户是否可读
-w file 测试文件对当前用户是否可写
-x file 测试文件对当前用户是都可执行
-z  是否为空  为空则为真
-a  是否不空
-s	文件存在且不为空
-b	文件存在并且是一个块设备
-L	文件存在并且是一个软连接
EOF


PATH1="/Users/wangguibin/Desktop"
PATH2="/Users/wangguibin/Desktop/test.text"
PATH3="/Users/wangguibin"

#判断文件存在与否 使用 `-f`
if [[ -f "${PATH2}" ]]; then
	echo "存在test.txt"
else
	echo "不存在test.txt"
fi

if [[ ! -f "${PATH2}" ]]; then
	echo "不存在test.txt"
else
	echo "存在test.txt"
fi

#判断目录存不存在用`-d`,if-else可以嵌套使用
if [[ -d "${PATH1}" ]]; then
	echo "存在Desktop这个目录"
	if [[ -f "$PATH2" ]]; then
		echo "且存在test.txt"
	fi

	if [[ ! -f "$PATH2" ]]; then
		echo "且bu存在test.txt"
	fi
fi


# && || 与 或 这些表达式的时候需要双重括号 -a (and) -o (or)的时候单括号  
if [ -d "$PATH1" -o -f "$PATH2" ]; then
	echo "目录与文件必然有一个存在,才会走这"
fi

if [[ -d "$PATH1" || -f "$PATH2" ]]; then
	echo "目录与文件必然有一个存在,才会走这"
fi

if [[ -d "$PATH1" && -d "$PATH3" ]]; then
	echo "两个目录同时存在"
fi

if [ -d "$PATH1" -a -d "$PATH3" ]; then
	echo "两个目录同时存在"
fi

 # 参数不为空
if [[ -n "$1" ]]; then
	echo "运行本脚本传的第一个参数是: $1 "
	else
	echo "传参为空"
fi

if [[ ! -n "$1" ]]; then
	 echo "传参为空"
fi




