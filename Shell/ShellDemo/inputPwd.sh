# /bin/bash
# 输入密码框 /不可见的输入
# https://wangchujiang.com/linux-command/c/stty.html

echo "请输入密码㊙️"
stty -echo
read password
echo "密码已输入完毕"
echo "你输入的密码是: " $password 
stty echo 

echo "请再次输入:"
read -s pwd 
echo "再次输入的结果: " $pwd

if [[ "${password}" = "$pwd" ]] ; then 
    echo "两次输入结果一致"
    else
    echo "两次输入结果不一致"
fi
