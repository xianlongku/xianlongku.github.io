@echo off
:start
ping -n 30 127.1>NUL
start "test" hexo_g_d.bat
goto start 