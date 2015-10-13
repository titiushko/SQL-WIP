@echo off
net stop OracleServiceXE
if ERRORLEVEL 1 echo Problem while stopping Oracle Service XE
 
net stop OracleXETNSListener 
if ERRORLEVEL 1 echo Problem while stopping Oracle XE Listener service
pause
exit
