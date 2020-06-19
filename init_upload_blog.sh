#!/usr/bin/bash

echo git_status:
if [! -d ".git"]; then
	git init
	git config user.name zw
	git config user.email zevellong@pc.com
	git config --global credential.helper store
	git remote add origin  https://github.com/zevellong/zw_learn_blog.git
fi
git add .
git commit
git push origin master
git status

echo end
