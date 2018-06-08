@echo ogff
cmdkey.exe /list > "%TEMP%List.txt"
findstr.exe Ziel "%TEMP%List.txt" > "%TEMP%tokensonly.txt"
FOR /F "tokens=2 delims= " %%G IN (%TEMP%tokensonly.txt) DO cmdkey.exe /delete:%%G
del "%TEMP%List.txt" /s /f /q
del "%TEMP%tokensonly.txt" /s /f /q
exit