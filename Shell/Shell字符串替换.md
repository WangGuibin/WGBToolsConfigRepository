Shell字符串替换

使用 string/pattern/string 进行首个 pattern 的替换

```
> string="text, dummy, text, dummy"
> echo ${string/text/TEXT}
TEXT, dummy, text, dummy
```

使用 string//pattern/string 进行全部 pattern 的替换

```
> string="text, dummy, text, dummy"
> echo ${string//text/TEXT}
TEXT, dummy, TEXT, dummy
```