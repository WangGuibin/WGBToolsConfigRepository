#!/bin/sh

IPA_PATH=$1

echo "======================START======================"
echo "-----------------Ipa Info Checker----------------"
echo "--------------Created by Irving Huang------------"
echo "----------------Sinyi Realty Inc.----------------"

# 检查参数
if [ ! ${#IPA_PATH} -ge 1 ]; then
  echo "No parameter: Please type as 'sh IpaInfo.sh IPA_PATH'"
  echo "=======================End======================="
  exit 1
fi

if [ "${IPA_PATH##*.}" != "ipa" ]; then
  echo "Error: file is not an ipa archive."
  echo "=======================End======================="
  exit 1
fi

if [ ! -f "$IPA_PATH" ]; then
  echo "Error: ipa file was not found."
  echo "=======================End======================="
  exit 1
fi

IPA_FOLDER=$(dirname $IPA_PATH)
IPA_NAME=$(basename $IPA_PATH)

echo "Start with: $IPA_NAME ..."

# 清除Payload以避免与解压缩结果重复
if [ -d "$IPA_FOLDER/Payload" ]; then
  isPayload="y"
  read -p "Payload Founded. Remove it? (y/n)" isPayload
  if [ "$isPayload" == "y" ]; then
    echo "-> Removing current Payload directory"
    rm -rf "$IPA_FOLDER/Payload"
  fi
fi

echo "Unzip $IPA_NAME ..."
unzip "$IPA_PATH" -d "$IPA_FOLDER" > /dev/null
echo "Get Info..."

APP_FOLDER_NAME=$(ls "$IPA_FOLDER/Payload")
APP_FOLDER_PATH="$IPA_FOLDER/Payload/$APP_FOLDER_NAME"
APP_INFO_PATH="$APP_FOLDER_PATH/Info.plist"

APP_BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$APP_INFO_PATH")
APP_VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "$APP_INFO_PATH")
FILE_SIZE=$(stat -f %z "$IPA_FOLDER")
# CurrentDate=$(date '+%Y-%m-%d')
#读取ipa文件修改时间
TIMESTAMP=$(stat -f "%m" "$IPA_FOLDER")
MODIFIED_DATE=$(date -r $TIMESTAMP "+%Y-%m-%d")


RESULT_PATH="$IPA_FOLDER/${IPA_NAME%.*}.json"

appInfo=$(cat <<EOF 
{
  "name": "${IPA_NAME%.*}",
  "bundleIdentifier": "$APP_BUNDLE_ID",
  "version": "${APP_VERSION}",
  "versionDate": "${MODIFIED_DATE}",
  "versionDescription": "仅砸壳",
  "size": ${FILE_SIZE},
  "downloadURL": "https://github.com/WangGuibin/IPA-for-self/releases/download/1.0.0/${IPA_NAME%.*}.ipa",
  "developerName": "",
  "localizedDescription": "",
  "iconURL": "https://cdn.jsdelivr.net/gh/WangGuibin/IPA-for-self@main/icons/${IPA_NAME%.*}.png"
},
EOF
)

#写个json 后面再编辑合并
echo $appInfo > $RESULT_PATH
mv $RESULT_PATH apps/${IPA_NAME%.*}.json
echo "Remove Payload..."
# rm -rf "$IPA_FOLDER/Payload"
