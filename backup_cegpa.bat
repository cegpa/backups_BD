@echo off
REM Configurações
set DATA=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%
set HORA=%TIME:~0,2%
set BACKUP_DIR=C:\Sistema-cegpa\backups_BD
set MYSQL_BIN=C:\xampp\mysql\bin
set MYSQL_USER=root
set MYSQL_DB=cegpa

REM Cria a pasta de backup se não existir
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Faz o backup
"%MYSQL_BIN%\mysqldump.exe" -u %MYSQL_USER% %MYSQL_DB% > "%BACKUP_DIR%\\cegpa_%DATA%_%HORA%.sql"

REM Mantém apenas os 7 arquivos .sql mais recentes, apaga os mais antigos
pushd "%BACKUP_DIR%"
for /f "skip=7 delims=" %%F in ('dir /b /a-d /o-d *.sql') do del "%%F"
popd

REM Comandos do Git com log
cd /d "%BACKUP_DIR%"
echo %DATE% %TIME% >> backup_log.txt
git add . >> backup_log.txt 2>&1
git commit -m "Backup automático em %DATE% %TIME%" >> backup_log.txt 2>&1
git push origin main >> backup_log.txt 2>&1

REM Copia a pasta de backup para o Google Drive
xcopy "C:\\Sistema-cegpa\\backups_BD" "G:\\Meu Drive\\backups_BD" /E /I /Y