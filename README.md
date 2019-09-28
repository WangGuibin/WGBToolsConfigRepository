# WGBToolsConfigRepository
平时可能会用上的一些效率工具及配置,存放于此 
(基于`Alfred`的`workflows`, `vim`的配置文件,`zsh`的配置文件,`Xcode`主题配置)
[TOC]

#### 0. 点击`finder`上的图标即可快速跳转系统终端或者`iTerm`并`cd`至到当前目录下,该软件地址 https://zipzapmac.com/Go2Shell

#### 1. 配置Xcode主题,`CoderWGB Theme.xccolortheme`这个是我配置的,类似于`sublime`的风格, 配置之后肯定不想到了别的电脑上再配置一遍,很浪费时间的,毕竟时间就是命呐 !!!  Xcode主题文件的存放路径就在`~/Library/Developer/Xcode/UserData/FontAndColorThemes/` ,打开找到对应你自己自定义的主题,拷贝出来即可给到别的电脑上使用,也是这个路径. 

#### 2. Xcode真机调试包的路径：`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport` 
   [调试包资源](https://github.com/iGhibli/iOS-DeviceSupport) 或者 在`github`搜关键词`DeviceSupport` 
   [click me](https://github.com/search?utf8=%E2%9C%93&q=DeviceSupport&ref=simplesearch)

#### 3. 代码块 `~/Library/Developer/Xcode/UserData/CodeSnippets` 平时收藏的代码块都是存放在这的, 所以换公司换电脑异或是家里公司代码块同步如同此法,把代码块文件放进这里,重新启动`Xcode`即可食用。

#### 4. 显示Mac键盘操作动作指令的一个小工具 [前往地址](https://github.com/keycastr/keycastr) 

#### 5. 获取ipa文件里.car里的图片资源

a.   [cartool](<https://github.com/steventroughtonsmith/cartool>)   做个轮子用的人比较多,但是新版本的系统没有兼容,会crash之类的导致无法顺畅的使用,后来发现有网友修复了[查看#26](<https://github.com/steventroughtonsmith/cartool/pull/26/commits/93c1cedd304bb4b4ad987bb1be10e453536b9300>) , 需要加上一些代码兼容才能使用 (本仓库里有修复版本`cartool-master-fixed-Mojave-version`可以直接使用)

b. [AssetCatalogTinkerer](<https://github.com/insidegui/AssetCatalogTinkerer>) 这个轮子有人在维护,所以他目前是可以使用的, 傻瓜式的GUI,这个用起来比较爽,支持图片名模糊搜索,找到想要的直接拖拽出来,也可以批量全部导出, 但是唯一的缺点就是拖拽出来的图片.car里面还是会有一份,实际上是拖拽仅仅是拷贝出来的一份而已

#### 6. Xcode热重载插件(`目前只适用于模拟器`),提高开发效率的工具`InjectionIII` [使用教程](http://wangguibin.github.io/#/posts/Xcode辅助工具之热重载插件利器) 

#### 7. 在线图片压缩工具[无损压缩工具imageoptim](https://imageoptim.com/mac) 和 [PNG压缩工具](https://tinypng.com/) 以及[移除iOS项目无用图片工具](https://github.com/tinymind/LSUnusedResources)

#### 8. [json在线格式化工具](https://www.json.cn/) 和 [json转model在线工具](http://modelend.com/)

#### 9. [给定一张1024x1024的大图一键生成app的logo](https://icon.wuruihong.com)

#### 10. [在线绘制ASCi流程图](http://asciiflow.com/) 

#### 11. [一款不错免费录屏工具Kap](https://getkap.co/) 
#### 12. [coffeeipsum](http://coffeeipsum.com/) 一个自动生成英文文章的网站
#### 13. 记录获取网络ip的两个地址 [https://icanhazip.com](https://icanhazip.com) 和 [http://ifconfig.me/ip](http://ifconfig.me/ip) 
```objc
    NSURL *ipURL = [NSURL URLWithString:@"http://ifconfig.me/ip"];
    NSString *IPStr = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:nil];

```
#### 14. 统计当前目录下(iOS)的代码行数的shell命令,搭配 [Go2Shell](https://zipzapmac.com/Go2Shell)食用更佳
```shell
find . "(" -name "*.h" -or -name "*.mm" -or -name "*.m" -or -name "*.swift" ")" -print | xargs wc -l
``` 
#### 15. 防止甩锅(**`git blame`代码记录查询命令,`blame`字面意思是责怪，指责，怪...**) 搭配 [Go2Shell](https://zipzapmac.com/Go2Shell)食用更佳
```shell
git blame -L 22,30 Example.m #替换具体的代码行数和文件名即可
``` 


