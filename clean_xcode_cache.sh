echo "🌸执行本脚本旨在清除缓存以及临时解决Xcode 10以上出现代码无提示的BUG 执行脚本提升工作效率🌸"

#打开代码索引命令
defaults write com.apple.dt.XCode IDEIndexDisable 0
echo "代码索引命令已打开"

rm -rf ~/Library/Developer/Xcode/DerivedData
echo "🚀已删除 DerivedData 目录🚀"

rm -rf ~/Library/Caches/com.apple.dt.Xcode
echo "🚀已删除 com.apple.dt.Xcode 文件🚀"

# 关闭Xcode 
killall Xcode

echo "请手动重启Xcode~ 等待processing index 完毕（如果仍无代码提示，建议重启电脑再次执行此操作）enjoy it!🎉🎉"

