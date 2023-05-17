#!/bin/bash

PATH1="/Users/wangguibin/Desktop/buildFramework.sh"
# tail和sed操作需要查手册 命令实在太多了 能记住常用的就不错了
#读取倒数第二行 tail只能读取倒数的几条 sed -n "1p"则是取倒数几条中的第一条打印 即倒数两条中的第一条
SecondLast=$(tail -n -2 ${PATH1} | sed -n "1p")
#读取倒数第一行
FirstLast=$(tail -n -1 ${PATH1})
echo $SecondLast
echo $FirstLast

#cat ${PATH1} >> ${PATH1} #❌ 不能同时读取和写入同一个文件
cat ${PATH1} >> ./test.txt #✅ 采用临时文件过渡
cat ./test.txt > ${PATH1} # > 覆盖之前内容 和 >> 追加内容
rm -rf ./test.txt # 清除临时文件 

#cp
<<CP
- a 保留链接和文件属性，递归拷贝目录，相当于下面的d、p、r三个选项组合。
- d 拷贝时保留链接。
- f 删除已经存在目标文件而不提示。(属于强制覆盖的意思)
- i 覆盖目标文件前将给出确认提示，属交互式拷贝。
- p 复制源文件内容后，还将把其修改时间和访问权限也复制到新文件中。
- r 若源文件是一目录文件，此时cp将递归复制该目录下所有的子目录和文件。当然，目标文件必须为一个目录名。
- l 不作拷贝，只是链接文件。
-s 复制成符号连结文件 (symbolic link)，亦即『快捷方式』档案；
-u 若 destination 比 source 旧才更新 destination

cp -rvf dir1 dir2
复制文件夹dir1到dir2，显示进度

cp -rf dir1 dir
复制文件夹dir1到dir2，不显示进度cp -rf ../dir/* ../   
#拷贝上一层目录dir下的所有文件到 ../，可以测试../表示啥
CP


<<MV
mv [options] source dest
mv [options] source... directory

-b: 当目标文件或目录存在时，在执行覆盖前，会为其创建一个备份。
-i: 如果指定移动的源目录或文件与目标的目录或文件同名，则会先询问是否覆盖旧文件，输入 y 表示直接覆盖，输入 n 表示取消该操作。
-f: 如果指定移动的源目录或文件与目标的目录或文件同名，不会询问，直接覆盖旧文件。
-n: 不要覆盖任何已存在的文件或目录。
-u：当源文件比目标文件新或者目标文件不存在时，才执行移动操作。

mv命令可以用cp+rm来实现
MV

<<MKDIR
mkdir [-p] dirName
mkdir -p runoob2/test #若目录runoob2不存在则会直接创建
创建多级目录 mkdir -p a/b/c/d (创建a目录，并在a目录下创建b目录，在b目录下创建c目录，在c目录下创建d目录)
创建多级多个目录 mkdir -p a/{b1,b2,b3/{c1,c2,c3},b4} （创建a目录,在a目录下创建b1,b2,b3,b4目录,在b3目录下创建c1,c2,c3目录）

MKDIR

<<RM
rm [options] name... 可删除文件或者目录
-i 删除前逐一询问确认。
-f 即使原档案属性设为唯读，亦直接删除，无需逐一确认。
-r 将目录及以下之档案亦逐一删除。

r或者rf最为常用,且慎用,比如 sudo rm rf ~/* 这个梗~ 

RM

du -sh *  #查看当前目录下的磁盘占用