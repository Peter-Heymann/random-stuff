# Windows-Terminal

![alt-text][logo]
[logo]: "Windows Terminal Git Powerline"
[Setup Powerline in Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup)

[Font, download zip](https://github.com/microsoft/cascadia-code/releases)

Open the Zip go into ttf and select CascadiaCodePL and CascadiaMonoPL and click install

```
Install-Module posh-git -Scope CurrentUser      : A
Install-Module oh-my-posh -Scope CurrentUser    : A
```
Check if there is a Powershell Profil
```
notepad $PROFILE
```
OR Go to C:\Users\YourUser\Documents\WindowsPowerShell and open Microsoft.PowerShell_profile.ps1

Copy this lines into the notepade from above
```
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Paradox
```
Open a New Powershell as an Admin
```
Set-ExecutionPolicy Unrestricted : A
```

settings.json
```
"profiles":
    {
        "defaults":
        {
            // Put settings here that you want to apply to all profiles.
        },
        "list":
        [
            {
                // Make changes here to the powershell.exe profile.
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "name": "Windows PowerShell",
                "commandline": "powershell.exe",
                "fontFace": "Cascadia Code PL",
                "hidden": false
            },
            {
                // Make changes here to the cmd.exe profile.
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "name": "Eingabeaufforderung",
                "commandline": "cmd.exe",
                "hidden": false
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": false,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure"
            }
        ]
    },
```