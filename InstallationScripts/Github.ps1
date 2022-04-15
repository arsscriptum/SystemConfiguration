# MY DOCUMENTS
New-Item -Path 'c:\DOCUMENTS' -ItemType Directory -Force -ErrorAction Ignore | Out-Null
New-Item -Path 'c:\Data\Pictures\Screenshots' -ItemType Directory -Force -ErrorAction Ignore | Out-Null
New-Item -Path 'c:\Data\Downloads' -ItemType Directory -Force -ErrorAction Ignore | Out-Null
New-Item -Path 'c:\Data\Windows\Desktop' -ItemType Directory -Force -ErrorAction Ignore | Out-Null

# POWERSHELL PROFILE
New-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' Personal -Value 'c:\DOCUMENTS' -Type ExpandString -Force | Out-Null

Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' Desktop -Value 'c:\Data\Windows\Desktop' -Type ExpandString -Force | Out-Null
Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' 'My Pictures' -Value 'c:\Data\Pictures' -Type ExpandString -Force | Out-Null
Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' 'My Video' -Value 'c:\Data\Videos' -Type ExpandString -Force | Out-Null


# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

#################################################################################
## Set-Service
Set-Service -Name "ssh-agent" -StartupType Automatic
Start-Service -Name "ssh-agent"


#################################################################################
## ALWAYS YES
choco feature enable -n allowGlobalConfirmation

#################################################################################
## INSTALL PASTEBOARD
choco install pasteboard

#################################################################################
## ssh-keygen
ssh-keygen -t rsa -b 4096 -C "cybercastor@icloud.com" -g -f "C:\Users\radic\.ssh\id_cybercastor"
ssh-keygen -t rsa -b 4096 -C "radicaltronic@gmail.com" -g -f "C:\Users\radic\.ssh\id_radicaltronic"
ssh-keygen -t rsa -b 4096 -C "zolaternative@icloud.com" -g -f "C:\Users\radic\.ssh\id_anonymous"
ssh-keygen -t rsa -b 4096 -C "guillaumeplante.qc@gmail.com" -g -f "C:\Users\radic\.ssh\id_arsscriptum"

$Username = 
# CONFIGURE GITHUB ACCOUNT: cybercastor
# type "C:\Users\$ENV:USERNAME\.ssh\id_cybercastor.pub" | pbcopy.exe  
# CONFIGURE GITHUB ACCOUNT: radicaltronic
# type "C:\Users\$ENV:USERNAME\.ssh\id_radicaltronic.pub" | pbcopy.exe  
# CONFIGURE GITHUB ACCOUNT: vcvzsds7868745 
# type "C:\Users\$ENV:USERNAME\.ssh\id_anonymous.pub" | pbcopy.exe   
# CONFIGURE GITHUB ACCOUNT: vcvzsds7868745 
# type "C:\Users\$ENV:USERNAME\.ssh\id_arsscriptum.pub" | pbcopy.exe  


