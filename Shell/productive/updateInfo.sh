#! /bin/bash
#编译加上info.plist版本号和编译时间,可用于定位追溯
build_version="2.1.0" #每次升级SDK记得修改这个值即可
build_time=$(date +%Y-%m-%d\ \%H:%M:%S)
info_plist="${BUILT_PRODUCTS_DIR}/${EXECUTABLE_FOLDER_PATH}/Info.plist"
/usr/libexec/PlistBuddy -c "Set :'SDKLastBuildTime'   '${build_time}'"   "${info_plist}"
/usr/libexec/PlistBuddy -c "Set :'SDKVersion'   '${build_version}'"   "${info_plist}"
/usr/libexec/PlistBuddy -c "Set :'CFBundleShortVersionString'   '${build_version}'"   "${info_plist}"

#修改SDK代码里的版本号
SDK_File_Version_Path="./ScreenRecordKit/SDK/ScreenShotsToVideoRecorder.m"
sed -i ".bak" "s/   return @\"[0-9].[0-9].[0-9]\";/   return @\"${build_version}\";/g" ${SDK_File_Version_Path} 
rm -rf  "${SDK_File_Version_Path}.bak"
