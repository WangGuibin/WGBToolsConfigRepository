# !/bin/bash
# pod check cmd By DevDragonLi

# 如果是私有源校验，需要指令添加 --sources=xxx/Specs.git

echo -e "\033[32mCheck current Folder Pod Begain,may take some times! \nPlease Waiting ☕️ \n\033[0m"

# pod_spec_lint_info=`mktemp`

# pod spec lint --fail-fast --platforms=ios  --allow-warnings >${pod_spec_lint_info}

# if [ "$?" -eq 0 ];then   

#     echo -e "\033[36m ✅：Podspec File [grammar] Check  Passed 😁 \033[0m"

# else
#     cat ${pod_spec_lint_info}  | tail -n 1024
    
#     echo -e "\033[32m\nTips：\n1：Please Check Podspec  Does the subspec dependency have a circular dependency error \n2：Check for syntax errors for key information in the podSpec file \n \033[0m"    

#     echo -e "\033[31m\nFailure occurred,Please Solve the problem before submitting！\n \033[0m"

#     exit 501
# fi

pod_lib_lint_info=`mktemp`

pod lib lint --fail-fast --platforms=ios --skip-import-validation --skip-tests --use-json --allow-warnings  > ${pod_lib_lint_info}

if [ "$?" -eq 0 ];then   
    echo -e "\033[36m ✅：Pod Check  Passed 😁 \033[0m"
else

    cat ${pod_lib_lint_info}  | tail -n 1024

    echo -e "\033[31m\nFailure occurred,Please Solve the problem before submitting！\n \033[0m"
    
    echo -e "\033[32m\nTips：to the above error terminal Message and follow the steps below to resolve problem/errors\n
    1.子组件循环依赖错误\n
    2.组件编译报错【排查本地是否可以编译通过】\n
    3.其他原因\033[0m"    
    exit 502
fi

echo -e "\033[36m 😁：Check End, All Passed！ \033[0m"