#!/bin/sh
if [ "$(defaults read com.apple.finder CreateDesktop)" = "FALSE" ]
then
defaults write com.apple.finder CreateDesktop TRUE
else
defaults write com.apple.finder CreateDesktop FALSE
fi
killall Finder
