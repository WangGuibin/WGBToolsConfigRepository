# 有很多md文件,需要整理成列表的markdown语法

```bash
#脚本放到md文件同一级目录下,然后执行脚本生成一个新的聚合list.md

#!/bin/bash
# 文件夹内md多个文件列表生成器
ls | grep -v list.md | grep -v READMEList.sh | xargs -I{} echo "* ["{}"](./"{}")" > list.md
```