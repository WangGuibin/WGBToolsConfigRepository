## 自定义工程文件顶部描述信息

#### 作用和意义何在？
- 记录代码信息或者仓库地址信息
- 记录时间，邮箱联系方式，博客链接等信息
- 记录创建者以及作者版权等信息
- 软件许可声明

普通系统自带样式

```objc
//
//  HPPostDetailViewController.m
//  DY-ios
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 YGC. All rights reserved.
//

```

参考AFNetworking的`AFHTTPSessionManager`

```objc
// AFHTTPSessionManager.h
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
```
参考了 [杭城小刘-自定义工程中的头部描述信息](https://github.com/FantasticLBP/knowledge-kit/blob/master/%E7%AC%AC%E4%B8%80%E9%83%A8%E5%88%86%20iOS/1.55.md) 

1. 创建`IDETemplateMacros.plist`文件，并添加自定义模板信息
```objc

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>FILEHEADER</key>
	<string>
// ___FILENAME___
// ___PACKAGENAME___
//
// author:  XXX
// github:  https://github.com/XXXX
// e-mail:  0x00@outlook.com
//
// Created by xxxx on ___DATE___
// LICENSE 。。。。 信息等一大段英文文字描述
    </string>
</dict>
</plist>

```

#### 文件预编译的几个宏释义 
```objc
___FILENAME___ 文件名包括后缀
___PROJECTNAME___ 工程名
___FULLUSERNAME___ 用户的名字，这里也可以直接写死为自己的名字xxx
___DATE___ 当前日期，年/月/日
___COPYRIGHT___ 版权
___FILEBASENAME___ 不带后缀的文件名
___FILEBASENAMEASIDENTIFIER___ 不带后缀的文件名

```
### 注意： 这里介绍的方式是临时修改一个项目的文件模板方式


2. 将编写好的`IDETemplateMacros.plist`文件移动到与工程同一级目录下 ，就是`.xcodeproj`工程文件或者`.xcworkspace`工作区的所在的目录，为此编写了一个脚本去执行，只需要把脚本放到与工程同一级目录下执行`sh IDETemplate.sh`即可 
```shell
cp -f ./IDETemplateMacros.plist  ./*.xcodeproj/xcshareddata
cp -f ./IDETemplateMacros.plist  ./*.xcworkspace/xcuserdata

echo "Xcode模板部署成功！！！"

```

### 可在当前目录查看 [IDETemplateMacros.plist](./IDETemplateMacros.plist) 和 [IDETemplate.sh](./IDETemplate.sh)













