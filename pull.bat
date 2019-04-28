@echo off
:start
ping -n 20 127.1>NUL
git pull origin master
goto start 