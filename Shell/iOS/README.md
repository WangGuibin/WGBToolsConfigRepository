# LSiOSShell
iOS shell相关脚本
### build_framework.sh 打包framework或.a静态库。并合成真机和模拟器
sh build_framework.sh xcodeproj所在目录 Debug/Release
```
  //参数二不传默认Release
  sh build_framework.sh /Users/liusong/Documents/TestFramework Debug
```
如果主工程不是静态库/动态库(即主工程是测试demo，其他target是静态库、动态库)，可以 sh build_framework.sh  xcodeproj目录 Debug/Release  静态库/动态库target名称
```
  //指定targetName情况 必须指定是Debug或Release 不可省略此参数
  sh build_framework.sh /Users/liusong/Documents/TestFramework Debug FrameworkA
```

### dumpcarsh.sh 解析.crash文件 利用系统自带的symbolicatecrash
- sh dumpcarsh.sh  crash文件    (解析后生成一个.txt文件在.crash同目录) 会自动从电脑 用户目录下寻找匹配的dSYM文件

```
sh dumpcrash.sh /Users/liusong/Desktop/xxxxx2019-7-1,6-18PM.crash
```

- 如果想指定dSYM,则传第二个参数为dSYM

```
sh dumpcrash.sh /Users/liusong/Desktop/xxxxx2019-7-1,6-18PM.crash xxx.dSYM
```

> 如果电脑上不存在此系统的符号库，系统符号可能解析不出来
>
> 所以可以在此链接下载对应的系统符号 链接：https://pan.baidu.com/s/1HxS7HXH1vH0hBJ4L52lTow  密码:wbv2
>
> 解压完，复制到路径 ~/Library/Developer/Xcode/iOS DeviceSupport/  即可。



- crash有两种格式 下面是另外一种唤醒次数过多crash一个原因描述，此种类型需再次解析Heaviest stack，此脚本会自动解析Heaviest stack 

  > Wakeups:          45001 wakeups over the last 48 seconds (934 wakeups per second average), exceeding limit of 150 wakeups per second over 300 seconds
  >
  > 2.Wakeups:          45002 wakeups over the last 267 seconds (169 wakeups per second average), exceeding limit of 150 wakeups per second over 300 seconds


