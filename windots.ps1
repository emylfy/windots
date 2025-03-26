if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Not running as admin. Elevating..."
    $wtExists = Get-Command wt.exe -ErrorAction SilentlyContinue
    
    if ($wtExists) {
        Start-Process -FilePath 'wt.exe' -ArgumentList "powershell -NoExit -File `"$PSCommandPath`"" -Verb RunAs
    } else {
        Start-Process -FilePath 'powershell.exe' -ArgumentList "-NoExit -File `"$PSCommandPath`"" -Verb RunAs
    }
    exit
}

$Purple = "$([char]0x1b)[38;5;141m"
$Grey = "$([char]0x1b)[38;5;250m"
$Reset = "$([char]0x1b)[0m"
$Red = "$([char]0x1b)[38;5;203m"
$Green = "$([char]0x1b)[38;5;120m"

function Show-MainMenu {
    Clear-Host
    Write-Host "$Purple +-------------------------------------+$Reset"
    Write-Host "$Purple '$Grey [1] Configs Installer               $Purple'$Reset"
    Write-Host "$Purple +-------------------------------------+$Reset"
    Write-Host "$Purple '$Grey [2] Download Rectify11              $Purple'$Reset"
    Write-Host "$Purple '$Grey [3] Install Spotify Tools           $Purple'$Reset"
    Write-Host "$Purple '$Grey [4] Install Steam Millenium + Theme $Purple'$Reset"
    Write-Host "$Purple '$Grey [5] Apply macOS Cursor              $Purple'$Reset"
    Write-Host "$Purple +-------------------------------------+$Reset"
    Write-Host "$Purple '$Grey [6] Launch Simplify11               $Purple'$Reset"
    Write-Host "$Purple +-------------------------------------+$Reset"
    
    $choice = Read-Host ">"
    
    switch ($choice) {
        "1" { Show-ConfigsMenu }
        "2" { Invoke-Rectify11 }
        "3" { Show-SpotifyToolsMenu }
        "4" { Install-Steam }
        "5" { Apply-Cursor }
        "6" { Invoke-Simplify11 }
        default { Show-MainMenu }
    }
}

function Invoke-Rectify11 {
    Start-Process "https://rectify11.net/home"
    Show-MainMenu
}

function Show-SpotifyToolsMenu {
    Clear-Host
    Write-Host "$Purple +-------------------------------------+$Reset"
    Write-Host "$Purple '$Grey [1] Install SpotX                   $Purple'$Reset"
    Write-Host "$Purple '$Grey [2] Install Spicetify               $Purple'$Reset"
    Write-Host "$Purple +-------------------------------------+$Reset"
    Write-Host "$Purple '$Grey [3] Return to Main Menu             $Purple'$Reset"
    Write-Host "$Purple +-------------------------------------+$Reset"
    
    $choice = Read-Host ">"
    
    switch ($choice) {
        "1" { Install-SpotX }
        "2" { Install-Spicetify }
        "3" { Show-MainMenu }
        default { Show-SpotifyToolsMenu }
    }
}

function Install-SpotX {
    Clear-Host
    Write-Host ""
    Write-Host "Installing SpotX..."
    Invoke-Expression (Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1)
    Read-Host "Press Enter to continue"
    Show-SpotifyToolsMenu
}

function Install-Spicetify {
    Clear-Host
    Write-Host ""
    Write-Host "Installing Spicetify..."
    try {
        Invoke-Expression (Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/spicetify/cli/main/install.ps1)
        Write-Host "$Green Spicetify installed successfully.$Reset"
    } catch {
        Write-Host "$Red Failed to install Spicetify.$Reset"
    }
    Read-Host "Press Enter to continue"
    Show-SpotifyToolsMenu
}

function Install-Steam {
    Clear-Host
    Write-Host ""
    Write-Host "Installing Steam Millenium..."
    try {
        Invoke-Expression (Invoke-WebRequest -UseBasicParsing 'https://steambrew.app/install.ps1')
        Write-Host "$Green Steam Millenium installed successfully.$Reset"
    } catch {
        Write-Host "$Red Failed to install Steam Millenium. Make sure steam installed$Reset"
    }
    Read-Host "Press Enter to continue"

    Clear-Host
    Write-Host ""
    Write-Host "$Purple +-------------------------+$Reset"
    Write-Host "$Purple '$Grey Installing Space Theme...      $Purple'$Reset"
    Write-Host "$Purple +-------------------------+$Reset"
    Invoke-Expression (Invoke-WebRequest -UseBasicParsing 'https://spacetheme.de/steam.ps1')
    Read-Host "Press Enter to continue"
    Show-MainMenu
}

function Apply-Cursor {
    Invoke-Item "$env:TEMP\windots\windots-main\cursor\install.inf"
    Show-MainMenu
}

