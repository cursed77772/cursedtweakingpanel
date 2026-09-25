CURSED UTIL

Cursed Util is a Windows maintenance, optimization, tweaking, repair, and utility console built with PowerShell 5.1.

The application provides a terminal-based dashboard for accessing Windows utilities, system information, cleanup tools, networking commands, repair functions, application deployment, system tweaks, gaming-oriented tweaks, and registry configuration.

Requirements

Windows 10 or Windows 11

PowerShell 5.1 or newer

Administrator privileges for certain system-level operations

Internet connection for Winget application installation and other online functionality

Winget for application deployment features

Dashboard

The main dashboard provides an overview of the current Windows system and access to the major Cursed Util modules.

System Status

The dashboard displays information including:

Computer name

Current Windows user

Windows edition

Windows build

CPU

GPU

Installed RAM

Detected SSDs

Detected HDDs

C: drive storage usage

Available storage

System uptime

Current privilege level

Main Modules

The dashboard provides access to:

Applications

Windows Tweaks

Cleanup

Windows

Network

Repair

Tools

Settings

Socials

Applications

The Application Deployment module uses Windows Winget to install commonly used applications.

Available applications include:

Firefox

7-Zip

VLC

Discord

Steam

Visual Studio Code

Git

Everything Search

Microsoft PowerToys

Each application is installed using its corresponding Winget package ID.

Windows Tweaks

The Windows Tweaks module provides configuration options for commonly adjusted Windows settings.

Dark Mode

Enables Windows dark mode for applications and the Windows interface.

File Extensions

Makes known file extensions visible in Windows Explorer.

Ultimate Performance

Creates the Windows Ultimate Performance power plan.

Administrator privileges are required.

Visual Effects

Changes the Windows visual-effects configuration to reduce graphical effects.

Explorer Restart

Restarts Windows Explorer.

DNS Flush

Flushes the local Windows DNS resolver cache.

Gaming Tweaks

The Gaming Tweaks module is designed for users who want quick access to gaming-related Windows configuration.

Potential configuration areas include:

Game Mode

Hardware-accelerated GPU scheduling

Xbox Game Bar configuration

Background gaming features

Fullscreen optimization settings

Game-related Windows services

Power-plan configuration

Mouse configuration

Keyboard responsiveness settings

Windows gaming-related registry values

Startup/background application management

Changes should be reviewed before applying them because Windows behavior varies between systems.

Registry Tweaks

The Registry Tweaks module provides a centralized interface for commonly used Windows registry configurations.

Available categories can include:

Explorer

Show file extensions

Configure hidden files

Explorer behavior

Context-menu configuration

Explorer restart functionality

Desktop

Desktop behavior

UI configuration

Windows visual settings

Performance

Visual-effects configuration

System responsiveness settings

Background behavior

Privacy

Windows telemetry-related settings

Activity-history configuration

Suggested-content settings

Windows UI

Dark mode

Interface behavior

Taskbar-related configuration

Start-menu-related configuration

Registry modifications should be used carefully. Incorrect registry changes can affect Windows functionality.

Cleanup Engine

The Cleanup module provides tools for removing unnecessary files and maintenance data.

Temporary Files

Cleans temporary files from locations such as:

User TEMP

Local AppData TEMP

Windows TEMP

Windows Update Cache

Resets the Windows Update download cache.

Administrator privileges are required.

Recycle Bin

Empties the Windows Recycle Bin.

Disk Cleanup

Launches Windows Disk Cleanup.

Windows Control

The Windows Control module provides shortcuts to common Windows management functions.

Windows Update

Opens Windows Update settings.

Activation Status

Displays the Windows activation status.

Windows Version

Displays Windows product, version, and build information.

Installed Updates

Displays recently installed Windows updates.

Optional Features

Displays enabled Windows optional features.

Network Lab

The Network Lab provides networking diagnostics and maintenance commands.

Available tools include:

IP Configuration

Displays complete IP configuration information.

DNS Cache

Displays the current DNS resolver cache.

Flush DNS

Clears the DNS resolver cache.

Ping Cloudflare

Tests connectivity to:

1.1.1.1

Trace Route

Runs a route trace to:

1.1.1.1

Network Adapters

Displays network adapters, status, descriptions, and link speeds.

Network Repair

Cursed Util includes network repair functionality.

