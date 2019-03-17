# WGBToolsConfigRepository
收集一些效率工具的配置,存放于此

(基于`Alfred`的`workflows`, `vim`的配置文件,`zsh`的配置文件,`Xcode`主题配置)

#### 1. 配置Xcode主题,`CoderWGB Theme.xccolortheme`这个是我配置的,类似于`sublime`的风格, 配置之后肯定不想到了别的电脑上再配置一遍,很浪费时间的,毕竟时间就是命呐 !!!  Xcode主题文件的存放路径就在`~/Library/Developer/Xcode/UserData/FontAndColorThemes/` ,打开找到对应你自己自定义的主题,拷贝出来即可给到别的电脑上使用,也是这个路径. 

#### 2. workflow网上收集的,都是些常用到的工具工作流,那就叫它快捷方式吧,iOS 12 iphone版的workflow更名为'捷径',支持中文了(之前是全英文...),可能并没有什么太花哨的姿势,确实是可以节省很多时间的,那种高频次的操作,节省下来都是时间(命)啊, 无论是网站还是应用,界面越来越简单了全是用搜索的,可能这是未来的趋势啊 shortcut

#### 3. 代码块 `~/Library/Developer/Xcode/UserData/CodeSnippets` 平时收藏的代码块都是存放在这的, 所以换公司换电脑异或是家里公司代码块同步如同此法,把代码块文件放进这里,重新启动`Xcode`即可食用。

#### 4. 显示Mac键盘操作动作指令的一个小工具 [前往地址](https://github.com/keycastr/keycastr) 

#### 5. 获取ipa文件里.car里的图片资源

a.   [cartool](<https://github.com/steventroughtonsmith/cartool>)   做个轮子用的人比较多,但是新版本的系统没有兼容,会crash之类的导致无法顺畅的使用,后来发现有网友修复了[查看#26](<https://github.com/steventroughtonsmith/cartool/pull/26/commits/93c1cedd304bb4b4ad987bb1be10e453536b9300>) , 需要加上一些代码兼容才能使用 (本仓库里有修复版本`cartool-master-fixed-Mojave-version`可以直接使用)

b. [AssetCatalogTinkerer](<https://github.com/insidegui/AssetCatalogTinkerer>) 这个轮子有人在维护,所以他目前是可以使用的, 傻瓜式的GUI,这个用起来比较爽,支持图片名模糊搜索,找到想要的直接拖拽出来,也可以批量全部导出, 但是唯一的缺点就是拖拽出来的图片.car里面还是会有一份,实际上是拖拽仅仅是拷贝出来的一份而已
