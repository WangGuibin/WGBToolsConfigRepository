#!/bin/bash

# sh build_framework.sh xcodeproj所在目录 Debug/Release

cd $1

echo "dir:"$1

#要build的target名
target_Name=`ls | grep .xcodeproj | head -1`
target_Name=${target_Name%.xcodeproj}
if [[ "$3" != "" ]];then
    target_Name=$3;
fi

echo "target_Name:"$target_Name

result=`xcodebuild -showBuildSettings -target $target_Name | grep WRAPPER_EXTENSION | head -1 | grep framework 2>/dev/null`
isFramework=0;
if [ "$result" != "" ];then
    isFramework=1
fi
echo "isFramework:"$isFramework

#编译模式  Release、Debug
build_model="Release"
if [[ "$2" != "" ]];then
    build_model=$2;
fi
echo "build_model:"$build_model

#压缩后的文件名
build_date_string=`date +'%Y%m%d%H%M%S'`

#导出sdk地址 /Users/liusong/Desktop/allFrameworks/TestFramework/Release_XXXX_2019010101.zip
exportSdkPath=~/Desktop/allFrameworks/${target_Name}

#log文件
log_file=${exportSdkPath}/logs/${build_date_string}.log
mkdir -p ${exportSdkPath}/logs


#获取工程当前所在路径
project_path=$(pwd)


#编译文件路径
buildPath=${project_path}/build

#删除build文件
if [ -d ${buildPath} ]; then
    rm -rf ${buildPath}
fi


iphoneos_path=""
simulator_path=""

if [ "$isFramework" = "1" ];then
    #真机产物输出路径
    iphoneos_path=${buildPath}/${build_model}-iphoneos
    #模拟器产物输出路径
    simulator_path=${buildPath}/${build_model}-iphonesimulator
else
    #真机产物输出路径
    iphoneos_path=${buildPath}/${build_model}-iphoneos
    #模拟器产物输出路径
    simulator_path=${buildPath}/${build_model}-iphonesimulator
fi


if [ ! -d $exportSdkPath ]; then
    mkdir -p $exportSdkPath;
fi


#build之前clean一下
xcodebuild -target ${target_Name} clean 1>$log_file

#模拟器build
xcodebuild -target ${target_Name} -configuration ${build_model} -sdk iphonesimulator 1>$log_file

#真机build
xcodebuild -target ${target_Name} -configuration ${build_model} -sdk iphoneos 1>$log_file

#新建临时目录用于压缩使用
temp_path="temp_path"
sdk_zip_name=${target_Name}-${build_date_string}-${build_model}.zip

##合并模拟器和真机Mach-O
if [ "$isFramework" = "1" ];then
lipo -create ${iphoneos_path}/${target_Name}.framework/${target_Name} ${simulator_path}/${target_Name}.framework/${target_Name} -output ${iphoneos_path}/${target_Name}.framework/${target_Name}
    mkdir -p ${buildPath}/${temp_path}
    cp -rf ${iphoneos_path}/ ${buildPath}/${temp_path}/

else
    lipo -create ${iphoneos_path}/lib${target_Name}.a ${simulator_path}/lib${target_Name}.a -output ${iphoneos_path}/lib${target_Name}.a
    mkdir -p ${buildPath}/${temp_path}/${target_Name}
    cp -rf ${iphoneos_path}/ ${buildPath}/${temp_path}/${target_Name}/

fi

#压缩sdk输出路径下的所有文件
cd ${buildPath}/${temp_path}
zip -rq ${exportSdkPath}/${sdk_zip_name} ./*
echo "完成-------"
echo "${exportSdkPath}/${sdk_zip_name}"

#删除build文件
if [ -d ${buildPath} ]; then
    rm -rf ${buildPath}
fi




