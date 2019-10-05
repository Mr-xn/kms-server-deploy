@ECHO OFF&PUSHD %~DP0

setlocal EnableDelayedExpansion&color 3e & cd /d "%~dp0"

title office系列 retail转换vol版

%1 %2

mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof

:runas

if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office16"

if exist "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office16"

if exist "%ProgramFiles%\Microsoft Office\Office15\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office15"

if exist "%ProgramFiles(x86)%\Microsoft Office\Office15\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office15"

if exist "%ProgramFiles%\Microsoft Office\Office14\ospp.vbs" cd /d "%ProgramFiles%\Microsoft Office\Office14"

if exist "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" cd /d "%ProgramFiles(x86)%\Microsoft Office\Office14"

:WH

cls

echo.

echo 选择需要转化的office版本序号---葡萄

echo.

echo --------------------------------------------------------------------------------

echo 1. 零售版 Office Pro Plus 2016 转化为VOL版

echo.

echo 2. 零售版 Office Visio Pro 2016 转化为VOL版

echo.

echo 3. 零售版 Office Project Pro 2016 转化为VOL版

echo.

echo 4. 零售版 Office Pro Plus 2013 转化为VOL版

echo.

echo 5. 零售版 Office Visio Pro 2013 转化为VOL版

echo.

echo 6. 零售版 Office Project Pro 2013 转化为VOL版

echo.

echo 7. 零售版 Office Pro Plus 2010 转化为VOL版

echo.

echo 8. 零售版 Office Visio Pro 2010 转化为VOL版

echo.

echo 9. 零售版 Office Project Pro 2010 转化为VOL版

echo.

echo. --------------------------------------------------------------------------------

set /p tsk="请输入需要转化的office版本序号【回车】确认（1-9）: "

if not defined tsk goto:err

if %tsk%==1 goto:1

if %tsk%==2 goto:2

if %tsk%==3 goto:3

if %tsk%==4 goto:4

if %tsk%==5 goto:5

if %tsk%==6 goto:6

if %tsk%==7 goto:7

if %tsk%==8 goto:8

if %tsk%==9 goto:9

:err

goto:WH

:1

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses16\proplusvl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses16\proplusvl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul

cscript ospp.vbs /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99

goto :e

:2

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses16\visio???vl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses16\visio???vl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul

cscript ospp.vbs /inpkey:PD3PC-RHNGV-FXJ29-8JK7D-RJRJK

goto :e

:3

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses16\project???vl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses16\project???vl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%%x" >nul

cscript ospp.vbs /inpkey:YG9NW-3K39V-2T3HJ-93F3Q-G83KT

goto :e

:4

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses15\proplusvl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses15\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses15\proplusvl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses15\%%x" >nul

set /p y=请输入激活密钥，按回车确定:

cscript ospp.vbs /inpkey:YC7DK-G2NP3-2QQC3-J6H88-GVGXT

goto :e

:5

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses15\visio???vl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses15\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses15\visio???vl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses15\%%x" >nul

cscript ospp.vbs /inpkey:C2FG9-N6J68-H8BTJ-BW3QX-RM3B3

goto :e

:6

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses15\project???vl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses15\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses15\project???vl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses15\%%x" >nul

cscript ospp.vbs /inpkey:FN8TT-7WMH6-2D4X9-M337T-2342K

goto :e

:7

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses14\proplusvl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses14\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses14\proplusvl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses14\%%x" >nul

cscript ospp.vbs /inpkey:VYBBJ-TRJPB-QFQRF-QFT4D-H3GVB

goto :e

:8

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses14\visio???vl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses14\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses14\visio???vl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses14\%%x" >nul

cscript ospp.vbs /inpkey:7MCW8-VRQVK-G677T-PDJCM-Q8TCP

goto :e

:9

cls

echo 正在安装 KMS 许可证...

for /f %%x in ('dir /b ..\root\Licenses14\project???vl_kms*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses14\%%x" >nul

echo 正在安装 MAK 许可证...

for /f %%x in ('dir /b ..\root\Licenses14\project???vl_mak*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses14\%%x" >nul

cscript ospp.vbs /inpkey:YGX6F-PGV49-PGW3J-9BTGG-VHKC6

goto :e
:e

echo.

echo 转化完成，按任意键退出！

pause >nul

exit