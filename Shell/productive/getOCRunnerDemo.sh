#用于编译完的时候获取demo 
cd ~/Desktop/luhotfix_ios/LUOCRunner
sh getHotFixDemo.sh

#返回之前的执行路径
cd -
SDKName="LUAPM"
mkdir -p ~/Desktop/LUAPM-Output

cp -Rf ./${SDKName}.framework  ~/Desktop/LUAPM-Output/${SDKName}.framework
cp -Rf ./${SDKName}.xcframework  ~/Desktop/LUAPM-Output/${SDKName}.xcframework

cd ..
cp -Rf ./LUAPMDemo   ~/Desktop/LUAPM-Output/LUAPMDemo
cd ~/Desktop
cd LUAPM-Output
zip -qryX ${SDKName}.framework.zip ${SDKName}.framework
zip -qryX ${SDKName}.xcframework.zip ${SDKName}.xcframework
zip -qryX LUAPMDemo.zip  LUAPMDemo
mv -f ~/Desktop/OCRunnerProducts/*  ~/Desktop/LUAPM-Output/
rm -rf ~/Desktop/OCRunnerProducts
rm -rf ${SDKName}.framework
rm -rf ${SDKName}.xcframework
rm -rf LUAPMDemo

echo "\033[1;40;36m[LUAPMDemo已打包完毕]"
echo "\033[1;40;36m[DONE]"
