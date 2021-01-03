# WGBToolsConfigRepository

# 此库记录平时用到的一些效率工具以及配置

- [iOS相关](#ios)
- [Mac终端相关](#mac)
- [图片处理](#image)
- [json工具](#json)
- [文档工具](#doc)
- [奇技淫巧](#other)





<h3 id="ios"> iOS相关 </h3>

[Xcode快捷键操作](../Xcode快捷键操作.md)

- 统计iOS代码行数
```bash
find . "(" -name "*.h" -or -name "*.mm" -or -name "*.m" -or -name "*.swift" ")" -print | xargs wc -l 
```

<details>
<summary> 配置Xcode主题 </summary>
  在./Xcode Theme里是一些收集的主题,其中
CoderWGB Theme.xccolortheme这个是我配置的,类似于sublime的风格, 配置之后肯定不想到了别的电脑上再配置一遍,很浪费时间的,毕竟时间就是命呐 !!!  Xcode主题文件的存放路径就在~/Library/Developer/Xcode/UserData/FontAndColorThemes/ ,打开找到对应你自己自定义的主题,拷贝出来即可给到别的电脑上使用,也是这个路径.
  当然能用脚本实现更加科学咯,可参考这个项目 <a href="https://github.com/hdoria/xcode-themes">https://github.com/hdoria/xcode-themes</a><br>
其中CoderWGB theme 需要安装<a href="https://www.jetbrains.com/lp/mono">jetbrains字体</a>
</details>

<details>
<summary> 代码块 </summary>
 ~/Library/Developer/Xcode/UserData/CodeSnippets 平时收藏的代码块都是存放在这的, 所以换公司换电脑异或是家里公司代码块同步如同此法,把代码块文件放进这里,重新启动Xcode即可食用。也可使用脚本来管理关联代码块,例如这个项目<a href="https://github.com/FantasticLBP/codesnippets">https://github.com/FantasticLBP/codesnippets</a>
</details>

<details>
<summary> Xcode真机调试包 </summary>
经常遇到手机系统版本高于Xcode SDK版本,导致无法调试,需要下载调试包兼容.
Xcode真机调试包的路径：`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport`, 
可在 github 搜关键词 DeviceSupport 
  <p>调试包资源 <a href="https://github.com/iGhibli/iOS-DeviceSupport">https://github.com/iGhibli/iOS-DeviceSupport</a> </p>
   或者  <span>点击搜索 <a href="https://github.com/search?utf8=%E2%9C%93&q=DeviceSupport&ref=simplesearch">https://github.com/search?utf8=%E2%9C%93&q=DeviceSupport&ref=simplesearch</a> </span>
</details>

<details>
<summary> 获取IPA里.car文件里的图片资源 </summary>
1. <a href="https://github.com/steventroughtonsmith/cartool">cartool</a>  做个轮子用的人比较多,但是新版本的系统没有兼容,会crash之类的导致无法顺畅的使用,后来发现有网友修复了查看<a href="https://github.com/steventroughtonsmith/cartool/pull/26/commits/93c1cedd304bb4b4ad987bb1be10e453536b9300">issues#26</a> , 需要加上一些代码兼容才能使用 (本仓库里有修复版本cartool-master-fixed-Mojave-version可以直接使用)

2. <a href="https://github.com/insidegui/AssetCatalogTinkerer">AssetCatalogTinkerer</a> 这个轮子有人在维护,所以他目前是可以使用的, 傻瓜式的GUI,这个用起来比较爽,支持图片名模糊搜索,找到想要的直接拖拽出来,也可以批量全部导出, 但是唯一的缺点就是拖拽出来的图片.car里面还是会有一份,实际上是拖拽仅仅是拷贝出来的一份而已
</details>

<details>
<summary> InjectionIII,Xcode热重载插件 </summary>
提高开发效率的工具,方便调试UI,目前仅适用于模拟器(真机连局域网听说是可以但没尝试...) <a href="https://github.com/johnno1962/InjectionIII/releases"> InjectionIII </a>
</details>

- 部署Xcode项目临时模板 点击 [自定义Xcode顶部描述信息](./自定义Xcode顶部描述信息/README.md)
-  [约束警告排查](https://www.wtfautolayout.com/) 
- [App隐私政策生成](https://app-privacy-policy-generator.firebaseapp.com/#)


<h3 id="mac"> Mac终端相关 </h3>
<details>
<summary> keycastr Mac键盘操作动作指令的一个小工具 </summary>
  显示用户键盘操作指令,常用于录屏教程示范等
  <a href="https://github.com/keycastr/keycastr">https://github.com/keycastr/keycastr</a>
</details>

`rar`解压 `brew install unrar`
```objc
unrar x *.rar
```

<details>
<summary> Go2Shell 快速进入终端并cd到当前目录的一款mac目录插件 </summary>
点击finder上的图标即可快速跳转系统终端或者iTerm并cd至到当前目录下,该软件地址 <a href="https://zipzapmac.com/Go2Shell"> https://zipzapmac.com/Go2Shell </a>
</details>

- [一款免费的录屏工具Kap](https://getkap.co/) 
- 一款统计键盘鼠标敲击次数的mac应用 [中文教程](https://zhuanlan.zhihu.com/p/21787949)  [下载地址](https://github.com/KonsomeJona/OctoMouse/releases) 
-  [Mac调整屏幕分辨率工具](https://github.com/avibrazil/RDM) 
- [自用shell脚本集合](https://github.com/WangGuibin/WGBToolsConfigRepository/blob/master/Shell/README.md)
-  [MacOS 状态栏隐藏工具](https://github.com/dwarvesf/hidden)
- [脑图工具](https://gitmind.cn)



<h3 id="image"> 图片处理 </h3>

- 无损压缩工具 [imageoptim](https://imageoptim.com/mac)
- PNG压缩工具 [tinypng](https://tinypng.com/)
- 移除iOS项目无用图片工具 [LSUnusedResources](https://github.com/tinymind/LSUnusedResources)
- 喵神的Fengniao命令行工具[FengNiao](https://github.com/onevcat/FengNiao) 
- fdupes移除重复资源命令行工具 [fdupes](https://github.com/adrianlopezroche/fdupes)
- [图标工场](https://icon.wuruihong.com)
- [在线抠图1](https://bgeraser.com/index.html) 
- [在线抠图2](https://www.remove.bg/zh)
- [iconfont](https://www.iconfont.cn)
- [免费图片](https://pixabay.com)
- [AsciiSignature字符空心字](http://www.kammerl.de/ascii/AsciiSignature.php)
- [asciiflow字符流程图](http://asciiflow.com/)
- [asciiworld代码注释各种花样](http://www.asciiworld.com)
- [在线绘制UML或者流程图](https://app.diagrams.net)

<h3 id="json"> json工具 </h3>

- [json在线格式化工具](https://www.json.cn/) 
- [json转model在线工具](http://modelend.com/) [备用地址](https://soar-coding-life.github.io/json2modelLocalTool/index.html)



<h3 id="doc"> 文档工具 </h3>

- [文档部署工具docsify](https://docsify.js.org/#/zh-cn/quickstart)  需要repo本地根目录先创建docs文件夹,git-pages里的`master branch/docs folder`选项才能被选择  [参考了文章](https://juejin.im/post/5b14b2f06fb9a01e5e3d3121) 
- [一个开源的图床工具](https://github.com/Molunerfinn/PicGo)
```html
<!-- 免费的CDN小技巧 https://cdn.jsdelivr.net/gh/<username>/<repoName>/xxx/xxx 真的香~  -->
![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/avatar.png)
```
- [markdown工具之mdnice](https://www.mdnice.com)


<h3 id="tr"> 翻译工具 </h3>

- [一个好用的翻译插件](https://github.com/ripperhe/Bob)

<h3 id="other"> 奇技淫巧 </h3>

-  [自动生成英文文章](http://coffeeipsum.com/) 
-  [狗屁不通文章生成器](https://suulnnka.github.io/BullshitGenerator/index.html)
- [对对联系统](https://ai.binwang.me/couplet/)
- [微信公众号文章素材提取](http://www.91store.club/?adtag=basic.web.js)
- [github只下载部分目录的文件](http://zhoudaxiaa.gitee.io/downgit/#/home)
- [gitzip 下载部分目录(需要token授权)](https://kinolien.github.io/gitzip/)
- [github文件下载加速](https://shrill-pond-3e81.hunsh.workers.dev)
- [github仓库点击量统计](http://hits.dwyl.io)
- [生成svg徽章角标](https://shields.io)
- [漂亮的代码图片](https://carbon.now.sh)
- [消除人声获取伴奏](https://vocalremover.org/ch/)






