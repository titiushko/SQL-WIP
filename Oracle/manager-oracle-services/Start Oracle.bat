@echo off
net start OracleServiceXE
if ERRORLEVEL 1 echo Problem while starting Oracle Service XE
 
net start OracleXETNSListener
if ERRORLEVEL 1 echo Problem while starting Oracle XE Listener service
pause
exit
