#!/bin/bash

# 导出当前项目的Xcode环境变量 
# sh dump_buildsettings.sh -p "项目名称" -t "target名称" -c "Release或者Debug"
#**************
# -p: 工程名
# -t: target名
# -c: Debug或者Release
#  
#**************

PROJECT_NAME="" 
TARGET_NAME=""
CONFIGURATION="" 

while getopts ":p:t:c:" opt; do
  case $opt in
    p)
       PROJECT_NAME="$OPTARG" 
      ;;

	  t)
	     TARGET_NAME="$OPTARG" 
	  ;;

	  c)
	     CONFIGURATION="$OPTARG" 
	  ;;
    \?)
      echo "输入错误❌,请按传参要求重新操作: 
      -p: <工程名>
      -t: target名
      -c: Debug或者Release
      " 
      ;;
  esac
done


echo "工程名: ${PROJECT_NAME}"
echo "target名: ${TARGET_NAME}"
echo "编译环境: ${CONFIGURATION}"

xcodebuild -project ${PROJECT_NAME}.xcodeproj -target ${TARGET_NAME} -configuration ${CONFIGURATION} -showBuildSettings > xcodebuild_buildSettings.sh


echo "🔥🔥🔥"
echo "生成成功!"
open ./

