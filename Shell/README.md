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

[Shell/配置脚本环境变量访问](https://github.com/WangGuibin/WGBToolsConfigRepository/tree/master/Shell/%E9%85%8D%E7%BD%AE%E8%84%9A%E6%9C%AC%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%E8%AE%BF%E9%97%AE)