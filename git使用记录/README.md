
## 1. `git rebase`

开分支 ->  各自开发不同的模块 -> 合并代码的时候,先提交自己的分支然后`rebase`自己的分支到`master`最新的部分 
`rebase`谁就是把谁当作自己的基点,然后把自己的提交跟在后面,`rebase`完后再切换到`maser`, `master`再`rebase`自己的开发的功能分支,
完事之后可以打个`tag`，让分支滚蛋  
```bash
在dev分支 -> rebase主分支master最新的主干代码
切到master主分支 -> rebase到最新代码 -> 卸磨杀驴移除分支 

```
[在开发过程中使用git rebase还是git merge，优缺点分别是什么？](https://www.zhihu.com/question/36509119?rf=26492099)
## 2. `git merge`

`git merge b `      *将`b`分支合并到当前分支*
同样 `git rebase b`，也是把 `b`分支合并到当前分支

主要看当前所在的分支, merge谁就合并谁  合并的意思是重复的不管 加入没有的,还有就是原本存在的被改了会被覆盖以及冲突

https://www.cnblogs.com/marblemm/p/7161614.html


```bash
git fetch origin master:tmp
git diff tmp 
git merge tmp
git branch -d tmp
```
    从远程获取最新的版本到本地的`tmp`分支上
   之后再进行比较合并

## 3. `git pull`：相当于是从远程获取最新版本并`merge`到本地

```bash 
git pull origin master


    上述命令其实相当于git fetch 和 git merge
    在实际使用中，git fetch更安全一些
   因为在merge前，我们可以查看更新情况，然后再决定是否合并

   gfo master ：temp
   gd temp 比較 
   gm temp 合并遠程分支
   gbd “temp” 刪掉臨時分支
```

## 4. 分支管理

只创建 `git branch branchName`  或者
只切换 `git checkout branchName` 或者 `git switch branchName`
创建并切换 `git checkout -b branchName` 或者 `git switch -c branchName`
删除本地分支 `git branch -D branchName` 或者 `git branch -d branchName`
删除远程分支 `git push origin --delete branchName` 或者 `git branch -r -d origin/dev && git push origin :dev` 或者`git push origin -d <branch name>`
其中 git push origin :branchName 原型是 git push origin master:branchName 将本地的master分支推送到远程的branchName

查看所有分支: `git branch`
合并分支: `git merge branchName` 一般是切换到主分支(`master`)把旁分支(`branchName`)合并 
或者使用 `git merge branchName -m "xxx" --no-ff` 其中`--no-ff` Git默认会用`Fast forward`模式，但这种模式下，删除分支后，会丢掉分支信息,强制禁用`Fast forward`模式，加上`--no-ff`就可以查看完整的分支历史信息，不受分支删除影响。


## 5. tag管理

```shell
git tag #查看已有tag
git tag tagName #当前分支最新节点的tag
# 指定节点打tag并添加release note信息  
git tag -a v0.1 -m "version 0.1 released" 1094adb
git tag -d <tagname> #删除本地标签
git show <tagname> #可以看到说明文字：
git push origin v1.0 #推送指定本地标签
git push origin --tags #一次性全部推
git push origin :refs/tags/v0.9 #删除指定的远程标签
git push origin :<branch>/<tag> #删除指定的远程标签 注意冒号 : 必不可少, 后面跟远程库的分支名/标签名

```

## 6. 查看终端`oh-my-zsh`工具封装的git快捷命令
```shell
alias | grep git

```
