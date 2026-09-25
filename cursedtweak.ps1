#Requires -Version 5.1

# ============================================================
# CURSED UTIL
# Dark Windows Maintenance / Tweaking Utility
# ============================================================

$ErrorActionPreference = "SilentlyContinue"

# ------------------------------------------------------------
# THEME
# ------------------------------------------------------------

$C = @{
    Black   = "Black"
    Dark    = "DarkGray"
    Purple  = "DarkGray"
    Magenta = "White"
    Green   = "White"
    Cyan    = "White"
    White   = "White"
    Gray    = "Gray"
    Red     = "White"
    Yellow  = "White"
}

try {
    $Host.UI.RawUI.WindowTitle = "CURSED // Windows Utility"
    $Host.UI.RawUI.BackgroundColor = "Black"
    $Host.UI.RawUI.ForegroundColor = "White"
} catch {}

# ------------------------------------------------------------
# BASIC HELPERS
# ------------------------------------------------------------

function Clear-Cursed {
    Clear-Host
}

function Pause-Cursed {
    Write-Host ""
    Write-Host "  [ ENTER ] " -ForegroundColor White -NoNewline
    Write-Host "continue..." -ForegroundColor DarkGray
    Read-Host | Out-Null
}

function Write-Line {
    param(
        [int]$Length = 72
    )

    Write-Host ("  " + ("─" * $Length)) -ForegroundColor DarkGray
}

function Write-Panel {
    param(
        [string]$Title,
        [string[]]$Lines,
        [string]$Color = "White"
    )

    $width = 68

    Write-Host ""
    Write-Host ("  ╭" + ("─" * $width) + "╮") -ForegroundColor White
    Write-Host ("  │ " + $Title.PadRight($width - 1) + "│") -ForegroundColor White
    Write-Host ("  ├" + ("─" * $width) + "┤") -ForegroundColor White

    foreach ($line in $Lines) {
        if ($line.Length -gt ($width - 3)) {
            $line = $line.Substring(0, $width - 3)
        }

        Write-Host ("  │ " + $line.PadRight($width - 1) + "│") -ForegroundColor White
    }

    Write-Host ("  ╰" + ("─" * $width) + "╯") -ForegroundColor White
}

# ------------------------------------------------------------
# ADMIN
# ------------------------------------------------------------

function Test-CursedAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)

    return $principal.IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
}

function Require-Admin {
    if (-not (Test-CursedAdmin)) {
        Write-Host ""
        Write-Host "  [!] Administrator privileges are required." -ForegroundColor White
        Write-Host "  [!] Restart PowerShell as Administrator." -ForegroundColor DarkGray
        Pause-Cursed
        return $false
    }

    return $true
}

# ------------------------------------------------------------
# HEADER
# ------------------------------------------------------------

function Show-CursedHeader {
    Clear-Cursed

    Write-Host ""
    Write-Host "          ██████╗██╗   ██╗██████╗ ███████╗██████╗ " -ForegroundColor White
    Write-Host "         ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗" -ForegroundColor White
    Write-Host "         ██║     ██║   ██║██████╔╝█████╗  ██║  ██║" -ForegroundColor White
    Write-Host "         ██║     ██║   ██║██╔══██╗██╔══╝  ██║  ██║" -ForegroundColor White
    Write-Host "         ╚██████╗╚██████╔╝██║  ██║███████╗██████╔╝" -ForegroundColor White
    Write-Host "          ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ " -ForegroundColor White

    Write-Host ""
    Write-Host "                 C U R S E D   U T I L" -ForegroundColor White
    Write-Host "             WINDOWS MAINTENANCE CONSOLE" -ForegroundColor DarkGray
    Write-Host ""

    Write-Line -Length 72
}

# ------------------------------------------------------------
# KEYAUTH CONFIGURATION
# ------------------------------------------------------------

$KeyAuth = @{
    Name    = "twek"
    OwnerId = "CyovVRdYeg"
    Version = "1.0"
}

$script:KeyAuthSession = $null

# ------------------------------------------------------------
# KEYAUTH REQUEST
# ------------------------------------------------------------

