@echo off
rem Drops the development database, installs the schema, seeds the example data and
rem refreshes example-data.sql.
rem
rem Before 1.0 there are no rename migrations: when the entities change, run this.

setlocal
cd /d "%~dp0.."

set DB=dpress_dev
set MYSQL=C:\xampp\mysql\bin\mysql.exe
set MYSQLDUMP=C:\xampp\mysql\bin\mysqldump.exe

echo Recreating %DB%
"%MYSQL%" -u root -e "drop database if exists %DB%; create database %DB% character set utf8;"
if errorlevel 1 exit /b 1

call vendor\bin\dpress install
if errorlevel 1 exit /b 1

php database\seed.php
if errorlevel 1 exit /b 1

echo Writing database\example-data.sql
"%MYSQLDUMP%" -u root --default-character-set=utf8 --skip-dump-date --add-drop-table %DB% > database\example-data.sql
echo Done.
