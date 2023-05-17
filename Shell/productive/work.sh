# /bin/bash
#使用Xcode图标
ICON="with icon file \"Macintosh HD:Applications:Xcode.app:Contents:Resources:Xcode.icns\""
# note/ stop/ caution 系统内置图标
# ICON="with icon note"

START_TIME=$(
osascript <<EOF
display dialog "工时填报计算" default answer "请输入上班打卡时间" ${ICON} 
text returned of result
EOF
)
echo $START_TIME
HOUR1=${START_TIME%:*}
MIN1=${START_TIME#*:}
H1=$(echo "scale=4; ${MIN1}/60" | bc)
res1=$(echo "scale=4; ${HOUR1}+${H1}" | bc)

END_TIME=$(
osascript <<EOF
display dialog "工时填报计算" default answer "请输入下班打卡时间" ${ICON} 
text returned of result
EOF
)

echo $END_TIME
HOUR2=${END_TIME%:*}
MIN2=${END_TIME#*:}
H2=$(echo "scale=4; ${MIN2}/60" | bc)
res2=$(echo "scale=4; ${HOUR2}+${H2}" | bc)

# 工时 = 下班时间 - 上班时间 - 中午休息1.5小时
res3=$(echo "scale=4; ${res2}-${res1}-1.5" | bc)
MSG="计算规则:\n工时 = 下班时间 - 上班时间 - 中午休息1.5小时\n工时 = ${END_TIME} - ${START_TIME} - 1.5h午休\n计算结果为: ${res3}个小时"
osascript <<EOF
display dialog "${MSG}" with title "计算结果" buttons {"好的👌"}  default button 1 ${ICON} 
EOF