function Invoke-Simplify11 {
    Start-Process powershell -ArgumentList "-Command `"Invoke-WebRequest 'https://dub.sh/simplify11' | Invoke-Expression`""
    Show-MainMenu
}

function Show-ConfigsMenu {
    Clear-Host
    Write-Host "$Purple +-------------------------+$Reset"
    Write-Host "$Purple '$Grey [1] VSCode Based        $Purple'$Reset"
    Write-Host "$Purple +-------------------------+$Reset"
    Write-Host "$Purple '$Grey [2] Windows Terminal    $Purple'$Reset"
    Write-Host "$Purple '$Grey [3] PowerShell          $Purple'$Reset"
    Write-Host "$Purple '$Grey [4] Oh My Posh          $Purple'$Reset"
    Write-Host "$Purple '$Grey [5] FastFetch           $Purple'$Reset"
    Write-Host "$Purple +-------------------------+$Reset"
    Write-Host "$Purple '$Grey [6] Return              $Purple'$Reset"
    Write-Host "$Purple +-------------------------+$Reset"
    
    $choice = Read-Host ">"
    
    switch ($choice) {
        "1" { Show-VSCodeMenu }
        "2" { Configure-WinTerm }
        "3" { Configure-Pwsh }
        "4" { Configure-OhMyPosh }
        "5" { Configure-FastFetch }
        "6" { Show-MainMenu }
        default { Show-ConfigsMenu }
    }
}

function Show-VSCodeMenu {
    Clear-Host
    Write-Host "$Purple +-------------------------+$Reset"
    Write-Host "$Purple '$Grey [1] Visual Studio Code  $Purple'$Reset"
    Write-Host "$Purple '$Grey [2] Aide                $Purple'$Reset"
    Write-Host "$Purple '$Grey [3] Cursor              $Purple'$Reset"
    Write-Host "$Purple '$Grey [4] Windsurf            $Purple'$Reset"
    Write-Host "$Purple '$Grey [5] VSCodium            $Purple'$Reset"
    Write-Host "$Purple '$Grey [6] Trae                $Purple'$Reset"
    Write-Host "$Purple '$Grey [7] Other               $Purple'$Reset"
    Write-Host "$Purple +-------------------------+$Reset"
    Write-Host "$Purple '$Grey [8] Return              $Purple'$Reset"
    Write-Host "$Purple +-------------------------+$Reset"
    
    $choice = Read-Host "Select VSCode-based editor"
    
    switch ($choice) {
        "1" { Configure-VSCode "$env:USERPROFILE\AppData\Roaming\Code\User" }
        "2" { Configure-VSCode "$env:USERPROFILE\AppData\Roaming\Aide\User" }
        "3" { Configure-VSCode "$env:USERPROFILE\AppData\Roaming\Cursor\User" }
        "4" { Configure-VSCode "$env:USERPROFILE\AppData\Roaming\Windsurf\User" }
        "5" { Configure-VSCode "$env:USERPROFILE\AppData\Roaming\VSCodium\User" }
        "6" { Configure-VSCode "$env:USERPROFILE\AppData\Roaming\Trae\User" }
        "7" { Configure-OtherVSC }
        "8" { Show-ConfigsMenu }
        default { Show-VSCodeMenu }
    }
}

function Configure-VSCode {
    param (
        [string]$targetPath
    )
    
    try {
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\vscode\settings.json" -Destination $targetPath -Force
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\vscode\product.json" -Destination $targetPath -Force
        Write-Host "$Green Configuration copied successfully to $targetPath.$Reset"
    } catch {
        Write-Host "$Red Failed to copy configuration to $targetPath.$Reset"
    }
    
    Read-Host "Press Enter to continue"
    Show-VSCodeMenu
}

function Configure-OtherVSC {
    Write-Host ""
    Write-Host "Please specify the path to your VSCode-based editor's user directory:"
    $editorPath = Read-Host "Enter path"
    
    try {
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\vscode\settings.json" -Destination $editorPath -Force
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\vscode\product.json" -Destination $editorPath -Force
        Write-Host "$Green Configuration copied successfully to $editorPath.$Reset"
    } catch {
        Write-Host "$Red Failed to copy configuration to $editorPath.$Reset"
    }
    
    Read-Host "Press Enter to continue"
    Show-VSCodeMenu
}

function Configure-WinTerm {
    try {
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\cli\terminal\settings.json" -Destination "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" -Force
        Write-Host "$Green Windows Terminal settings copied successfully.$Reset"
    } catch {
        Write-Host "$Red Failed to copy Windows Terminal settings.$Reset"
    }
    
    Read-Host "Press Enter to continue"
    Show-ConfigsMenu
}

function Configure-Pwsh {
    try {
        Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\cli\WindowsPowershell\Microsoft.PowerShell_profile.ps1" -Destination "$env:USERPROFILE\Documents\WindowsPowerShell" -Force
        Write-Host "$Green PowerShell profile copied successfully.$Reset"
    } catch {
        Write-Host "$Red Failed to copy PowerShell profile.$Reset"
    }
    
    Read-Host "Press Enter to continue"
    Show-ConfigsMenu
}

function Configure-OhMyPosh {
    try {
        if (-not (Test-Path "$env:USERPROFILE\.config\ohmyposh")) {
            New-Item -Path "$env:USERPROFILE\.config\ohmyposh" -ItemType Directory -Force | Out-Null
        }
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\cli\ohmyposh\zen.toml" -Destination "$env:USERPROFILE\.config\ohmyposh" -Force
        Write-Host "$Green Oh My Posh configuration copied successfully.$Reset"
    } catch {
        Write-Host "$Red Failed to copy Oh My Posh configuration.$Reset"
    }
    
    Read-Host "Press Enter to continue"
    Show-ConfigsMenu
}

function Configure-FastFetch {
    try {
        if (-not (Test-Path "$env:USERPROFILE\.config\fastfetch")) {
            New-Item -Path "$env:USERPROFILE\.config\fastfetch" -ItemType Directory -Force | Out-Null
        }
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\cli\fastfetch\cat.txt" -Destination "$env:USERPROFILE\.config\fastfetch" -Force
        Copy-Item -Path "$env:TEMP\windots\windots-main\config\cli\fastfetch\config.jsonc" -Destination "$env:USERPROFILE\.config\fastfetch" -Force
        Write-Host "$Green FastFetch configuration copied successfully.$Reset"
    } catch {
        Write-Host "$Red Failed to copy FastFetch configuration.$Reset"
    }
    
    Read-Host "Press Enter to continue"
    Show-ConfigsMenu
}

Show-MainMenu