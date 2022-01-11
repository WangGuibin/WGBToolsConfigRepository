新建窗口并执行shell指令

```bash
tell application "iTerm"
    set myterm to create window with default profile
    tell myterm
        activate current session
        launch session "Default Session"
        tell the current session
            write text "echo hello"
            write text "clear;"
            write text "date && cal" without newline
        end tell
        write (sessions of current tab) text linefeed
    end tell
end tell
```



新建tab, 并执行shell命令

```bash
tell application "iTerm"
	tell current window
		create tab with default profile
		tell current session
			write text "echo 'hello world~ ' "
		end tell
	end tell
end tell
```



配合自动操作选中`Podfile`文件增加快速操作菜单,创建新窗口并执行pod install

```bash
#新建窗口,选中Podfile 右键快速操作找到pod install这个菜单执行即可
PodfilePath="${1%/*}" 
osascript <<EOF
tell application "iTerm"
    set myterm to create window with default profile
    tell myterm
        activate current session
        launch session "Default Session"
        tell the current session
            write text "cd ${PodfilePath}"
            write text "clear;"
            write text "pod install" without newline
        end tell
        write (sessions of current tab) text linefeed
    end tell
end tell
EOF

# 或者新建tab
PodfilePath="${1%/*}" 
osascript <<EOF
tell application "iTerm"
	tell current window
		create tab with default profile
		tell current session
			      write text "cd ${PodfilePath}"
            write text "clear;"
            write text "pod install" without newline
		end tell
	end tell
end tell
EOF
```



使用Safari打开指定URL

```bash
function openWebLink(){
osascript <<EOF
tell application "Safari"
	activate
    tell window 1
        set current tab to (make new tab with properties {URL:"${1}"})
    end tell
end tell
EOF
}
```



Safari当前标签页执行一段js

```javascript
//CSDN或360Doc解锁文本
tell application "Safari" to do JavaScript "javascript:window.oncontextmenu=document.oncontextmenu=document.oncopy=null; [...document.querySelectorAll('body')].forEach(dom => dom.outerHTML = dom.outerHTML); [...document.querySelectorAll('body, body *')].forEach(dom => {['onselect', 'onselectstart', 'onselectend', 'ondragstart', 'ondragend', 'oncontextmenu', 'oncopy'].forEach(ev => dom.removeAttribute(ev)); dom.style['user-select']='auto'; dom.style['-webkit-touch-callout']='auto'; dom.style['-webkit-user-select']='auto'; dom.style['-ms-user-select']='auto';dom.style['-khtml-user-select']='auto'; dom.style['-moz-user-select']='auto';});" in document 1

```



Mac终端获取ip

```bash
#! /bin/bash
ifconfig | sed -e '/.*inet /!d;s///;s/ .*//' | tail -n 1
```



Mac暗黑模式切换

```bash
#!/bin/bash

dark='not dark mode'
Script="tell app \"System Events\" to tell appearance preferences to set dark mode to $dark"
osascript -e "$Script"
```



英文转大写

```bash
typeset -u text
text=$1
#拷贝到剪贴板
osascript -e 'set the clipboard to "'"${text}"'" as text'
```



英文转小写

```bash
typeset -l text
text=$1
#拷贝到剪贴板
osascript -e 'set the clipboard to "'"${text}"'" as text'
```



以上两个方法`Alfred`的终端可以执行,但是`iTerm2`执行不了(猜测是`typeset`被一些插件`alias`了),以下方法可代替

```bash
function to_lowercase()
{
    LOWER_CASE=$(echo ${1} | tr '[A-Z]' '[a-z]')
    echo ${LOWER_CASE}
}
 
function to_uppercase()
{
    UPPER_CASE=$(echo ${1} | tr '[a-z]' '[A-Z]')
    echo ${UPPER_CASE}
}
```



Mac启动台应用图标排列

```bash
#设置矩阵columns的数量
defaults write com.apple.dock springboard-columns -int 7
#设置矩阵rows的数量
defaults write com.apple.dock springboard-rows -int 6
#重启方可生效
defaults write com.apple.dock ResetLaunchPad -bool TRUE;killall Dock
```



