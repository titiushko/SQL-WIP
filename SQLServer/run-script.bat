@echo off

SQLCMD -S TestSQLServer\SQLEXPRESS  -d AdventureWorks2018 -i "d:\document\sql document\script.sql"
