#!/bin/bash

read -p "输入提交日志信息: " commit_message

read -p "输入分支名(默认为dev分支): " branch_name


if [[ -n "${commit_message}" ]]; then
	#statements
	echo "日志信息参数为: ${commit_message}"
else
	echo "日志信息参数为空，已使用默认模板: 🚀update~"
	commit_message="🚀update~"
fi

if [[ -n "${branch_name}" ]]; then
	#statements
	echo "分支名参数为: ${branch_name}"
else
	echo "分支名参数未输入,默认为dev"
	branch_name="dev"
fi

git add .
git commit -am  "${commit_message}"
git push origin ${branch_name}
