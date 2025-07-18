@echo off
REM Configurações
set DATA=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%
set HORA=%TIME:~0,2%
set BACKUP_DIR=C:\Sistema-cegpa
set MYSQL_BIN=C:\xampp\mysql\bin
set MYSQL_USER=root
set MYSQL_DB=cegpa

REM Cria a pasta de backup se não existir
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Faz o backup
"%MYSQL_BIN%\mysqldump.exe" -u %MYSQL_USER% %MYSQL_DB% > "%BACKUP_DIR%\cegpa_%DATA%_%HORA%.sql"

REM Remove arquivos .sql com mais de 7 dias
forfiles /p "%BACKUP_DIR%" /m *.sql /d -7 /c "cmd /c del @path"

REM Comandos do Git com log
cd "%BACKUP_DIR%"
echo %DATE% %TIME% >> backup_log.txt
git add . >> backup_log.txt 2>&1
git commit -m "Backup automático em %DATE% %TIME%" >> backup_log.txt 2>&1
git push origin main >> backup_log.txt 2>&1