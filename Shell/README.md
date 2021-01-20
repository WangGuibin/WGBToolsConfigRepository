## 1. `update_podspec.sh`是发布更新pod库的一个简化手动操作的脚本
## 2. `git_commit.sh`是一个提交代码的操作流程
## 3. `common_tool.sh`这个是一个脚本工具集合，前两个脚本也封装成方法了，菜单的形式，可以选择调用
## 4. `changeColor.sh`统一修改`XIB/Storyboard`色值
## 5. `imagesetGenerator.sh`通过`@3x`图片生成xcode的`assets`文件,基本操作`sh imagesetGenerator.sh  <@3x所在路径>`执行即可
## 6. 自定义终端启动图(文字版) 即自定义`./motd`文本文件,编辑完添加到 `/etc`目录下即可
```bash
#查看效果
cat /etc/motd
```
## 7. `iconVersion.sh`是打`Debug`包,修改`logo`显示一些版本信息的脚本
## 8. `dump_buildsettings.sh` 这个是`dump`出Xcode的环境变量
## 9. `剪贴板使用.sh` 记录了关于剪贴板相关的使用
## 10. `cut_string.sh`是字符串截取相关的练习
## 11. `if-else.sh`[关于if的用法](./if-else.sh)
## 12. `note.sh`[关于applescript脚本通知的用法](./note.sh)
## 13. `read-writeFile.sh`[关于文件操作的一些用法](./read-writeFile.sh)

[Shell/配置脚本环境变量访问](https://github.com/WangGuibin/WGBToolsConfigRepository/tree/master/Shell/%E9%85%8D%E7%BD%AE%E8%84%9A%E6%9C%AC%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%E8%AE%BF%E9%97%AE)