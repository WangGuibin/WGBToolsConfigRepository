#! /bin/bash

SRC_PATH=`pwd`

if [[ $1 = "git" ]]; then
  git pull
fi

rm -fr ${SRC_PATH}/CodeSnippetsBackup
mv ~/Library/Developer/Xcode/UserData/CodeSnippets ${SRC_PATH}/CodeSnippetsBackup
cp -fr ${SRC_PATH}/CodeSnippets ~/Library/Developer/Xcode/UserData/

echo 'sync to local done'