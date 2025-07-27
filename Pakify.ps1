# Made by Svznify, PLEASE CREDIT ME FOR THIS PS1 (MIT LICENSE)

function Write-Section($title) {
    Write-Host "`n`e[95m[*] $title`e[0m"
    Write-Host ('=' * 38)
}

function Write-Check($message, [switch]$Success) {
    if ($Success) {
        Write-Host "[√] $message" -ForegroundColor Green
    } else {
        Write-Host "[X] $message" -ForegroundColor Red
    }
}

function Install-Rust {
    Write-Check "Rust not found. Installing Rust..." -Success:$false
    Invoke-WebRequest -Uri "https://win.rustup.rs/x86_64" -OutFile "rustup-init.exe"
    Start-Process -FilePath "rustup-init.exe" -ArgumentList "-y" -Wait
    Remove-Item "rustup-init.exe"
    Write-Check "Rust installed." -Success
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

function Install-VSBuildTools {
    Write-Check "Installing Visual Studio C++ Build Tools..." -Success:$false
    Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_BuildTools.exe" -OutFile "vs_BuildTools.exe"
    Start-Process -FilePath "vs_BuildTools.exe" -ArgumentList "--quiet --wait --norestart --nocache --installPath C:\\BuildTools --add Microsoft.VisualStudio.Workload.VCTools" -Wait
    Remove-Item "vs_BuildTools.exe" -Force
    Write-Check "VS Build Tools installed. Restarting script..." -Success
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

function Check-Dependencies {
    Write-Section "Checking Dependencies"

    if (Get-Command node -ErrorAction SilentlyContinue) {
        Write-Check "NodeJS is already installed." -Success
    } else {
        Write-Check "NodeJS not found. Please install Node.js manually." -Success:$false
        Start-Process "https://nodejs.org"; exit
    }

    if (Get-Command rustc -ErrorAction SilentlyContinue) {
        Write-Check "Rust is already installed." -Success
    } else {
        Install-Rust
    }

    if (-not (Get-Command link.exe -ErrorAction SilentlyContinue)) {
        Write-Check "MSVC Build Tools not found." -Success:$false
        Install-VSBuildTools
    } else {
        Write-Check "MSVC Build Tools found." -Success
    }

    if (Get-Command pake -ErrorAction SilentlyContinue) {
        Write-Check "pake-cli is already installed." -Success
    } else {
        Write-Host "Installing pake-cli globally..."
        npm install -g pake-cli
    }
}

function Get-AppConfiguration {
    Write-Section "App Configuration"
    $global:site = Read-Host "Website URL [https://example.com]"
    if (-not $site) { $site = "https://example.com" }

    $global:appName = Read-Host "App Name [MyPakeApp]"
    if (-not $appName) { $appName = "MyPakeApp" }

    $global:icon = Read-Host "Icon path (.ico, optional) []"

    $global:flags = "--name `"$appName`""
    if ($icon) { $flags += " --icon `"$icon`"" }

    $opt1 = Read-Host "Enable fullscreen? (y/n) [n]"
    if ($opt1 -eq 'y') { $flags += " --fullscreen" }

    $opt2 = Read-Host "Hide title bar? (y/n) [n]"
    if ($opt2 -eq 'y') { $flags += " --hide-title-bar" }

    $opt3 = Read-Host "Disable web shortcuts? (y/n) [n]"
    if ($opt3 -eq 'y') { $flags += " --disable-web-shortcuts" }
}

function Run-Pake {
    Write-Section "Launching pake"
    try {
        $pakePath = "$env:APPDATA\npm\pake.cmd"
        if (Test-Path $pakePath) {
            Start-Process -FilePath $pakePath -ArgumentList "`"$site`" $flags" -Wait -NoNewWindow
            Write-Check "Build complete. '$appName' should be in the output folder." -Success
        } else {
            Write-Check "Could not locate pake.cmd at expected path: $pakePath" -Success:$false
        }
    } catch {
        Write-Check "Failed to run pake. Check if npm bin is in your PATH." -Success:$false
    }

    Write-Host "`n[!] Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

Write-Host @"
 ______     _    _  __       
| ___ \   | |  (_)/ _|      
| |_/ /_ _| | ___| |_ _   _ 
|  __/ _` | |/ / |  _| | | |
| | | (_| |   <| | | | |_| |
\_|  \__,_|_|\_\_|_|  \__, |
                       __/ |
                      |___/ 
        Pakify - Web App to Desktop App Builder using Pake CLI
"@

Check-Dependencies
Get-AppConfiguration
Run-Pake
