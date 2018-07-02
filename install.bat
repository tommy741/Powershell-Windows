@echo off

cd /d %dp%1
start setup.exe /q TargetDir="C:\Program Files (x86)\.......\Target" -Parameter -etc

exit
