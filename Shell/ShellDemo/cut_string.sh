#! /bin/sh
# shell字符串截取相关 http://c.biancheng.net/view/1120.html 

# 		格式										说明
# ${string: start :length}		从 string 字符串的左边第 start 个字符开始，向右截取 length 个字符。
# ${string: start}				从 string 字符串的左边第 start 个字符开始截取，直到最后。
# ${string: 0-start :length}	从 string 字符串的右边第 start 个字符开始，向右截取 length 个字符。
# ${string: 0-start}			从 string 字符串的右边第 start 个字符开始截取，直到最后。
# ${string#*chars}				从 string 字符串第一次出现 *chars 的位置开始，截取 *chars 右边的所有字符。
# ${string##*chars}				从 string 字符串最后一次出现 *chars 的位置开始，截取 *chars 右边的所有字符。
# ${string%*chars}				从 string 字符串第一次出现 *chars 的位置开始，截取 *chars 左边的所有字符。
# ${string%%*chars}				从 string 字符串最后一次出现 *chars 的位置开始，截取 *chars 左边的所有字符。


TEXT="https://www.abc.com.cn/hhaha?a=b&c=d#tartget"

# 截取 https:// 
text1=${TEXT%www*}
echo $text1

# 截取www.abc.com.cn/hhaha?a=b&c=d#tartget
text2=${TEXT#*https://}
echo $text2

# 从左边开始截取 www.abc.com.cn
text3=${TEXT:8:14}
echo $text3

# 从右边开始截取 target
text4=${TEXT:0-7:7}
echo $text4

#从左边某个点起 www.abc.com.cn/hhaha?a=b&c=d#tartget
text5=${TEXT:8}
echo $text5

#从右边某个点起 target
text6=${TEXT:0-7}
echo $text6

# 匹配最后一个`/`  hhaha?a=b&c=d#tartget
text7=${TEXT##*/}
echo $text7

# 匹配去除所有 `ha` https://www.abc.com.cn/h
text8=${TEXT%%ha*}
echo $text8








