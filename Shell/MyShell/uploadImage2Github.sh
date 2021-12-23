
filePath=$1
fileName=`date +%Y%m%d`${filePath##*/}.${1##*.}
path="仓库具体目录"
repoName="仓库名"
userName="github用户名"
github_token="填写你自己的github token"

CommitMsg="Mac通过Shell脚本上传了一张图片"$fileName
Target_Img_URL="https://cdn.jsdelivr.net/gh/$userName/$repoName/$path/"$fileName

Base64_Content=$(base64 -b 0 $filePath)  
API_URL="https://api.github.com/repos/$userName/$repoName/contents/$path/"${fileName}
Acess_Token="token $github_token"
osascript -e "display notification \"${filePath##*\/}正在上传中ing...\" with title \"通知\" subtitle \"请耐心等待,正在拼命上传...\""
result=$(curl \
  -X PUT \
  -H "Content-Type:application/json"\
  -H "Authorization:$Acess_Token" \
  -H "Accept:application/vnd.github.raw"\
  ${API_URL} \
  -d "{\"message\":\"${CommitMsg}\",\"content\":\"${Base64_Content}\"}")

IsUpload=`echo $result | grep "committer"`
if [[ -n "$IsUpload" ]]; then
	echo $Target_Img_URL | pbcopy
	osascript -e "display notification \"$Target_Img_URL\" with title \"通知\" subtitle \"上传成功,地址已拷贝至剪贴板\""
fi
