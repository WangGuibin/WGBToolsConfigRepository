#! /bin/bash

RESULT_PATH="ipa.json"

#读取目录下的所有app jsons数据
find "apps" -type f -name "*.json" -exec cat {} \; >> output.txt
# 读取并拼接成字符串
content=$(<output.txt)
apps=$(echo $content | sed 's/,$//')

appData=$(cat <<EOF 
{
    "name": "CoderWGB's AppSource",
    "message": "supported for easy sign or TrollStore enjoy~",
	"sourceicon": "https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/20210614114348.png",
    "identifier": "com.coderwgb.ipaApps",
    "sourceURL": "https://cdn.jsdelivr.net/gh/WangGuibin/IPA-for-self@main/ipa.json",
    "apps": [
        ${apps}
    ]
}
EOF
)

echo $appData  | python -m json.tool > $RESULT_PATH
rm -rf output.txt


