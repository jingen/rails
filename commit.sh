#!/usr/bin/env sh
git add .
date=`date`
git commit -am "$date $1"
git pull
git push
