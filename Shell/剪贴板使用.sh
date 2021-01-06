#设置剪贴板 写了两个Alfred 英文转大小写 将结果拷贝至剪贴板 节省时间提升效率
osascript -e 'set the clipboard to "'"${*}"'" as text'

#获取剪贴板内容
$(osascript -e "get the clipboard as «class utf8»" | sed "s/utf8»//; s/»//")

ls | pbcopy  #把ls内容拷贝到剪贴板
echo "xxxxx" | pbcopy #拷贝echo的内容
du -sh * | pbcopy #把当前目录的磁盘占用情况拷贝至剪贴板
pbcopy < README.md # 文件内容拷贝至剪贴板
pbpaste > file.txt #获取剪贴板内容并写入到文件

echo ${*}  
#会逐个参数用空格拼起来 rar压缩的时候就是这样操作的 
#rar a new.rar file1 file2 file3 ...  workflow里的shell入参 ${*}则会列举出所有的路径
#即 rar a new.rar ${*} #要加大括号 不然会报错 