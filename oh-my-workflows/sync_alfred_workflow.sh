#!/bin/bash 
# 每次执行脚本,拉取Alfred本地配置目录已有数据与仓库上次的备份数据进行合并 
# 将合并之后的备份数据再同步到Alfred本地配置目录中
# 与代码块的同步机制类型,拉取仓库与本地的合并以保证最新最全的数据
# 执行 sh sync_alfred_workflow.sh 即可 

if [[ ! -d './workflows_backup' ]];
then
    mkdir ./workflows_backup
fi

if [[ ! -d './workflows' ]];
then
    mkdir  ./workflows
fi

echo "\033[1;32m请稍等片刻,正在同步数据中...\033[m"
cp -rf ~/Library/Application\ Support/Alfred/Alfred.alfredpreferences/workflows/*  ./workflows_backup/ 
cp -r ./workflows_backup/* ./workflows/
cp -r ./workflows/*  ~/Library/Application\ Support/Alfred/Alfred.alfredpreferences/workflows/
echo "\033[1;32m🎉 同步成功!!\033[m"