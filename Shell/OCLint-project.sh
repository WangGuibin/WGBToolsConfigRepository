#!/bin/bash

COLOR_ERR="\033[1;31m"    #出错提示
COLOR_SUCC="\033[0;32m"  #成功提示
COLOR_QS="\033[1;37m"  #问题颜色
COLOR_AW="\033[0;37m"  #答案提示
COLOR_END="\033[1;34m"     #颜色结束符

# 寻找项目的 ProjectName
function searchProjectName () {
    find . -maxdepth 1 -name "*.xcodeproj"
}

function oclintForProject () {
    # 预先检测所需的安装包是否存在
    if which xcodebuild 2>/dev/null; then
        echo 'xcodebuild exist'
    else
        echo '🤔️  xcodebuild 都没有安装，玩个锤啊？ 🤔️'
    fi

    if which oclint 2>/dev/null; then
        echo 'oclint exist'
    else
        echo '😠 玩 oclint 却不安装吗，要闹哪样 😠'
    fi
    if which xcpretty 2>/dev/null; then
        echo 'xcpretty exist'
    else
        gem install xcpretty
    fi


    # 指定编码
    export LANG="zh_CN.UTF-8"
    export LC_COLLATE="zh_CN.UTF-8"
    export LC_CTYPE="zh_CN.UTF-8"
    export LC_MESSAGES="zh_CN.UTF-8"
    export LC_MONETARY="zh_CN.UTF-8"
    export LC_NUMERIC="zh_CN.UTF-8"
    export LC_TIME="zh_CN.UTF-8"
    export xcpretty=/usr/local/bin/xcpretty # xcpretty 的安装位置可以在终端用 which xcpretty找到

    searchFunctionName=`searchProjectName`
    path=${searchFunctionName}
    # 字符串替换函数。//表示全局替换 /表示匹配到的第一个结果替换。 
    path=${path//.\//}  # ./BridgeLabiPhone.xcodeproj -> BridgeLabiPhone.xcodeproj
    path=${path//.xcodeproj/} # BridgeLabiPhone.xcodeproj -> BridgeLabiPhone
    
    myworkspace=$path".xcodeproj" # workspace名字
    myscheme=$path  # scheme名字

    # 清除上次编译数据
    if [ -d ./derivedData ]; then
        echo -e $COLOR_SUCC'-----清除上次编译数据derivedData-----'$COLOR_SUCC
        rm -rf ./derivedData
    fi

    # xcodebuild clean
    xcodebuild -scheme $myscheme -project $myworkspace clean

    #生成编译数据
    xcodebuild -scheme $myscheme -project $myworkspace -configuration Debug COMPILER_INDEX_STORE_ENABLE=NO | xcpretty -r json-compilation-database -o compile_commands.json

    if [ -f ./compile_commands.json ]; then
        echo -e $COLOR_SUCC'编译数据生成完毕😄😄😄'$COLOR_SUCC
    else
        echo -e $COLOR_ERR'编译数据生成失败😭😭😭'$COLOR_ERR
        return -1
    fi

    # 生成报表  -e  忽略目录  pod的话就要忽略Pods 
#    oclint-json-compilation-database -e Pods -- -report-type html -o oclintReport.html \
#    -rc LONG_LINE=200 \
#    -disable-rule ShortVariableName \
#    -disable-rule ObjCAssignIvarOutsideAccessors \
#    -disable-rule AssignIvarOutsideAccessors \
#    -max-priority-1=100000 \
#    -max-priority-2=100000 \
#    -max-priority-3=100000

    oclint-json-compilation-database -v \
    -e Pods \
    -- -report-type html -o oclintReport.html \
    -extra-arg=-Wno-everything \
    -max-priority-1=10000 \
    -max-priority-2=10000 \
    -max-priority-3=10000 \
    -disable-rule LongLine \
    -disable-rule LongClass \
    -rc=MINIMUM_CASES_IN_SWITCH=3 \
    -rc=CYCLOMATIC_COMPLEXITY=10 \
    -rc=LONG_LINE=400 \
    -rc=LONG_METHOD=300 \
    -rc=NCSS_METHOD=300 \
    -rc=NESTED_BLOCK_DEPTH=5 \
    -rc=TOO_MANY_FIELDS=20 \
    -rc=TOO_MANY_METHODS=250 \
    -rc=TOO_MANY_PARAMETERS=16

    if [ -f ./oclintReport.html ]; then
        rm compile_commands.json
        echo -e $COLOR_SUCC'😄分析完毕😄'$COLOR_SUCC
    else 
        echo -e $COLOR_ERR'😢分析失败😢'$COLOR_ERR
        return -1
    fi
    
    echo -e $COLOR_AW'将为您自动打开 lint 的分析结果...'$COLOR_AW
    # 用 safari 浏览器打开 oclint 的结果
#    open -a "/Applications/Safari.app" oclintReport.html
    # 用Google浏览器打开
    open -a '/Applications/Google Chrome.app' oclintReport.html
}

oclintForProject
