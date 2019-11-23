#!/bin/bash

read -p "输入提交日志信息: " commit_message

read -p "输入版本号: " version_number

read -p "输入组件podspec_name名字(形如test.podspec): " podspec_name

if [[ -n "$commit_message" ]]; then
	#statements
	echo "日志信息参数为: $commit_message"
else
	echo "日志信息参数未输入"
fi

if [[ -n "$version_number" ]]; then
	#statements
	echo "版本号参数为: $version_number "
else
	echo "版本号参数未输入"
fi

if [[ -n "$podspec_name" ]]; then
	#statements
	echo "组件名字参数为: $version_number "
else
	echo "请填写组件podspec_name名字(形如test.podspec):"
fi

git add .
git commit -am  "$commit_message"
git tag  $version_number
git push origin master --tags
pod trunk push ./$podspec_name --allow-warnings --verbose
