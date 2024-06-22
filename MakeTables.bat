@echo off
set "c2ea=%~dp0Tools\C2EA\c2ea"
set "base_dir=%~dp0"
set "source_rom=%~dp0fe7.gba"
cd "%base_dir%Patches\FE7\Tables"
@echo: | ("%c2ea%" "%source_rom%" -installer "%base_dir%Patches\FE7\Tables\TableInstaller.event")
@echo: 
set "source_rom=%~dp0fe6.gba"
cd "%base_dir%Patches\FE6\Tables"
@echo: | ("%c2ea%" "%source_rom%" -installer "%base_dir%Patches\FE6\Tables\TableInstaller.event")
@echo: 

pause