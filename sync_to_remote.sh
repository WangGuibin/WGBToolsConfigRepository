#! /bin/bash

SRC_PATH=`pwd`

rm -fr ${SRC_PATH}/CodeSnippetsBackup
mv ${SRC_PATH}/CodeSnippets ${SRC_PATH}/CodeSnippetsBackup
rm -fr ${SRC_PATH}/CodeSnippets
cp -fr ~/Library/Developer/Xcode/UserData/CodeSnippets ${SRC_PATH}

if [[ $1 = "git" ]]; then
git add .
git commit -m "update configure"
git push
fi

echo 'sync to remote done'