@echo off
REM ================= CONFIGURAÇÕES =================
set DATA=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%
set HORA=%TIME:~0,2%
if "%HORA:~0,1%"==" " set HORA=0%HORA:~1,1%  REM Corrige hora com espaço inicial

set BACKUP_DIR=C:\Sistema-cegpa\backups_BD
set MYSQL_BIN=C:\xampp\mysql\bin
set MYSQL_USER=root
set MYSQL_DB=cegpa

REM ================ CRIA A PASTA DE BACKUP ================
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM ================= FAZ O BACKUP =================
"%MYSQL_BIN%\mysqldump.exe" -u %MYSQL_USER% %MYSQL_DB% > "%BACKUP_DIR%\cegpa_%DATA%_%HORA%.sql"

REM ============ REMOVE BACKUPS ANTIGOS =============
pushd "%BACKUP_DIR%"
for /f "skip=7 delims=" %%F in ('dir /b /a-d /o-d *.sql') do del "%%F"
popd

REM ================== CONTROLE DE VERSÃO ==================
cd /d "%BACKUP_DIR%"
echo %DATE% %TIME% >> backup_log.txt
git add . >> backup_log.txt 2>&1
git commit -m "Backup automático em %DATE% %TIME%" >> backup_log.txt 2>&1
git push origin main >> backup_log.txt 2>&1

REM =========== CÓPIA DA PASTA COMO UM TODO PARA O GOOGLE DRIVE ===========
xcopy "C:\Sistema-cegpa\backups_BD\\" "G:\Meu Drive\backups_BD\\" /E /I /Y

REM =================== FIM ===================