function Invoke-KeyAuthRequest {
    param(
        [hashtable]$Parameters
    )

    try {
        $query = ($Parameters.GetEnumerator() | ForEach-Object {
            "{0}={1}" -f `
                [uri]::EscapeDataString([string]$_.Key),
                [uri]::EscapeDataString([string]$_.Value)
        }) -join "&"

        $uri = "https://keyauth.win/api/1.3/?$query"

        return Invoke-RestMethod `
            -Uri $uri `
            -Method Get `
            -UseBasicParsing `
            -TimeoutSec 15
    }
    catch {
        return $null
    }
}

# ------------------------------------------------------------
# KEYAUTH INITIALIZATION
# ------------------------------------------------------------

function Initialize-KeyAuth {

    $response = Invoke-KeyAuthRequest @{
        type   = "init"
        ver    = $KeyAuth.Version
        name   = $KeyAuth.Name
        ownerid = $KeyAuth.OwnerId
    }

    if ($null -eq $response) {
        return $false
    }

    if (-not $response.success) {
        return $false
    }

    $script:KeyAuthSession = $response.sessionid

    return $true
}

# ------------------------------------------------------------
# AUTH SCREEN
# ------------------------------------------------------------

function Show-CursedAuth {

    Clear-Cursed

    Write-Host ""
    Write-Host "          ██████╗██╗   ██╗██████╗ ███████╗██████╗ " -ForegroundColor White
    Write-Host "         ██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗" -ForegroundColor White
    Write-Host "         ██║     ██║   ██║██████╔╝█████╗  ██║  ██║" -ForegroundColor White
    Write-Host "         ██║     ██║   ██║██╔══██╗██╔══╝  ██║  ██║" -ForegroundColor White
    Write-Host "         ╚██████╗╚██████╔╝██║  ██║███████╗██████╔╝" -ForegroundColor White
    Write-Host "          ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ " -ForegroundColor White

    Write-Host ""
    Write-Host "                   C U R S E D   A U T H" -ForegroundColor White
    Write-Host ""

    Write-Line -Length 72

    Write-Host ""
    Write-Host "       ╭────────────────────────────────────────────╮" -ForegroundColor White
    Write-Host "       │                                            │" -ForegroundColor White
    Write-Host "       │             LICENSE AUTHENTICATION         │" -ForegroundColor White
    Write-Host "       │                                            │" -ForegroundColor White
    Write-Host "       ╰────────────────────────────────────────────╯" -ForegroundColor White

    Write-Host ""
    Write-Host "       [i] Enter your Cursed license key." -ForegroundColor DarkGray
    Write-Host ""

    $key = Read-Host "       KEY"

    if ([string]::IsNullOrWhiteSpace($key)) {
        return $false
    }

    Write-Host ""
    Write-Host "       [*] Connecting to authentication server..." -ForegroundColor DarkGray

    if (-not (Initialize-KeyAuth)) {
        Write-Host ""
        Write-Host "       [-] Could not initialize authentication." -ForegroundColor White
        Write-Host "       [-] Check your KeyAuth application settings." -ForegroundColor DarkGray
        Start-Sleep -Seconds 2
        return $false
    }

    Write-Host "       [+] Authentication server connected." -ForegroundColor White
    Write-Host "       [*] Validating license..." -ForegroundColor DarkGray

    $response = Invoke-KeyAuthRequest @{
        type      = "license"
        key       = $key
        sessionid = $KeyAuthSession
        name      = $KeyAuth.Name
        ownerid   = $KeyAuth.OwnerId
        hwid      = ""
        code      = ""
    }

    if ($null -eq $response) {
        Write-Host ""
        Write-Host "       [-] Authentication server unavailable." -ForegroundColor White
        Start-Sleep -Seconds 2
        return $false
    }

    if (-not $response.success) {

        Write-Host ""
        Write-Host "       ╭────────────────────────────────────────────╮" -ForegroundColor White
        Write-Host "       │                                            │" -ForegroundColor White
        Write-Host "       │              ACCESS DENIED                 │" -ForegroundColor White
        Write-Host "       │                                            │" -ForegroundColor White

        $message = [string]$response.message

        if ($message.Length -gt 42) {
            $message = $message.Substring(0, 42)
        }

        Write-Host ("       │  " + $message.PadRight(42) + "│") -ForegroundColor White
        Write-Host "       │                                            │" -ForegroundColor White
        Write-Host "       ╰────────────────────────────────────────────╯" -ForegroundColor White

        Start-Sleep -Seconds 3
        return $false
    }

    Write-Host ""
    Write-Host "       ╭────────────────────────────────────────────╮" -ForegroundColor White
    Write-Host "       │                                            │" -ForegroundColor White
    Write-Host "       │              ACCESS GRANTED                │" -ForegroundColor White
    Write-Host "       │                                            │" -ForegroundColor White
    Write-Host "       ╰────────────────────────────────────────────╯" -ForegroundColor White

    Start-Sleep -Seconds 1

    return $true
}

function Start-CursedAuth {

    $attempts = 0
    $maxAttempts = 5

    while ($attempts -lt $maxAttempts) {

        if (Show-CursedAuth) {
            return $true
        }

        $attempts++

        if ($attempts -lt $maxAttempts) {
            Write-Host ""
            Write-Host "       Attempts remaining: $($maxAttempts - $attempts)" -ForegroundColor DarkGray
            Start-Sleep -Seconds 1
        }
    }

    Clear-Cursed

    Write-Host ""
    Write-Host "       ╔════════════════════════════════════════════╗" -ForegroundColor White
    Write-Host "       ║                                            ║" -ForegroundColor White
    Write-Host "       ║          AUTHENTICATION LOCKED             ║" -ForegroundColor White
    Write-Host "       ║                                            ║" -ForegroundColor White
    Write-Host "       ║       Too many failed attempts.            ║" -ForegroundColor White
    Write-Host "       ║                                            ║" -ForegroundColor White
    Write-Host "       ╚════════════════════════════════════════════╝" -ForegroundColor White

    Start-Sleep -Seconds 3

    return $false
}

# ------------------------------------------------------------
# SYSTEM INFORMATION
# ------------------------------------------------------------

function Get-CursedSystemInfo {

    $computer = Get-CimInstance Win32_ComputerSystem
    $os = Get-CimInstance Win32_OperatingSystem

    $ramGB = [math]::Round(
        $computer.TotalPhysicalMemory / 1GB,
        1
    )

    $uptime = (Get-Date) - $os.LastBootUpTime

    $admin = if (Test-CursedAdmin) {
        "ADMIN"
    } else {
        "USER"
    }

    # CPU
    $cpu = Get-CimInstance Win32_Processor |
        Select-Object -First 1

    $cpuName = if ($cpu.Name) {
        $cpu.Name.Trim()
    } else {
        "Unknown"
    }

    # GPU
    $gpus = Get-CimInstance Win32_VideoController |
        Where-Object {
            $_.Name -and
            $_.Name -notmatch "Microsoft Basic Display"
        }

    if ($gpus) {
        $gpuName = ($gpus | ForEach-Object {
            $_.Name.Trim()
        }) -join ", "
    }
    else {
        $gpuName = "Unknown"
    }

    # DISKS
    $physicalDisks = Get-CimInstance Win32_DiskDrive

    $ssdCount = @(
        $physicalDisks |
        Where-Object {
            $_.MediaType -match "SSD" -or
            $_.Model -match "SSD|NVMe"
        }
    ).Count

    $hddCount = @(
        $physicalDisks |
        Where-Object {
            $_.Model -notmatch "SSD|NVMe"
        }
    ).Count

    # C: drive
    $systemDrive = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

    if ($systemDrive) {

        $freeGB = [math]::Round(
            $systemDrive.FreeSpace / 1GB,
            1
        )

        $sizeGB = [math]::Round(
            $systemDrive.Size / 1GB,
            1
        )

        $usedGB = [math]::Round(
            ($systemDrive.Size - $systemDrive.FreeSpace) / 1GB,
            1
        )

        $storage = "$usedGB / $sizeGB GB used | $freeGB GB free"
    }
    else {
        $storage = "Unavailable"
    }

    return @(
        "PC       : $($computer.Name)"
        "USER     : $env:USERNAME"
        "OS       : $($os.Caption)"
        "BUILD    : $($os.BuildNumber)"
        ""
        "CPU      : $cpuName"
        "GPU      : $gpuName"
        "RAM      : $ramGB GB"
        "SSD      : $ssdCount detected"
        "HDD      : $hddCount detected"
        "STORAGE  : $storage"
        ""
        "UPTIME   : $([int]$uptime.TotalDays)d $($uptime.Hours)h $($uptime.Minutes)m"
        "PRIV     : $admin"
    )
}

# ------------------------------------------------------------
# HOME
# ------------------------------------------------------------

function Show-Home {

    Show-CursedHeader

    $info = Get-CursedSystemInfo

    Write-Panel `
        -Title "SYSTEM STATUS" `
        -Lines $info

    Write-Host ""
    Write-Host "  ┌─ MAIN MENU ─────────────────────────────────────────────┐" -ForegroundColor White
    Write-Host "  │                                                         │" -ForegroundColor White
    Write-Host "  │   [1] APPLICATIONS       [5] NETWORK                   │" -ForegroundColor White
    Write-Host "  │   [2] WINDOWS TWEAKS    [6] REPAIR                    │" -ForegroundColor White
    Write-Host "  │   [3] CLEANUP           [7] TOOLS                     │" -ForegroundColor White
    Write-Host "  │   [4] WINDOWS            [8] SETTINGS                  │" -ForegroundColor White
    Write-Host "  │                                                         │" -ForegroundColor White
    Write-Host "  │   [9] SOCIALS                                             │" -ForegroundColor White
    Write-Host "  │                                                         │" -ForegroundColor White
    Write-Host "  │   [Q] EXIT                                               │" -ForegroundColor White
    Write-Host "  │                                                         │" -ForegroundColor White
    Write-Host "  └─────────────────────────────────────────────────────────┘" -ForegroundColor White

    Write-Host ""
    Write-Host "  Select: " -ForegroundColor White -NoNewline

    return (Read-Host)
}

# ------------------------------------------------------------
# APPLICATIONS
# ------------------------------------------------------------

function Install-CursedApp {
    param(
        [string]$Id,
        [string]$Name
    )

    Write-Host ""
    Write-Host "  Installing $Name..." -ForegroundColor White

    try {
        winget install `
            --id $Id `
            --exact `
            --accept-source-agreements `
            --accept-package-agreements

        Write-Host ""
        Write-Host "  [+] $Name installation finished." -ForegroundColor White
    }
    catch {
        Write-Host ""
        Write-Host "  [-] Installation failed." -ForegroundColor White
    }

    Pause-Cursed
}

function Show-Applications {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "APPLICATION DEPLOYMENT" -Lines @(
            "[1] Firefox"
            "[2] 7-Zip"
            "[3] VLC"
            "[4] Discord"
            "[5] Steam"
            "[6] VS Code"
            "[7] Git"
            "[8] Everything Search"
            "[9] PowerToys"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" { Install-CursedApp "Mozilla.Firefox" "Firefox" }
            "2" { Install-CursedApp "7zip.7zip" "7-Zip" }
            "3" { Install-CursedApp "VideoLAN.VLC" "VLC" }
            "4" { Install-CursedApp "Discord.Discord" "Discord" }
            "5" { Install-CursedApp "Valve.Steam" "Steam" }
            "6" { Install-CursedApp "Microsoft.VisualStudioCode" "VS Code" }
            "7" { Install-CursedApp "Git.Git" "Git" }
            "8" { Install-CursedApp "voidtools.Everything" "Everything" }
            "9" { Install-CursedApp "Microsoft.PowerToys" "PowerToys" }

            "B" { return }
        }
    }
}

# ------------------------------------------------------------
# TWEAKS
# ------------------------------------------------------------

function Set-CursedDarkMode {

    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

    New-ItemProperty `
        -Path $path `
        -Name "AppsUseLightTheme" `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null

    New-ItemProperty `
        -Path $path `
        -Name "SystemUsesLightTheme" `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null

    Write-Host "  [+] Dark mode enabled." -ForegroundColor White
    Pause-Cursed
}

function Set-CursedExplorerExtensions {

    New-ItemProperty `
        -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
        -Name "HideFileExt" `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null

    Write-Host "  [+] File extensions are now visible." -ForegroundColor White
    Pause-Cursed
}

function Set-CursedUltimatePerformance {

    if (-not (Require-Admin)) {
        return
    }

    powercfg `
        -duplicatescheme `
        e9a42b02-d5df-448d-aa00-03f14749eb61

    Write-Host ""
    Write-Host "  [+] Ultimate Performance power plan created." -ForegroundColor White

    Pause-Cursed
}

function Set-CursedVisualEffects {

    New-ItemProperty `
        -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" `
        -Name "VisualFXSetting" `
        -PropertyType DWord `
        -Value 2 `
        -Force | Out-Null

    Write-Host "  [+] Visual effects adjusted." -ForegroundColor White

    Pause-Cursed
}

function Show-Tweaks {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "SYSTEM TWEAKS" -Lines @(
            "[1] Enable Windows Dark Mode"
            "[2] Show File Extensions"
            "[3] Create Ultimate Performance Plan"
            "[4] Reduce Visual Effects"
            "[5] Restart Explorer"
            "[6] Flush DNS"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {
                Set-CursedDarkMode
            }

            "2" {
                Set-CursedExplorerExtensions
            }

            "3" {
                Set-CursedUltimatePerformance
            }

            "4" {
                Set-CursedVisualEffects
            }

            "5" {
                Stop-Process -Name explorer -Force
                Start-Process explorer.exe

                Write-Host "  [+] Explorer restarted." -ForegroundColor White
                Pause-Cursed
            }

            "6" {
                ipconfig /flushdns

                Write-Host "  [+] DNS cache flushed." -ForegroundColor White
                Pause-Cursed
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# CLEANUP
# ------------------------------------------------------------

function Clear-CursedTemp {

    Write-Host ""
    Write-Host "  Cleaning temporary files..." -ForegroundColor White

    $locations = @(
        "$env:TEMP\*"
        "$env:LOCALAPPDATA\Temp\*"
        "$env:WINDIR\Temp\*"
    )

    foreach ($location in $locations) {

        Remove-Item `
            $location `
            -Recurse `
            -Force `
            -ErrorAction SilentlyContinue
    }

    Write-Host "  [+] Temporary files cleaned." -ForegroundColor White

    Pause-Cursed
}

function Clear-CursedWindowsUpdate {

    if (-not (Require-Admin)) {
        return
    }

    Write-Host ""
    Write-Host "  Resetting Windows Update cache..." -ForegroundColor White

    Stop-Service wuauserv -Force
    Stop-Service bits -Force

    Remove-Item `
        "$env:WINDIR\SoftwareDistribution\Download\*" `
        -Recurse `
        -Force `
        -ErrorAction SilentlyContinue

    Start-Service bits
    Start-Service wuauserv

    Write-Host "  [+] Windows Update cache reset." -ForegroundColor White

    Pause-Cursed
}

function Show-Cleanup {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "CLEANUP ENGINE" -Lines @(
            "[1] Clean Temporary Files"
            "[2] Reset Windows Update Cache"
            "[3] Empty Recycle Bin"
            "[4] Run Disk Cleanup"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {
                Clear-CursedTemp
            }

            "2" {
                Clear-CursedWindowsUpdate
            }

            "3" {
                Clear-RecycleBin `
                    -Force `
                    -ErrorAction SilentlyContinue

                Write-Host "  [+] Recycle Bin emptied." -ForegroundColor White
                Pause-Cursed
            }

            "4" {
                Start-Process cleanmgr.exe `
                    -ArgumentList "/sagerun:1"

                Pause-Cursed
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# WINDOWS
# ------------------------------------------------------------

function Show-Windows {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "WINDOWS CONTROL" -Lines @(
            "[1] Windows Update"
            "[2] Activation Status"
            "[3] Windows Version"
            "[4] Installed Updates"
            "[5] Optional Features"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {
                Start-Process "ms-settings:windowsupdate"
                Pause-Cursed
            }

            "2" {
                cscript.exe `
                    "$env:SystemRoot\System32\slmgr.vbs" `
                    /xpr

                Pause-Cursed
            }

            "3" {
                Get-ComputerInfo |
                    Select-Object `
                        WindowsProductName,
                        WindowsVersion,
                        OsBuildNumber |
                    Format-List

                Pause-Cursed
            }

            "4" {
                Get-HotFix |
                    Sort-Object InstalledOn -Descending |
                    Select-Object -First 20 |
                    Format-Table -AutoSize

                Pause-Cursed
            }

            "5" {
                Get-WindowsOptionalFeature -Online |
                    Where-Object State -eq "Enabled" |
                    Select-Object FeatureName, State |
                    Format-Table -AutoSize

                Pause-Cursed
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# NETWORK
# ------------------------------------------------------------

function Show-Network {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "NETWORK LAB" -Lines @(
            "[1] IP Configuration"
            "[2] DNS Cache"
            "[3] Flush DNS"
            "[4] Ping Cloudflare"
            "[5] Trace Route"
            "[6] Network Adapters"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {
                ipconfig /all
                Pause-Cursed
            }

            "2" {
                ipconfig /displaydns
                Pause-Cursed
            }

            "3" {
                ipconfig /flushdns

                Write-Host "  [+] DNS cache flushed." -ForegroundColor White
                Pause-Cursed
            }

            "4" {
                Test-Connection 1.1.1.1 -Count 4
                Pause-Cursed
            }

            "5" {
                tracert 1.1.1.1
                Pause-Cursed
            }

            "6" {
                Get-NetAdapter |
                    Format-Table `
                        Name,
                        InterfaceDescription,
                        Status,
                        LinkSpeed `
                        -AutoSize

                Pause-Cursed
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# REPAIR
# ------------------------------------------------------------

function Invoke-CursedRepair {

    if (-not (Require-Admin)) {
        return
    }

    Write-Host ""
    Write-Host "  Starting System File Checker..." -ForegroundColor White
    Write-Host ""

    sfc /scannow

    Pause-Cursed
}

function Invoke-CursedDISM {

    if (-not (Require-Admin)) {
        return
    }

    Write-Host ""
    Write-Host "  Starting DISM component repair..." -ForegroundColor White
    Write-Host ""

    DISM /Online /Cleanup-Image /RestoreHealth

    Pause-Cursed
}

function Reset-CursedNetwork {

    if (-not (Require-Admin)) {
        return
    }

    Write-Host ""
    Write-Host "  Resetting network stack..." -ForegroundColor White

    netsh winsock reset
    netsh int ip reset

    Write-Host ""
    Write-Host "  [+] Network stack reset." -ForegroundColor White
    Write-Host "  [!] A reboot may be required." -ForegroundColor DarkGray

    Pause-Cursed
}

function Show-Repair {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "REPAIR CORE" -Lines @(
            "[1] System File Checker (SFC)"
            "[2] DISM Image Repair"
            "[3] Reset Network Stack"
            "[4] Check Disk"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {
                Invoke-CursedRepair
            }

            "2" {
                Invoke-CursedDISM
            }

            "3" {
                Reset-CursedNetwork
            }

            "4" {
                Write-Host ""
                Write-Host "  Running CHKDSK scan..." -ForegroundColor White

                chkdsk C: /scan

                Pause-Cursed
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# TOOLS
# ------------------------------------------------------------

function Show-Tools {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "CURSED TOOLBOX" -Lines @(
            "[1] Task Manager"
            "[2] Device Manager"
            "[3] Services"
            "[4] Event Viewer"
            "[5] Registry Editor"
            "[6] System Information"
            "[7] PowerShell"
            "[8] Command Prompt"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {
                Start-Process taskmgr.exe
            }

            "2" {
                Start-Process devmgmt.msc
            }

            "3" {
                Start-Process services.msc
            }

            "4" {
                Start-Process eventvwr.msc
            }

            "5" {
                Start-Process regedit.exe
            }

            "6" {

                Get-ComputerInfo |
                    Select-Object `
                        CsName,
                        WindowsProductName,
                        WindowsVersion,
                        OsBuildNumber,
                        CsManufacturer,
                        CsModel,
                        CsProcessors |
                    Format-List

                Pause-Cursed
            }

            "7" {
                Start-Process powershell.exe
            }

            "8" {
                Start-Process cmd.exe
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# SOCIALS
# ------------------------------------------------------------

function Show-Socials {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "CURSED SOCIALS" -Lines @(
            "[1] TikTok"
            "[2] Open All Socials"
            ""
            "TikTok    : @cursedelrey"
            ""
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {

                Write-Host ""
                Write-Host "  Opening TikTok..." -ForegroundColor White

                Start-Process `
                    "https://www.tiktok.com/@cursedelrey"

                Start-Sleep -Milliseconds 700
            }

            "2" {

                Write-Host ""
                Write-Host "  Opening TikTok..." -ForegroundColor White

                Start-Process `
                    "https://www.tiktok.com/@cursedelrey"

                Start-Sleep -Milliseconds 700
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# SETTINGS
# ------------------------------------------------------------

function Show-Settings {

    while ($true) {

        Show-CursedHeader

        Write-Panel -Title "CURSED SETTINGS" -Lines @(
            "Theme      : BLACK / WHITE"
            "Accent     : WHITE"
            "Background : VOID BLACK"
            "Version    : 1.0.0"
            ""
            "[1] Restart as Administrator"
            "[2] Open Cursed folder"
            "[3] About"
            "[B] Back"
        )

        $choice = Read-Host "  Select"

        switch ($choice.ToUpper()) {

            "1" {

                if (-not (Test-CursedAdmin)) {

                    Start-Process powershell.exe `
                        -Verb RunAs `
                        -ArgumentList `
                        "-ExecutionPolicy Bypass -File `"$PSCommandPath`""

                    exit
                }

                Write-Host "  [+] Already running as Administrator." -ForegroundColor White
                Pause-Cursed
            }

            "2" {

                Start-Process explorer.exe `
                    -ArgumentList "/select,`"$PSCommandPath`""
            }

            "3" {

                Write-Panel `
                    -Title "ABOUT CURSED UTIL" `
                    -Lines @(
                        "CursedUtil 1.0.0"
                        ""
                        "A custom PowerShell Windows utility."
                        "Black / white terminal interface."
                        ""
                        "KeyAuth authentication enabled."
                        ""
                        "Use system-changing features carefully."
                    )

                Pause-Cursed
            }

            "B" {
                return
            }
        }
    }
}

# ------------------------------------------------------------
# START AUTHENTICATION
# ------------------------------------------------------------

if (-not (Start-CursedAuth)) {
    Clear-Cursed
    exit
}

# ------------------------------------------------------------
# MAIN LOOP
# ------------------------------------------------------------

while ($true) {

    $choice = Show-Home

    switch ($choice.ToUpper()) {

        "1" {
            Show-Applications
        }

        "2" {
            Show-Tweaks
        }

        "3" {
            Show-Cleanup
        }

        "4" {
            Show-Windows
        }

        "5" {
            Show-Network
        }

        "6" {
            Show-Repair
        }

        "7" {
            Show-Tools
        }

        "8" {
            Show-Settings
        }

        "9" {
            Show-Socials
        }

        "Q" {

            Clear-Cursed

            Write-Host ""
            Write-Host "  CURSED UTIL SHUTTING DOWN..." -ForegroundColor White
            Write-Host ""

            Start-Sleep -Milliseconds 700
            exit
        }

        default {

            Write-Host ""
            Write-Host "  [!] Invalid selection." -ForegroundColor White

            Start-Sleep -Milliseconds 700
        }
    }
}
