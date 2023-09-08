@echo off
setlocal enabledelayedexpansion

rem Define the current folder path
rem Get the directory where the script is located

set "script_folder=%~dp0"
set "stored_data=%script_folder%Files\stored-data.txt"
set "build_data=%script_folder%Files\build.txt"
set "games_folder=%script_folder%Files\Games"
set "live_folder=%script_folder%Files\Games\Live"
set "private_folder=%script_folder%Files\Games\Private"


rem Check if the "Live" folder already exists in the games_folder
if not exist "%games_folder%\Live" (
    set /p "phasmophobia_path=Enter the path to the Phasmophobia folder: "

    if exist "!phasmophobia_path!\" (
        for %%A in ("!phasmophobia_path!\..") do set "parent_folder=%%~fA"
		
		echo "!parent_folder!" > "%stored_data%"
		
		
		
		
        rem Remove double quotes if present in the provided path
        set "phasmophobia_path=!phasmophobia_path:"=!"

        rem Rename and move the folder
        ren "!phasmophobia_path!" "Live"
        move "!parent_folder!\Live" "!games_folder!\"

        echo Folder renamed and moved successfully.
    ) else (
        echo The specified Phasmophobia folder does not exist.
    )
)

rem Check if the "Private" folder already exists in the games_folder
if not exist "%games_folder%\Private" (
    if exist "%script_folder%\depots\739631\12126545" (
        rem Rename and move the folder
        ren "%script_folder%\depots\739631\12126545" "Private"
        move "%script_folder%\depots\739631\Private" "!games_folder!\"

        echo Folder renamed and moved successfully.
		rd /s /q "%script_folder%\depots"
    ) else (
        echo Please run Downgrade.bat first
    )
)

if exist "%games_folder%\Private" (
	if exist "%games_folder%\Live" (
		for %%F in ("%stored_data%") do (
			set "file=%%F"
    
			rem Read the first line of the file
			set "SteamPath="
			set /p "SteamPath="<"!file!"
			set "SteamPath=!SteamPath:~1!"
			set "SteamPath=!SteamPath:~0,-2!"
		)
		for %%F in ("%build_data%") do (
			set "file=%%F"
    
			rem Read the first line of the file
			set "firstLine="
			set /p "firstLine="<"!file!"
			
			rem Check if the first line contains "Live"
			if "!firstLine!"=="Live" (
				rem Replace the first line with "Private"
				(echo Private) > "!file!"
				rmdir !SteamPath!\Phasmophobia
				
				if exist "%symlinkPath%" (
					del "%symlinkPath%"
				)
				
				mklink /d "!SteamPath!\Phasmophobia" "%games_folder%\Private"
				
				echo Now Playing Private Server
				
			) else (
				(echo Live) > "!file!"
				rmdir !SteamPath!\Phasmophobia
				
				if exist "%symlinkPath%" (
					del "%symlinkPath%"
				)
				
				mklink /d "!SteamPath!\Phasmophobia" "%games_folder%\Live"
				echo Now Playing Live Server
				
			)
		)
	)
)
endlocal
pause
