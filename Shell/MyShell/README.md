[TOC]



####  addRepo

```
这个是本地创建了一个新的项目,尚未git管理或者未关联远程库,此时创建了一个远程库,需要添加关联
所以这个脚本是关联远程库的作用
```



####  common_tool

```
封装了一些常用的菜单选项
比如
echo "0. 输出 hello world "
	echo "1. 安装homebrew"
	echo "2. 安装cocoapods"
	echo "3. 卸载重装cocoapods"
	echo "4. 安装oh-my-zsh"
	echo "5. 安装carthage"
	echo "6. 日常提交git代码"
	echo "7. 发布更新pod组件"
	echo "8. git blame查询代码归属人"
	echo "9. 查询指定路径下iOS代码行数"
	echo "10. 查询当前网络ip地址"
	echo "11. 清除终端代理设置"
	echo "12. 内网穿透,用于外网访问演示预览(钉钉穿透)"  #已删除该脚本 
	echo "13. 解决MacApp第一次安装打开提示已损坏,移到废纸篓弹窗"
	echo "14. 解决MacApp第一次安装打开闪退问题"
```



####  gh-md-toc

```
一个Markdow文件TOC目录生成工具,比如一个Markdow文件里有分多级标题就可以使用该工具
sh gh-md-toc xxx.md  即可 命令行就会生成相对应的Markdow格式目录代码
```



####   github_file_download

```
会把github blob二进制文件下载到桌面  使用https://cdn.jsdelivr.net/gh/替换github.com域名
sh github_file_download + 链接(如: https://github.com/xx/Txxel/blob/master/Tiercel.podspec)
```



####  ip

```
#如下代码的封装 获取本机ip
ifconfig | sed -e '/.*inet /!d;s///;s/ .*//' | tail -n 1
```



####  pgyer_upload_ipa

```
上传ipa 注意替换key值
简单调用 pgyer_upload_ipa /User/xxx/app.ipa
```



#### switch_dark_mode

```
切换暗黑模式和浅色模式
```



####  toggle_desktop

```
显示桌面和隐藏桌面图标,适用隐私截图场景
```



####  uploadImage2Github.sh

```
github图床
```



####  webServer

```
基于Python开启一个本地webServer
```



####  sendMessage.py

```py
自定义发送邮件   
python3 sendMessage.py -t  "['864562082@qq.com','1024732985@qq.com']" -s "一封问候邮件" -m "假装这是一封情书💌"
```

