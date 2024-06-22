@echo off

@set "Png2Dmp=%~dp0\..\..\..\..\EventAssembler\Tools\Png2Dmp.exe"

@cd %~dp0/MMS
@dir *.png /b > png.txt

@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%~m" --lz77)

@cd %~dp0

@copy "%~dp0MMS\*.dmp" "%~dp0dmp" > nul

@del "%~dp0MMS\*.dmp"
@del "%~dp0MMS\png.txt"

@cd %~dp0/SMS
@dir *.png /b > png.txt

@for /f "tokens=*" %%m in (png.txt) do ("%Png2Dmp%" "%%~m" --lz77)

@cd %~dp0

@copy "%~dp0SMS\*.dmp" "%~dp0dmp" > nul

@del "%~dp0SMS\*.dmp"
@del "%~dp0SMS\png.txt"

echo Done!

pause


