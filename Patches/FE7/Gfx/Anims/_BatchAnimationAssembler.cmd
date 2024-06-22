@echo off

@set "AnimationAssembler=%~dp0/../../../../Tools/AA/AA.exe"

@cd %~dp0/png

@for /d %%i in (.\*) do ( 
@cd %~dp0/png
cd "%%i"  
cd
@for /R %%m in (.) do (
	cd "%%m"
	@rem cd
	if exist *.bin ( 
		@dir *.bin /b > bin.txt
		@for /f "tokens=*" %%n in (bin.txt) do ( 
			if not exist "%%~nn Installer.event" (
			"%AnimationAssembler%" "%%n" 
			)
		)
		@dir *.event /b > event.txt
		@for /f "tokens=*" %%n in (event.txt) do ( 
			if not exist "%~dp0Event/%%i_%%~nn.event" ( 
			@echo "%%~nn.event"
			@copy /-y "%%~nn.event" "%~dp0Event/%%i_%%~nn.event"  > nul 
			)
		)
	)  
) 
)


@rem @del bin.txt

@rem @dir *.event /b/s > event.txt
@rem @for /R "tokens=*" %%m in (event.txt) @copy /-y %%m "%~dp0Event" > nul

@rem @cd %~dp0 

@rem @del "%~dp0bin\*.event"

@echo Done!

pause