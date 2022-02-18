# 调用 sh pgyer_upload_ipa.sh /User/xxx/app.ipa
# $1 ipa的路径
if [[ -n "${1}" ]]; then
	ipaName=${1##*/} 
	cd  $(dirname $1)
	api_key='⚠️请替换api_key'
	result=$(curl -F 'file=@'$ipaName -F '_api_key='$api_key https://www.pgyer.com/apiv2/app/upload)
	ShortcutUrl_01=${result#*buildShortcutUrl\":\"}
	ShortcutUrl=${ShortcutUrl_01%%\"*}
	ipa_url=https://www.pgyer.com/"$ShortcutUrl"
	echo "$ipa_url" | pbcopy
	osascript -e "display notification \"测试包ipa上传成功🚀🚀🚀: "${ipa_url}" \" with title \"通知\" subtitle \"链接🔗已拷贝至剪贴板\" sound name \"Funk\""

else
	echo "调用 sh pgyer_upload_ipa.sh [ipa path] 需要传入ipa完整路径参数"
fi
