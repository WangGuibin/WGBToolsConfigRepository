# shell脚本如何全局使用（不用cd到脚本目录下）？

> 本质是访问环境变量，好多第三方脚本工具都是全局配置的，一般需要在`~/.zshrc`或者`~/.bash_profile`里配置访问路径的环境变量，形如 
```shell
#其中`/Users/mac`是根目录即`$HOME` 可根据实际情况配置 这里电脑用户名为`mac` 
export PATH=/Users/mac/flutter/bin:$PATH #拼到最前面
export PATH=$PATH:/Users/mac/MyShell #拼到最后面
```
1. 写好一个工具脚本，并命名为`common_tool` (PS:`common_tool.sh`简化命令的时候需要把后缀也加上其效果和无后缀是一样的)
2. 建立一个目录用于存储脚本工具，这里命名为`MyShell`,并把`common_tool`放入该目录下
3. 进入`MyShell`目录下，把`common_tool`脚本的执行权限打开 `chmod +x common_tool`
4. 查看命令`common_tool` 
 
```shell
which common_tool
/Users/mac/MyShell/common_tool
```
5. 执行命令 `common_tool`  
```shell
common_tool + 回车即可看见效果
```

[参考](https://blog.csdn.net/ly20091130/article/details/77449824)