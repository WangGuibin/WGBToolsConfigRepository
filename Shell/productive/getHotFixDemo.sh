#用于编译完的时候获取demo 
SDKName="LUOCRunner"
mkdir -p ~/Desktop/OCRunnerProducts

cp -Rf ./${SDKName}.framework  ~/Desktop/OCRunnerProducts/${SDKName}.framework
cp -Rf ./${SDKName}.xcframework  ~/Desktop/OCRunnerProducts/${SDKName}.xcframework

cd ..
cp -Rf ./OCRunnerDemo   ~/Desktop/OCRunnerProducts/OCRunnerDemo
cd ~/Desktop
cd OCRunnerProducts
zip -qryX ${SDKName}.framework.zip ${SDKName}.framework
zip -qryX ${SDKName}.xcframework.zip ${SDKName}.xcframework

cd OCRunnerDemo
Podfile=`pwd`/Podfile
#查找到SDK那个target开始 往下8行删掉 重新pod install
lineNum=`grep -n "SDK工程" ${Podfile} | cut -d ":" -f 1`
endLine=$(echo "scale=0;  ${lineNum}+8" | bc)

# echo "从第 ${lineNum} 行开始删除这8行代码"
sed -i "" "${lineNum},${endLine}d" ${Podfile} 
echo "\033[32;49;1mpodfile 修改成功~\033[39;49;0m"
cat ${Podfile}

pod install
cd ..
zip -qryX OCRunnerDemo.zip  OCRunnerDemo

rm -rf ${SDKName}.framework
rm -rf ${SDKName}.xcframework
rm -rf OCRunnerDemo

echo "\033[1;40;36m[Demo已打包完毕]"
echo "\033[1;40;36m[DONE]"