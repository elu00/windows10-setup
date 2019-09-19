# Description: Boxstarter Script
# Author: Rinik Kumar

# Prevent Windows MAXPATH Limit
# https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
New-Item -Path $ChocoCachePath -ItemType Directory -Force

# Temp Settings
Disable-UAC
Disable-MicrosoftUpdate

# Remove Windows Features
Disable-BingSearch
Disable-GameBarTips
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

Function Remove-Bloatware {
    $bloatware = @(
        "Microsoft.3DBuilder"
        "Microsoft.Appconnector"
        "Microsoft.BingFinance"
        "Microsoft.BingNews"
        "Microsoft.BingSports"
        "Microsoft.BingTranslator"
        "Microsoft.BingWeather"
        "Microsoft.BingFoodAndDrink"
        "Microsoft.BingHealthAndFitness"
        "Microsoft.BingTravel"
        "Microsoft.FreshPaint"
        "Microsoft.GamingServices"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftPowerBIForWindows"
        "Microsoft.MicrosoftStickyNotes"
        "Microsoft.MinecraftUWP"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Messaging"
        "Microsoft.Print3D"
        "Microsoft.Wallet"
        "Microsoft.Windows.Photos"
        "Microsoft.WindowsAlarms"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsPhone"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxGamingOverlay"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.YourPhone"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        "Microsoft.CommsPhone"
        "Microsoft.ConnectivityStore"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsReadingList"
        "Microsoft.MixedReality.Portal"
        "Microsoft.ScreenSketch"
        "Microsoft.YourPhone"
        "Microsoft.Advertising.Xaml"
    )

    foreach ($bloat in $bloatware) {
        Write-Output "Removing $bloat"
        Get-AppxPackage -Name $bloat -AllUsers | Remove-AppxPackage -AllUsers
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $bloat | Remove-AppxProvisionedPackage -Online
    }
}

Remove-Bloatware

# Enable WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
wsl --set-default-version 2

# Install Ubuntu 18.04
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx

# Initalize repo
ubuntu1804 install --root

# Package installs
wsl sudo apt-get update && sudo apt-get upgrade -y && sudo DEBIAN_FRONTEND=noninteractive apt-get -y install neovim build-essential cmake texlive-full latexmk klatexformula && sudo dpkg --add-architecture i386 

# Initialize non-root user
$username = "elu"
wsl sudo adduser $username --gecos "" --disabled-password && echo $username":hehexd" | sudo chpasswd && sudo usermod -a -G sudo $username
ubuntu1804 config --default-user $username

# Non sudo commands
$windows_bash_script_path = [regex]::Escape($PSScriptRoot) + '\\install.sh'
$linux_bash_script_path=(wsl wslpath -a "$windows_bash_script_path")
wsl cp "$linux_bash_script_path" "/tmp/"
wsl bash -c "/tmp/install.sh"

# Vim config
$vim_config_path = [regex]::Escape($PSScriptRoot) + '\\init.vim'
$linux_vim_config_path=(wsl wslpath -a "$vim_config_path")
wsl mkdir ~/.config/
wsl mkdir ~/.config/nvim
wsl cp "$vim_config_path" "~/.config/nvim"


# Cleanup
del Ubuntu.appx

Function Install-Applications {
    choco install -y git -params '"/GitAndUnixToolsOnPath"'     
    RefreshEnv
    cup --cacheLocation="$ChocoCachePath" 7zip
    cup --cacheLocation="$ChocoCachePath" sharex
    cup --cacheLocation="$ChocoCachePath" vscode
    cup --cacheLocation="$ChocoCachePath" miniconda3
    cup --cacheLocation="$ChocoCachePath" firefox
    cup --cacheLocation="$ChocoCachePath" discord
    cup --cacheLocation="$ChocoCachePath" qbittorrent 
    cup --cacheLocation="$ChocoCachePath" irfanview 
    cup --cacheLocation="$ChocoCachePath" sumatrapdf 
    cup --cacheLocation="$ChocoCachePath" keytweak 
    cup --cacheLocation="$ChocoCachePath" google-backup-and-sync  
}
Function Install-Fonts {
    $fontFiles = New-Object 'System.Collections.Generic.List[System.IO.FileInfo]'
    Get-ChildItem $PSScriptRoot -Filter "*.ttf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
    Get-ChildItem $PSScriptRoot -Filter "*.otf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
    echo $PSScriptRoot

    $fonts = $null
    foreach ($fontFile in $fontFiles) {
        echo ("Installing " + $fontFile.Name)
        if (!$fonts) {
            $shellApp = New-Object -ComObject shell.application
            $fonts = $shellApp.NameSpace(0x14)
        }
        $fonts.CopyHere($fontFile.FullName)
    }

}

# Install Packages
Install-Applications 
Install-Fonts


# Update Hostname
$computerName = Read-Host 'Enter Hostname'
Rename-Computer -NewName $computerName

# Generate SSH Key
#$email = Read-Host "Enter Email"
#ssh-keygen -t rsa -b 4096 -C "$email"

# Clean C:\
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*

# Restore Temp Settings
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
