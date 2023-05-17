### sed 命令总结



获取匹配内容的行号

```bash
# 匹配标识 <- <# Version Replace Flag #> -> 文件所在行号
lineNum=`grep -n "<- <# Version Replace Flag #> ->" test.txt | cut -d ":" -f 1`
echo $lineNum
```

删除指定行

```bash
sed -i "" "${lineNum}d" ./test.txt
sed -i ".bak" "${lineNum}d" ./test.txt #会生成一个.bak备份文件 避免数据丢失
```

插入指定行(这个插入Mac里只能使用单引号使用,但是单引号内无法引用变量`$x`,所以变量`$version`要在单引号外进行拼接)

```bash
version=3.0.0
sed -i "" ''${lineNum}'i\
    return @\"'${version}'\";//<- <# Version Replace Flag #> ->
     ' ./test.txt
#或者
sed -i ".bak" ''${lineNum}'i\
    return @\"'${version}'\";//<- <# Version Replace Flag #> ->
     ' ./test.txt
```

替换文本文件内容

```bash
# 匹配代码里的版本号按正则规则匹配 然后替换成 $newVersion
sed -i ".bak" "s/    return @\"[0-9].[0-9].[0-9]\";/    return @\"${newVersion}\";/g" ${SDK_File_Version_Path} 

```



版本号字符串切割

```bash
codeText=$(cat $SDK_File_Version_Path | grep -oE  "\"[0-9]+.[0-9]+.[0-9]+\"" | tail -n 1)
echo "匹配结果: "$codeText # "2.0.1"

leftText=${codeText#*\"} # 2.0.1"
resultText=${leftText%\"*} # 2.0.1
lastVersion=$resultText
echo $lastVersion #2.0.1

version_array=(${lastVersion//./ }) (2 0 1)
Major=${version_array[0]} # 2
Minor=${version_array[1]} # 0
Build=${version_array[2]} # 1
#Build号自增 数字运算
result=$(echo "${Build}+1" | bc) # 2 

```

