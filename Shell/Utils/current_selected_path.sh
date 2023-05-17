#! /bin/bash

# 获取当前选中的文件或者文件夹路径
CurrentSelectPath=$(osascript <<EOF
tell application "Finder"
    set theItems to selection
    set filePath to (POSIX path of (the selection as alias))
  end tell
  set q to filePath
  return q
EOF
)
echo $CurrentSelectPath
