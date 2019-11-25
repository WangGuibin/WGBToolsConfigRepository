#!/bin/bash

showMenu() {

 echo "/**
 *
 *                    .::::.
 *                  .::::::::.
 *                 :::::::::::  
 *             ..:::::::::::'
 *           '::::::::::::'  美女镇楼 | 永无BUG
 *             .::::::::::
 *        '::::::::::::::..
 *             ..::::::::::::.
 *           ``::::::::::::::::
 *            ::::``:::::::::'        .:::.
 *           ::::'   ':::::'       .::::::::.
 *         .::::'      ::::     .:::::::'::::.
 *        .:::'       :::::  .:::::::::' ':::::.
 *       .::'        :::::.:::::::::'      ':::::.
 *      .::'         ::::::::::::::'         ``::::.
 *  ...:::           ::::::::::::'              ``::.
 * ```` ':.          ':::::::::'                  ::::..
 *                    '.:::::'                    ':'````.. 
 *           	
 * 			
 */"
	echo "======================================"
	echo "请选择需要执行的命令选项"
	echo "0. 输出 hello world "
	echo "1. 安装homebrew"
	echo "2. 安装cocoapods"
	echo "3. 卸载cocoapods"
	echo "4. 安装oh-my-zsh"
	echo "5. 安装carthage"
	echo "6. 日常提交git代码"
	echo "7. 发布更新pod组件"
	echo "8. git blame查询代码归属人"
	echo "9. 查询指定路径下iOS代码行数"
	echo "10. 查询当前网络ip地址"
	echo "======================================"
	
	read -p "输入选项编号：" number
	case $number in 
		0) helloWorld	
		;;
			
		1) installbrew
		;;
		
		2) installCocoapods
		;;

		3) unInstallCocoapods
		;;
		
		4) installOhMyZsh
		;;

		5) installCarthage
		;;

		6) commitGitRecord 
		;;

		7) publishUpdatePodSpecs
		;;

		8) gitblameCode
		;;

		9) totaliOSCodeRows
		;;

		10) searchCurrentNetworkIPAddress
		;;

	esac	
	#递归调用
	# showMenu
}

helloWorld() {
	echo "hello wor1d"
}

installbrew() {
	if ! type "brew" > /dev/null; then
		echo "将要开始安装brew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "已经安装homebrew"
	fi
}

installCocoapods() {
	sudo gem install cocoapods
}

unInstallCocoapods() {
	sudo gem list --local | grep cocoapods

	sudo gem uninstall cocoapods
	
	sudo gem uninstall cocoapods-core
	
	sudo gem uninstall cocoapods-downloader
	
	sudo gem uninstall cocoapods-plugins
	
	sudo gem uninstall cocoapods-search
	
	sudo gem uninstall cocoapods-stats
	
	sudo gem uninstall cocoapods-trunk
	
	sudo gem uninstall cocoapods-try

	sudo gem uninstall cocoapods-deintegrate

	sudo gem install cocoapods 

	pod setup
}

installOhMyZsh() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

installCarthage() {
	brew update
	brew install carthage
}

commitGitRecord() {
	read -p "输入提交日志信息: " commit_message
	read -p "输入分支名(默认为dev分支): " branch_name

	if [[ -n "$commit_message" ]]; then
		#statements
		echo "日志信息参数为: $commit_message"
	else
		echo "日志信息参数为空，已使用默认模板: 🚀update~"
		commit_message="🚀update~"
	fi

	if [[ -n "$branch_name" ]]; then
		#statements
		echo "分支名参数为: $branch_name "
	else
		echo "分支名参数未输入,默认为dev"
		branch_name="dev"
	fi

	git add .
	git commit -am  "$commit_message"
	git push origin ${branch_name}
}

publishUpdatePodSpecs() {
	echo "参数缺一不可,请按要求填写~"
	read -p "输入提交日志信息(有字就行): " commit_message
	read -p "输入版本号(和.podspec文件里的版本号保持一致): " version_number
	read -p "输入组件podspec_name名字(形如xxx.podspec需后缀): " podspec_name

	if [[ -n "$commit_message" ]]; then
		#statements
		echo "日志信息参数为: $commit_message"
	else
		echo "日志信息参数为空"
		commit_message="update~"
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
		echo "请填写组件podspec_name名字(形如xxx.podspec):"
	fi

	git add .
	git commit -am  "$commit_message"
	git tag  $version_number
	git push origin master --tags
	pod trunk push ./$podspec_name --allow-warnings --verbose

}

gitblameCode() {
	echo "查询代码归属人,参数请按要求填写~"
	read -p "输入代码文件路径: " code_path
	read -p "输入代码行数起点: " code_start_row
	read -p "输入代码行数终点: " code_end_row

	git blame -L ${code_start_row},${code_end_row} ${code_path}  
}

totaliOSCodeRows() {
	read -p "输入代码文件所在路径: " code_path

	find ${code_path} "(" -name "*.h" -or -name "*.mm" -or -name "*.m" -or -name "*.swift" ")" -print | xargs wc -l 
}

searchCurrentNetworkIPAddress() {
	curl http://ifconfig.me/ip
}

####################################################
showMenu

