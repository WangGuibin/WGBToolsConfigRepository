#!/bin/sh

MATCH_Prefix="https://github.com/"
URL_Prefix="https://hub.fastgit.org/"
URL=$1
RES=${URL_Prefix}${URL:${#MATCH_Prefix}}
# echo $RES
osascript <<EOF
tell application "Safari"
	tell window 1
		set current tab to (make new tab with properties {URL: "${RES}"})
	end tell
end tell
EOF
