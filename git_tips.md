
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

## 4. 移除本地分支和远程分支

本地分支 `git branch -D branchName`
远程分支 `git push origin --delete branchName` 或者 `git branch -r -d origin/dev && git push origin :dev`





