# /bin/bash
# iOS打白包 Demo.app => Demo.ipa
#AppFilePath="/Users/wangguibin/Desktop/Demo.app"
# sh white_ipa.sh "./xxx.app"
AppFilePath=$1
AppName_all=${AppFilePath##*/}
AppName=${AppName_all%.*}

mkdir -p Payload
cp -Rf $AppFilePath ./Payload/
zip -qryX ./$AppName.ipa  ./Payload
rm -rf Payload