Available operations include:

Winsock reset

TCP/IP reset

DNS cache flushing

Network diagnostics

Adapter information

Some network repairs require restarting Windows.

Repair Core

The Repair Core provides access to built-in Windows repair utilities.

System File Checker

Runs:

SFC /SCANNOW

Used to scan protected Windows system files.

DISM

Runs:

DISM /Online /Cleanup-Image /RestoreHealth

Used to repair the Windows component store.

Network Stack Reset

Runs Windows networking reset commands.

CHKDSK

Runs a scan of the C: drive using:

CHKDSK C: /SCAN

Administrator privileges may be required for some repair operations.

Cursed Toolbox

The Toolbox provides shortcuts to built-in Windows management applications.

Available tools include:

Task Manager

Device Manager

Services

Event Viewer

Registry Editor

System Information

PowerShell

Command Prompt

System Information

The utility can display detailed system information including:

Computer name

Windows product

Windows version

Windows build

Manufacturer

Computer model

Processor information

Memory

GPU information

Storage information

Uptime

Administrator status

Power Management

Cursed Util provides access to Windows power configuration.

Supported functionality includes:

Ultimate Performance power plan

Existing Windows power configuration

Power-related gaming configuration

Power-plan changes can affect system power consumption and temperatures.

Explorer Tools

Explorer-related functionality includes:

Restart Windows Explorer

Show file extensions

Modify Explorer settings

Open the Cursed Util directory

Access registry-based Explorer configuration

Maintenance Features

Cursed Util provides several general maintenance operations:

Temporary-file cleanup

Windows Update cache cleanup

Recycle Bin cleanup

Disk Cleanup

DNS cache flushing

Network stack reset

SFC repair

DISM repair

CHKDSK scanning

Explorer restart

Administrator Privileges

Some operations require an elevated PowerShell session.

Administrator access may be required for:

Ultimate Performance configuration

Windows Update cache reset

SFC

DISM

Network stack reset

Certain registry modifications

Certain Windows configuration changes

Cursed Util includes an administrator check and provides an option to restart itself with elevated privileges.

Settings

The Settings module provides configuration and information options.

Available options include:

Restart as Administrator

Open the Cursed Util directory

View application information

The settings panel also displays:

Theme

Accent color

Background

Application version

Interface

Cursed Util uses a terminal-based black-and-white interface.

The interface includes:

ASCII branding

Structured panels

System-status dashboard

Numbered menus

Maintenance status messages

Access/operation status indicators

Consistent Windows-console styling

The interface is designed to provide a centralized control panel without requiring multiple Windows configuration windows.

Safety

Cursed Util performs operations that can modify Windows configuration.

Before using system-changing features:

Create a Windows restore point when appropriate.

Keep important files backed up.

Review registry changes before applying them.

Do not disable Windows security features unless you understand the consequences.

Understand that some changes may require a restart.

Use administrator-only functionality carefully.

Cursed Util does not guarantee that every tweak will improve performance on every computer.

Hardware, Windows version, drivers, applications, and existing configuration can all affect the result of a tweak.

Version

Cursed Util 1.0.0

Platform:

Microsoft Windows

Shell:

Windows PowerShell 5.1+

License

Cursed Util is distributed under the license terms provided with the project.

Do not redistribute modified versions as official Cursed Util releases without authorization.

Third-party applications installed through Winget remain subject to their respective licenses and terms.

Trademark

CURSED UTIL™ and the CURSED name, branding, logos, and associated visual identity are trademarks of their respective owner.

This project and its branding are not affiliated with, sponsored by, or endorsed by Microsoft, Valve, Discord, Mozilla, VideoLAN, Git, 7-Zip, or any other third-party application referenced by Cursed Util.

Windows is a trademark of Microsoft Corporation.

All third-party product names and trademarks belong to their respective owners.

Disclaimer

Cursed Util is provided for legitimate Windows administration, maintenance, customization, and troubleshooting purposes.

The author is not responsible for:

Data loss

System instability

Incorrect registry modifications

Failed Windows updates

Hardware issues

Software incompatibilities

Loss of configuration

Problems resulting from improper use of system-level features

Use system modification features at your own discretion.

Cursed Util

CURSED UTIL™

Windows Maintenance / Tweaking / Repair Console

Version 1.0.0
