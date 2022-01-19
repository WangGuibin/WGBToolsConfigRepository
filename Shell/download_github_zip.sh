
# https://hub.fastgit.org/facebookarchive/WebDriverAgent
# https://hub.fastgit.org/facebookarchive/WebDriverAgent/archive/refs/heads/master.zip

# https://github.com/facebookarchive/WebDriverAgent
# https://github.com/facebookarchive/WebDriverAgent/archive/refs/heads/master.zip

# https://gh.api.99988866.xyz/ + URL 下载加速

if [[ "$1" =~ ^https://github.com.* ]] ; 
then
    echo "规则验证通过"
else
    if [[ "$1" =~ ^https://hub.fastgit.org.* ]] ; then
    echo "规则验证通过"
    else
    echo "规则不匹配"
    exit 0
    fi
fi

function openWebLink(){
osascript <<EOF
tell application "Safari"
    activate
    tell window 1
        set current tab to (make new tab with properties {URL:"${1}"})
    end tell
end tell
EOF
}

select_branch=$(
osascript<<EOF
set branchs to {"main", "master"}
choose from list branchs with title "选择分支下载zip包" with prompt "选择一个分支下载" OK button name "下载" cancel button name "取消" default items {"master"}
EOF
)

if [[ $select_branch == false ]] ;
then
    exit 0
else
    github_url=$1
    URL=${github_url/hub.fastgit.org/github.com}
    openWebLink https://gh.api.99988866.xyz/$URL/archive/refs/heads/$select_branch.zip
fi


