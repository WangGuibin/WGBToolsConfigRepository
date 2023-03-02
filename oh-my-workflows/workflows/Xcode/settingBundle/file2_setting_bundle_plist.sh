#!/bin/bash 
# 获取setting bundle 描述 
# 通过group footerText进行展示文本的内容
# 封装成自动操作 更方便把需要展示的文本文件转成plist格式 外部读取文本文件 传入文件路径地址即可
# cat 读取之后 echo 写入 重定向一下保存为plist文件

text=$(echo "`cat $1`")  
#对特殊符号进行处理
text=$(echo "${text//&/&amp;}")
text=$(echo "${text//</&lt;}")
text=$(echo "${text//>/&gt;}")

plistContent=$(cat <<EOF 
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PreferenceSpecifiers</key>
	<array>
		<dict>
			<key>FooterText</key>
			<string>${text}</string>
			<key>Title</key>
			<string></string>
			<key>Type</key>
			<string>PSGroupSpecifier</string>
		</dict>
	</array>
	<key>StringsTable</key>
	<string>detail</string>
</dict>
</plist>
EOF
)
echo "$plistContent" > "${1%.*}".plist
