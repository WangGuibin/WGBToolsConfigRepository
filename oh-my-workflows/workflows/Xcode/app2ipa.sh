app_dir="${BUILD_ROOT}/${CONFIGURATION}-iphoneos"
cd $app_dir

AppName=${EXECUTABLE_NAME}
AppFile=./${AppName}.app
mkdir -p Payload
cp -Rf ${AppFile} ./Payload/
zip -qryX ./$AppName.ipa  ./Payload
rm -rf Payload
open $app_dir
