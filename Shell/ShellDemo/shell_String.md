####  指定字符串分割成数组  

####   ${str//"X"/" "}    

```bash
 #! /bin/bash
 
 str="A,B,C"
 res=(${str//","/" "})
 echo ${res[0]} # A
 echo ${res[1]} # B
 echo ${res[2]} # C
```
#### 替换某个字符并连接
####  ${str//","/"-"}    
替换逗号使用 "-"连接
```bash
 #! /bin/bash
 
 str="A,B,C"
 res=(${str//","/"-"})
 echo $res # A-B-C
 
 str="qwe=>rrt=>yui=>oop=>w"
 res=(${str//"=>"/"***"})  
 echo $res # qwe***rrt***yui***oop***w

```

#### cut

-d 指定截取的字符

-f 指定列

```bash
echo "2.0.1" | cut -d "." -f 3  # 1
echo "192.168.1.163" | cut -d "." -f 4  # 163

```



####  tr 的用法

https://www.cnblogs.com/faberbeta/p/linux-shell003.html (Linux上有 mac上有些没有)

-s 替换重复的字符

```bash
echo "aaabbbaacccfddd" | tr -s [abcdf]
# abacfd
echo "Heoooollo" |tr -s  "[o]"
# Heollo
```

-d 删除指定字符

```bash
[root@localhost ~]# echo "a12HJ13fdaADff" | tr -d "[a-z][A-Z]"
1213
[root@localhost ~]# echo "a1213fdasf" | tr -d [adfs]
1213
```

-cs  除了指定规则外 替换成 xxx

> 这里是除了大小写字母外替换成换行符

```bash
$ cat test.txt

Monday   09:00
Tuesday  09:10
Wednesday 10:11
Thursday  11:30
Friday   08:00
Saturday  07:40
Sunday   10:00

$ cat test.txt | tr -cs "[a-z][A-Z]" "\n"

Monday
Tuesday
Wednesday
Thursday
Friday
Saturday
Sunday
```



####  字符串截取技巧

```bash
 #! /bin/bash
str="- (百度)(https://www.baidu.com)"

#删除左边括号之前的内容(包含左半边括号也去除)
echo ${str#*(}  # 百度)(https://www.baidu.com) 匹配第一个
echo ${str##*(} # https://www.baidu.com) 匹配到最后一个

#删除右边内容 保留左边内容
echo ${str%/*} # - (百度)(https:/   从右边起匹配到第一个
echo ${str%%/*} # - (百度)(https:   从右边起匹配到最后一个

# 从第4个字符起截取两个字符长度
echo ${str:3:2} # 百度

# 从第8个字符开始截取到最后
echo ${str:7} # https://www.baidu.com)

# 从右边起第几个字符开始，及字符的个数 (相当于斩尾巴部分之后再截取从左到右计算截取长度)
echo ${str:0-5:5} # .com)
echo ${str:0-7:5} # du.co

#从右边第几个字符开始，一直到结束 (其实就是断尾~ 获取尾巴的部分长度)
echo ${str:0-7} # du.com)
echo ${str:0-5} # .com)

```



####  示例

> 文本处理 markdown的链接处理成csv格式,利用Alfred的listFilter作为书签输入的数据源... 

```bash
 #! /bin/bash
echo "原文本 => "
echo '
- [百度] (https://www.baidu.com)

- [百度 ](https://www.baidu.com)

- [ 百 度](https://www.baidu.com)
- [百度 ](https://www.baidu.com)

- [百 度 ](https://www.baidu.com)
- [百度 ] (https://www.baidu.com)
- [百度]( https://www.baidu.com)

- [百度](https://www.baidu.com )
- [百度](https://www.baidu.com)
- [百度]( https://www.baidu.com )

- [tengxun (哈哈哈)](https://www.tententxin.com )
- [[sina]事实上啊啊(牛啊)](https://www.sina.com)
- [souhu(哈哈哈)]( https://www.baidu.com )

'
echo "处理后的文本 => "
echo '
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
百度,' ',https://www.baidu.com
tengxun (哈哈哈),' ',https://www.tententxin.com
[sina]事实上啊啊(牛啊),' ',https://www.sina.com
souhu(哈哈哈),' ',https://www.baidu.com
'
echo "然后追加写入到 ~/Desktop/result.csv 文件中"

function getURL() {
    title_right=${1#*[}
    title=${title_right%]*}
    link_right=${1##*(}
    link=${link_right%%)*}
    result="${title},' ',${link}"
}

for line in `cat $1 | tr -d " "|tr -d "-" | tr -s "\n"`
do
    getURL $line
    echo $result >> ~/Desktop/result.csv
done

echo "写入完成~"
exit 0
```

