# 设置剪贴板
setClip() {
 osascript -e 'set the clipboard to "'"${*}"'" as text'
}

# 获取剪贴板
getClip() {
 if [ "$(osascript -e 'clipboard info' | grep '«class utf8»')" != "" ];then
   echo $(osascript -e "get the clipboard as «class utf8»" | sed "s/utf8»//; s/»//")
 else
   echo ''
 fi
}

setClip "哈哈哈哈哈" "牛啊牛逼啊" "就这就这"

TEXT=$(getClip)

echo $TEXT

# 简单方式
echo "Welcome To OSTechNix!" | pbcopy
echo `pbpaste`
