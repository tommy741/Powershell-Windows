if exist "%APPDATA%\Microsoft\Templates\domain_ci_vorlagen.log" GOTO END4

SET LOG="%APPDATA%\Microsoft\Templates\domain_ci_vorlagen.log"
date /T >> %LOG%
time /T >> %LOG%

REM export and import the del_Win_Vorlagen.reg
IF EXIST "C:\Windows\Logs\WinVorlagen_REG_BACKUP_%computername%.reg" GOTO END1
regedit /E "C:\Windows\Logs\WinVorlagen_REG_BACKUP_%computername%.reg" "HKEY_CLASSES_ROOT\Installer\Components\8F622368F04F7B849A7B2021EE668F21"
regedit /s "\\fileshare\Ablage\Scripte\del_Win_Vorlagen.reg"
:END1

REM rename and copies the normal.dotm
IF EXIST "%APPDATA%\Microsoft\Templates\normal.dotm.old" GOTO END2
copy /y "%APPDATA%\Microsoft\Templates\normal.dotm" "%APPDATA%\Microsoft\Templates\normal.dotm.old"
copy /y "\\fileshare\Ablage\Scripte\normal.dotm" "%APPDATA%\Microsoft\Templates\normal.dotm"
:END2

REM Copies the officeUI which are responsible for setting the ribbon
IF NOT EXIST "C:\Users\%USERNAME%\AppData\Local\Microsoft\Office\Word.officeUI" (copy /y "\\fileshare\Ablage\Scripte\Word.officeUI" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Office\Word.officeUI") ELSE (GOTO END5)
:END3

IF EXIST "C:\Users\%USERNAME%\AppData\Local\Microsoft\Office\Word.officeUI.old" GOTO END4
copy /y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Office\Word.officeUI" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Office\Word.officeUI.old"
copy /y "\\fileshare\Ablage\Scripte\Word.officeUI" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Office\Word.officeUI"
:END4

exit

