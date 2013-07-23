#!/usr/bin/env sh
#git pull
git add .
date=`date`
git commit -am "$date $1"
git push
