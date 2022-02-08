


### OpenSSH Client / Server - Windows Component Installation
### From: https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse




function Install-OpenSSH {
	# Install the OpenSSH Client
	Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

	# Install the OpenSSH Server
	Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

	# OPTIONAL but recommended:
	Set-Service -Name sshd -StartupType 'Automatic'

	# Start the sshd service
	Start-Service sshd
}

function Uninstall-OpenSSH {
	# Uninstall the OpenSSH Client
	Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

	# Uninstall the OpenSSH Server
	Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
}

function Config-Firewall-SSH{
	# Confirm the firewall rule is configured. It should be created automatically by setup.
	Get-NetFirewallRule -Name *ssh*

	# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
	# If the firewall does not exist, create one
	New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}


Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
Install-OpenSSH
Config-Firewall-SSH