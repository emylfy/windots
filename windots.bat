@echo off
setlocal EnableDelayedExpansion
net session >nul 2>&1 || (
    echo Not running as admin. Elevating...
    where wt.exe >nul 2>&1
    if %errorlevel% equ 0 (
        powershell -Command "Start-Process -FilePath 'wt.exe' -ArgumentList 'cmd /k \"%~0\"' -Verb runAs"
    ) else (
        powershell -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList '/k \"%~0\"' -Verb runAs"
    )
    exit /b
)

set Purple=[38;5;141m
set Grey=[38;5;250m
set Reset=[0m
set Red=[38;5;203m
set Green=[38;5;120m

:mainMenu
cls
echo %Purple% +-------------------------------------+%Reset%
echo %Purple% '%Grey% [1] Configs Installer               %Purple%'%Reset%
echo %Purple% +-------------------------------------+%Reset%
echo %Purple% '%Grey% [2] Download Rectify11              %Purple%'%Reset%
echo %Purple% '%Grey% [3] Install Spotify Tools           %Purple%'%Reset%
echo %Purple% '%Grey% [4] Install Steam Millenium + Theme %Purple%'%Reset%
echo %Purple% '%Grey% [5] Apply macOS Cursor              %Purple%'%Reset%
echo %Purple% +-------------------------------------+%Reset%
echo %Purple% '%Grey% [6] Launch Simplify11               %Purple%'%Reset%
echo %Purple% +-------------------------------------+%Reset%
choice /C 123456 /N /M ">"
set /a "mainChoice=%errorlevel%"

if %mainChoice% equ 1 goto configsMenu
if %mainChoice% equ 2 goto rectify11
if %mainChoice% equ 3 goto spotifyToolsMenu
if %mainChoice% equ 4 goto installSteam
if %mainChoice% equ 5 goto applyCursor
if %mainChoice% equ 6 goto simplify11

:rectify11
start "" https://rectify11.net/home
goto mainMenu

:spotifyToolsMenu
cls
echo %Purple% +-------------------------------------+%Reset%
echo %Purple% '%Grey% [1] Install SpotX                %Purple%'%Reset%
echo %Purple% '%Grey% [2] Install Spicetify            %Purple%'%Reset%
echo %Purple% +-------------------------------------+%Reset%
echo %Purple% '%Grey% [3] Return to Main Menu          %Purple%'%Reset%
echo %Purple% +-------------------------------------+%Reset%
choice /C 123 /N /M ">"
set /a "spotifyChoice=%errorlevel%"

if %spotifyChoice% equ 1 goto installSpotX
if %spotifyChoice% equ 2 goto installSpicetify
if %spotifyChoice% equ 3 goto mainMenu

:installSpotX
cls
echo.
echo Installing SpotX...
powershell -Command "iex \"& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1') } -new_theme\""
if %errorlevel% equ 0 (
    echo %Green%SpotX installed successfully.%Reset%
) else (
    echo %Red%Failed to install SpotX.%Reset%
)
pause
goto spotifyToolsMenu

:installSpicetify
cls
echo.
echo Installing Spicetify...
powershell -Command "iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex"
if %errorlevel% equ 0 (
    echo %Green%Spicetify installed successfully.%Reset%
) else (
    echo %Red%Failed to install Spicetify.%Reset%
)
pause
goto spotifyToolsMenu

:installSteam
cls
echo.
echo Installing Steam Millenium...
powershell -Command "iwr -useb 'https://steambrew.app/install.ps1' | iex"
if %errorlevel% equ 0 (
    echo %Green%Steam Millenium installed successfully.%Reset%
) else (
    echo %Red%Failed to install Steam Millenium. Make sure steam installed%Reset%
)
pause

cls
echo.
echo %Purple% +----------------------------------------+%Reset%
echo %Purple% '%Grey% Installing Space Theme...         %Purple%'%Reset%
echo %Purple% +----------------------------------------+%Reset%
powershell -Command "iwr -useb 'https://spacetheme.de/steam.ps1' | iex"
if %errorlevel% equ 0 (
    echo %Green%Space Theme installed successfully.%Reset%
) else (
    echo %Red%Failed to install Space Theme.%Reset%
)
pause
goto mainMenu

:applyCursor
explorer /select,%TEMP%\windots\windots-main\cursor\install.inf
goto mainMenu

:simplify11
start cmd /k powershell -Command "iwr 'https://dub.sh/simplify11' | iex"
goto mainMenu

@REM Install required fonts
@REM https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
@REM https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip

:configsMenu
cls
echo %Purple% +-------------------------+%Reset%
echo %Purple% '%Grey% [1] VSCode Based        %Purple%'%Reset%
echo %Purple% +-------------------------+%Reset%
echo %Purple% '%Grey% [2] Windows Terminal    %Purple%'%Reset%
echo %Purple% '%Grey% [3] PowerShell          %Purple%'%Reset%
echo %Purple% '%Grey% [4] Oh My Posh          %Purple%'%Reset%
echo %Purple% '%Grey% [5] FastFetch           %Purple%'%Reset%
echo %Purple% +-------------------------+%Reset%
echo %Purple% '%Grey% [6] Return              %Purple%'%Reset%
echo %Purple% +-------------------------+%Reset%
choice /C 123456 /N /M ">"
set /a "configChoice=%errorlevel%"

if %configChoice% equ 1 goto VSCodeMenu
if %configChoice% equ 2 goto WinTerm
if %configChoice% equ 3 goto Pwsh
if %configChoice% equ 4 goto OhMyPosh
if %configChoice% equ 5 goto FastFetch
if %configChoice% equ 6 goto mainMenu

@REM https://raindrop.io/emylfy/vs-code-51485648
:VSCodeMenu
cls
echo %Purple% +-------------------------+%Reset%
echo %Purple% '%Grey% [1] Visual Studio Code  %Purple%'%Reset%
echo %Purple% '%Grey% [2] Aide                %Purple%'%Reset%
echo %Purple% '%Grey% [3] Cursor              %Purple%'%Reset%
echo %Purple% '%Grey% [4] Windsurf            %Purple%'%Reset%
echo %Purple% '%Grey% [5] VSCodium            %Purple%'%Reset%
echo %Purple% '%Grey% [6] Other               %Purple%'%Reset%
echo %Purple% +-------------------------+%Reset%
echo %Purple% '%Grey% [7] Return              %Purple%'%Reset%
echo %Purple% +-------------------------+%Reset%
choice /C 1234567 /N /M "Select VSCode-based editor: "
set /a "vscodeChoice=%errorlevel%"

if %vscodeChoice% equ 1 goto VSCode
if %vscodeChoice% equ 2 goto Aide
if %vscodeChoice% equ 3 goto Cursor
if %vscodeChoice% equ 4 goto Windsurf
if %vscodeChoice% equ 5 goto VSCodium
if %vscodeChoice% equ 6 goto OtherVSC
if %vscodeChoice% equ 7 goto configsMenu

:Aide
xcopy /y "%TEMP%\windots\windots-main\config\vscode\settings.json" "%userprofile%\AppData\Roaming\Aide\User"
xcopy /y "%TEMP%\windots\windots-main\config\vscode\product.json" "%userprofile%\AppData\Roaming\Aide\User"
if %errorlevel% equ 0 (
    echo %Green%Aide configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy Aide configuration.%Reset%
)
pause
goto VSCodeMenu

:Cursor
xcopy /y "%TEMP%\windots\windots-main\config\vscode\settings.json" "%userprofile%\AppData\Roaming\Cursor\User"
xcopy /y "%TEMP%\windots\windots-main\config\vscode\product.json" "%userprofile%\AppData\Roaming\Cursor\User"
if %errorlevel% equ 0 (
    echo %Green%Cursor configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy Cursor configuration.%Reset%
)
pause
goto VSCodeMenu

:Windsurf
xcopy /y "%TEMP%\windots\windots-main\config\vscode\settings.json" "%userprofile%\AppData\Roaming\Windsurf\User"
xcopy /y "%TEMP%\windots\windots-main\config\vscode\product.json" "%userprofile%\AppData\Roaming\Windsurf\User"
if %errorlevel% equ 0 (
    echo %Green%Windsurf configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy Windsurf configuration.%Reset%
)
pause
goto VSCodeMenu

:VSCodium
xcopy /y "%TEMP%\windots\windots-main\config\vscode\settings.json" "%userprofile%\AppData\Roaming\VSCodium\User"
xcopy /y "%TEMP%\windots\windots-main\config\vscode\product.json" "%userprofile%\AppData\Roaming\VSCodium\User"
if %errorlevel% equ 0 (
    echo %Green%VSCodium configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy VSCodium configuration.%Reset%
)
pause
goto VSCodeMenu

:VSCode
xcopy /y "%TEMP%\windots\windots-main\config\vscode\settings.json" "%userprofile%\AppData\Roaming\Code\User"
xcopy /y "%TEMP%\windots\windots-main\config\vscode\product.json" "%userprofile%\AppData\Roaming\Code\User"
if %errorlevel% equ 0 (
    echo %Green%Visual Studio Code configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy Visual Studio Code configuration.%Reset%
)
pause
goto VSCodeMenu

:OtherVSC
echo.
echo Please specify the path to your VSCode-based editor's user directory:
set /p editorPath=Enter path: 
xcopy /y "%TEMP%\windots\windots-main\config\vscode\settings.json" "%editorPath%"
xcopy /y "%TEMP%\windots\windots-main\config\vscode\product.json" "%editorPath%"
if %errorlevel% equ 0 (
    echo %Green%Configuration copied successfully to %editorPath%.%Reset%
) else (
    echo %Red%Failed to copy configuration to %editorPath%.%Reset%
)
pause
goto VSCodeMenu

:WinTerm
xcopy /y "%TEMP%\windots\windots-main\config\cli\terminal\settings.json" "%userprofile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
if %errorlevel% equ 0 (
    echo %Green%Windows Terminal settings copied successfully.%Reset%
) else (
    echo %Red%Failed to copy Windows Terminal settings.%Reset%
)
pause
goto configsMenu

:Pwsh
powershell -Command "Install-Module -Name Terminal-Icons -Scope CurrentUser"
xcopy /y "%TEMP%\windots\windots-main\config\cli\WindowsPowershell\Microsoft.PowerShell_profile.ps1" "%userprofile%\Documents\WindowsPowerShell"
if %errorlevel% equ 0 (
    echo %Green%PowerShell profile copied successfully.%Reset%
) else (
    echo %Red%Failed to copy PowerShell profile.%Reset%
)
pause
goto configsMenu

:OhMyPosh
xcopy /y "%TEMP%\windots\windots-main\config\cli\ohmyposh\zen.toml" "%userprofile%\.config\ohmyposh"
if %errorlevel% equ 0 (
    echo %Green%Oh My Posh configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy Oh My Posh configuration.%Reset%
)
pause
goto configsMenu

:FastFetch
xcopy /y "%TEMP%\windots\windots-main\config\cli\fastfetch\cat.txt" "%userprofile%\.config\fastfetch"
xcopy /y "%TEMP%\windots\windots-main\config\cli\fastfetch\config.jsonc" "%userprofile%\.config\fastfetch"
if %errorlevel% equ 0 (
    echo %Green%FastFetch configuration copied successfully.%Reset%
) else (
    echo %Red%Failed to copy FastFetch configuration.%Reset%
)
pause
goto configsMenu