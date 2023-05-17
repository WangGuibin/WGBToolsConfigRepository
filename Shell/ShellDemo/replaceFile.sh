#! /bin/bash
targetPath="/Users/wangguibin/Desktop/Demo/RecordScreenDemo/hh.jpg"
zip -qryX ./hh.jpg  *
mv -f ./hh.jpg $targetPath
rm -rf ./hh.jpg
echo "\033[32;49;1m 已完成备份\033[39;49;0m"
