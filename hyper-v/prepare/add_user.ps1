if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }
Set-ExecutionPolicy bypass -force

New-LocalUser -Name smb -Password (ConvertTo-SecureString "LABtest01!" -AsPlainText -Force) -PasswordNeverExpires
Add-LocalGroupMember -Group Users -Member smb
Add-LocalGroupMember -Group Administrators -Member smb

