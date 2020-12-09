# 使用方法

Xcode里添加一个run script ,每次运行都会上传DSYM文件,一般是Release才让生成DSYM,因为会影响编译速度,线上bug通过bugly后台反馈,上传了DSYM文件可以解析对应的符号得出崩溃日志的堆栈信息,方便定位追踪解决bug~ 

```bash
#代码区添加脚本执行路径
Bugly/dSYMUpload.sh "<APPID>" "<APPKEY>" "<BundleID>"

```