# 获取当前Safari打开的网页的标题和链接生成markdown链接格式

核心代码如下: 配合一个快捷键或者keyword启动即可获取 [title](link) 格式的文本, 获取成功之后会同步到剪贴板,应用场景在于写博客需要引经据典的时候效率更高~ 还是比较实用的
```bash
on alfred_script(q)

tell application "Safari" 
	set theTitle to name of current tab in window 1
	set theURL to URL of current tab of window 1
	set markdown to "- [" & theTitle & "](" & theURL & ")"
end tell
return  markdown
end alfred_script
```
