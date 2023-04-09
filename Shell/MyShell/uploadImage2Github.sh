
filePath=$1
fileName=`date +"%Y_%m_%d_%H:%M:%S"`_${filePath##*/}
path="files"
repoName="ImageBed"
userName="WangGuibin"
github_token="xxxxxx"
suffix=${filePath##*.}
branchName="main" 

CommitMsg="MacBook Pro通过Shell脚本上传了一个${suffix}文件: "$fileName
Target_Img_URL="https://cdn.jsdelivr.net/gh/$userName/$repoName@${branchName}/$path/"$fileName


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
else
	echo $result | pbcopy
	osascript -e "display notification \"哎呀,出错啦~\" with title \"通知\" subtitle \"上传失败,请求结果已拷贝至剪贴板\""
fi