github下载文件镜像加速(使用场景为浏览器打开时用的fastgit.org镜像,下载时为了兼容github.com走https://gh.api.99988866.xyz 所以有了这个)

```bash
query=$1

if [[  -n "${query}" ]];
then 
URL=${query/hub.fastgit.org/github.com}
openWebLink=https://gh.api.99988866.xyz/${URL}
else
pb=`pbpaste`
URL=${pb/hub.fastgit.org/github.com}
openWebLink=https://gh.api.99988866.xyz/$URL
fi

echo $openWebLink
```



Python开启本地webServer(用这个东西内网传东西方便)

```bash
#! /bin/bash
#调用: webServer -p 8080
IP=$(ifconfig | sed -e '/.*inet /!d;s///;s/ .*//' | tail -n 1)
IP_PORT=8080
while getopts "p:" opt; do
  case $opt in
    p)
       IP_PORT=$OPTARG
      ;;
    \?)
      IP_PORT=8080
      ;;
  esac
done

IPAddress="http://${IP}:${IP_PORT}"
CurrentDir=`pwd`
echo "🚀 当前目录为:${CurrentDir},WebServer已开启"
echo "🏡 地址为: ${IPAddress} 已拷贝至剪贴板📋"
echo "🔥 欢迎使用~ 组合键 Ctrl + C 即可退出🔥"

echo ${IPAddress} | pbcopy
python -m SimpleHTTPServer $IP_PORT
```



Xcode打开/编译/运行项目的shell工作流

```bash
#! /bin/bash

WorkspaceName="xxx.xcworkspace" #workspace文件名
FilePath="/xxx/xxx" #项目根目录路径

#打开项目
function LoadProject() {
osascript <<SCRIPT
    tell application "Xcode"
#    判断已经打开就关闭的代码 觉着用不上就注释了
#        open "$FilePath"
#        set workspaceDocument to workspace document "${WorkspaceName}"
#
#        repeat 120 times
#            if loaded of workspaceDocument is true then
#                close workspaceDocument
#                exit repeat
#            end if
#        end repeat

        open "$FilePath"
        set workspaceDocument_new to workspace document "${WorkspaceName}"
        set loadTime_Begin to (current date)

        repeat 1200 times
            if loaded of workspaceDocument_new is true then
                set loadTime_End to (current date)
                exit repeat
            end if
        end repeat
    end tell
SCRIPT
}


# 编译项目
function BuildProject() {
osascript <<SCRIPT
    tell application "Xcode"
        set actionResult to build workspace document 1
        set buildTime_Begin to (current date)
        repeat
            if completed of actionResult is true then
                set buildTime_End to (current date)
                exit repeat
            end if
        end repeat
        log "Build 开始时间" & (time string of (buildTime_Begin))
        log "Build 开始结束" & (time string of (buildTime_End))
        log "Build 总共耗时 :" & (buildTime_End - buildTime_Begin) & "秒"
    end tell
SCRIPT
}

# 运行项目
function RunProject() {
osascript <<SCRIPT
    tell application "Xcode"
        set actionResult to run workspace document 1
        set runTime_Begin to (current date)
        repeat
            if status of actionResult is running then
                set runTime_End to (current date)
                exit repeat
            end if
        end repeat
        log "Run 开始时间" & (time string of (runTime_Begin))
        log "Run 开始结束" & (time string of (runTime_End))
        log "Run 总共耗时 :" & (runTime_End - runTime_Begin) & "秒"
    end tell
SCRIPT
}

LoadProject
BuildProject
RunProject
```



Xcode指定模拟器编译&&打开指定模拟器

```bash
xcodebuild -scheme ProjectName -destination 'platform=iphonesimulator,name=iPhone 13 pro Max' -derivedDataPath ~/Desktop/buildData
xcrun instruments -w 'iPhone 13 pro Max'
```



 Xcode模拟器安装.app文件 && 自动打开指定App

```bash
xcrun simctl install booted "xxx.app" 
xcrun simctl launch booted "com.xxx.xxx" 
```

