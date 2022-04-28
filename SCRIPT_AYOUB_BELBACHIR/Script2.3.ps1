#mon mots de passe de la forêt
$monmdpad = ConvertTo-SecureString -String "Btssio92" -AsPlainText -Force
        #bypass sécurité pour installation du module choco et pour BurnToast module qui permet la personnalisation des notifs
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    #instalation du module BurnToast pour perssonaliser les notif 
choco install BurntToast-psmodule -y
    #instalation de l'AD, de la foret , et du dns
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools 
Install-WindowsFeature DNS -IncludeManagementTools
Install-ADDSForest  `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode 7 `
    -ForestMode 7 `
    -DomainName "AYOUB.local" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword $monmdpad `
    -NoRebootOnCompletion:$true `
    -SysvolPath "C:\Windows\SYSVOL" `
    -LogPath "C:\Windows\NTDS" `
    -Force:$true

#instalation du server network policy server pour auth RADIUS 
    Install-WindowsFeature NPAS -IncludeManagementTools
#notif et redemarage 
    New-BurntToastNotification -Text "redemarage", "l'ordinateur redemarre tout seul dans 40s" -AppLogo C:\Windows\SCRIPT_AYOUB_BELBACHIR\tmp.png
Start-Sleep -s 40
 Restart-Computer -Force
