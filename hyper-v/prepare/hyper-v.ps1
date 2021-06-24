if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

## Lab Service Setup  
Set-ExecutionPolicy bypass -force
cd c:\
git clone https://github.com/Azure/azure-devtestlab.git
.\azure-devtestlab\samples\ClassroomLabs\Scripts\HyperV\SetupForNestedVirtualization.ps1  

Pause
