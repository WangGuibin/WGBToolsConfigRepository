echo '=============== changeColor ================'
# 输入格式示例
# ./color_change.sh [修改前颜色] [修改后颜色] [修改目录]
# 注: 颜色须为六位的十六进制色值

if [ ${#1} -eq 6 ]
then
  echo "修改前的颜色：$1"
else
  echo "修改前颜色输入错误"
  exit 1
fi

if [ ${#2} -eq 6 ]
then
  echo "修改后的颜色：$2"
else
  echo "修改后颜色输入错误"
  exit 1
fi

if [ -d "$3" ]
then
  echo "当前修改的文件夹目录：$3"
else
  echo "请输入需要修改的文件夹目录"
  exit 1
fi

# hex="197D7C"
# printf "%d %d %d\n" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
#

beforeHex=`echo $1 | tr '[:lower:]' '[:upper:]'`
afterHex=`echo $2 | tr '[:lower:]' '[:upper:]'`

a1=`echo $beforeHex | cut -c-2`
b1=`echo $beforeHex | cut -c3-4`
c1=`echo $beforeHex | cut -c5-6`
a2=`echo $afterHex | cut -c-2`
b2=`echo $afterHex | cut -c3-4`
c2=`echo $afterHex | cut -c5-6`

r1=`echo "ibase=16; $a1" | bc`
g1=`echo "ibase=16; $b1" | bc`
b1=`echo "ibase=16; $c1" | bc`
r2=`echo "ibase=16; $a2" | bc`
g2=`echo "ibase=16; $b2" | bc`
b2=`echo "ibase=16; $c2" | bc`

echo "修改前RGB: $r1 $g1 $b1"
echo "修改后RGB: $r2 $g2 $b2"

colorNum=255

colorR1=$(awk 'BEGIN{printf "%.8f\n",('$r1'/'$colorNum')}')
colorG1=$(awk 'BEGIN{printf "%.8f\n",('$g1'/'$colorNum')}')
colorB1=$(awk 'BEGIN{printf "%.8f\n",('$b1'/'$colorNum')}')
colorR2=$(awk 'BEGIN{printf "%.18f\n",('$r2'/'$colorNum')}')
colorG2=$(awk 'BEGIN{printf "%.18f\n",('$g2'/'$colorNum')}')
colorB2=$(awk 'BEGIN{printf "%.18f\n",('$b2'/'$colorNum')}')

export colorRealR=$colorR1
export colorRealG=$colorG1
export colorRealB=$colorB1
export changeR=false
export changeG=false
export changeB=false
export changeNum=0
export compareNum=1

for n in `find $3 -name "*.xib" -o -name "*.storyboard"`; do
  # echo "====== begin ======"
  colorR=`awk '{for(i=1;i<=NF;i++)printf $i"\n";printf "\n"}' $n | grep "red=" |awk -F= '{print $2}'`
  colorG=`awk '{for(i=1;i<=NF;i++)printf $i"\n";printf "\n"}' $n | grep "green=" |awk -F= '{print $2}'`
  colorB=`awk '{for(i=1;i<=NF;i++)printf $i"\n";printf "\n"}' $n | grep "blue=" |awk -F= '{print $2}'`
  RTempArray=(${colorR// /})
  GTempArray=(${colorG// /})
  BTempArray=(${colorB// /})

  for i in ${!RTempArray[@]}
  do
      realR=${RTempArray[$i]}
      # echo "当前red===$realR"
      tempR=$(awk 'BEGIN{printf "%.8f\n",('$realR')}')
      tempR1=$colorR1
      # echo "====== tempR: $tempR======"
      # echo "====== tempR1: $tempR1======"
      if [[ $tempR == $tempR1 ]]; then
        colorRealR=$realR
        changeR=true
        echo "====== colorRealR: $colorRealR======"
        break
      fi
  done

  for i in ${!GTempArray[@]}
  do
      realG=${GTempArray[$i]}
      tempG=$(awk 'BEGIN{printf "%.8f\n",('$realG')}')
      tempG1=$colorG1
      # echo "====== tempG: $tempG======"
      # echo "====== tempG1: $tempG1======"
      if [[ $tempG == $tempG1 ]]; then
        colorRealG=$realG
        changeG=true
        # echo "====== colorRealG: $colorRealG======"
        break
      fi
  done

  for i in ${!BTempArray[@]}
  do
      realB=${BTempArray[$i]}
      # echo "当前blue===$realB"
      tempB=$(awk 'BEGIN{printf "%.8f\n",('$realB')}')
      tempB1=$colorB1
      # echo "====== tempB: $tempB======"
      # echo "====== tempB1: $tempB1======"
      if [[ $tempB == $tempB1 ]]; then
        colorRealB=$realB
        changeB=true
        # echo "====== colorRealB: $colorRealB======"
        break
      fi
  done

  if [[ "$changeR" = true && "$changeG" = true && "$changeB" = true ]]; then
      echo "=================已找到原色值================="
      echo "====== colorRealR: $colorRealR======"
      echo "====== colorRealG: $colorRealG======"
      echo "====== colorRealB: $colorRealB======"
      break
  fi
  echo $colorR
  # echo "====== end ======"
done

if [[ "$changeR" = true && "$changeG" = true && "$changeB" = true ]]
then
  #先将色值为1的末尾去零
  if [[ $(echo "$colorR2/$compareNum" | bc) -eq $compareNum ]]; then
    colorR2=1
  fi
  if [[ $(echo "$colorG2/$compareNum" | bc) -eq $compareNum ]]; then
    colorG2=1
  fi
  if [[ $(echo "$colorB2/$compareNum" | bc) -eq $compareNum ]]; then
    colorB2=1
  fi

  #拼接替换文本
  echo "===找到相同色值可以修改颜色====="
  allStr='s/red='$colorRealR' green='$colorRealG' blue='$colorRealB'/red=\"'$colorR2'\" green=\"'$colorG2'\" blue=\"'$colorB2'\"/g'
  # echo $allStr

  echo "===========执行替换操作========="
  for n in `find $3 -name "*.xib" -o -name "*.storyboard"`; do
    echo "$n"
    sed -i "" "${allStr}" $n
    changeNum=$[$changeNum+1]
    echo "-------$changeNum"
  done

  echo "==========替换操作完成==========="
  echo "修改前RGB: $colorR1 $colorG1 $colorB1"
  echo "修改后RGB: $colorR2 $colorG2 $colorB2"
  echo "========本次总共修改了 $changeNum 个色值========"
else
  echo "===没有找到相同色值可以修改====="
fi