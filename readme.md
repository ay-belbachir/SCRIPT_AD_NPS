
# <p align="center">  (｡◕‿‿◕｡) ```Ayoub-Belbachir``` <img src="https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/4e803fb5-d22d-4b01-8f5e-054041544a26/d2yw9ll-6b1e490c-c880-44bb-ba3b-7c77d34899b7.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzRlODAzZmI1LWQyMmQtNGIwMS04ZjVlLTA1NDA0MTU0NGEyNlwvZDJ5dzlsbC02YjFlNDkwYy1jODgwLTQ0YmItYmEzYi03Yzc3ZDM0ODk5YjcucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.UYJQmnU7Vy-zPUhySWX1TDCBjNJl-sPxVqfUw-j7Uq0" alt="alt text" width="90" height="whatever"> </p>


  [//]: # (<img src="https://user-images.githubusercontent.com/45585937/52410651-fa95b900-2b13-11e9-970e-eff9afd83b23.png" alt="alt text" width="400" height="whatever">)
## Information

Script PowerShell permettant d’automatiser plusieurs paramètres comme; attribuer une adresse IP statique, attribué un Hostname, créé un AD et une forêt, installer un DNS, création de OUs, création d’utilisateur à partir d’un fichier .CSV qui doivent être déplacé dans les OUs selon leurs ID présent dans le fichier CSV et instalation

Le dossier ```SCRIPT_AYOUB_BELBACHIR``` doit être déposés dans le répertoire suivant ```C:\Windows\```. Pour une meilleure expérience d’immersion je vous conseille aussi activer le son.</br>
internet et conseiller pour le script 2 ou j'installe un gestionnaire de paquets pour Windows ```CHOCO``` et un module complementaire telle que [BurntToast](https://github.com/Windos/BurntToast) pour afficher des notification popup afin perssonaliser 

## Les etapes à suivre 


  :white_check_mark: Avoir internet

  :white_check_mark: Télécharger mon repository

  :white_check_mark: placer le dossier ```SCRIPT_AYOUB_BELBACHIR``` dans le chemin suivant:``` C:\Windows\```

  :white_check_mark: Lancer le script ```Menu.ps1``` contenue dans ```C:\Windows\SCRIPT_AYOUB_BELBACHIR.menu.ps1```

:white_check_mark: Vous n'avez plus qu'à suivre les étapes



  **<details><summary>↓⬇️ SPOILEUR MENU ⬇️↓</summary>**
<img src="./spoilermenu.gif" width="whatever" height="whatever" /></details>

# Une partie des script

  **<details><summary>↓⬇️ DEVELLOPEZ MOI ⬇️↓</summary>**

## Une partie du script 1
```
#Adresse ip en static
$ip = "192.168.2.2"
$prefix = "24"
$GW = "192.168.2.1"
$DNS = "8.8.8.8"

$adapter = (Get-NetAdapter).ifIndex
New-NetIPAddress -IPAddress $ip -PrefixLength $prefix `
-InterfaceIndex $adapter -DefaultGateway $GW
Set-DNSClientServerAddress –InterfaceIndex (Get-NetAdapter).InterfaceIndex –ServerAddresses $DNS

#le script demande a l'utilisateur de saisire un nom pour l'ordinateur si 'non' le pc est est nomer par default il verifie aussi si le nom par defaut ou le nom saisie est deja utiliser
$myhost = [System.Net.Dns]::GetHostName()
$demande = Read-Host -Prompt 'saisir saisiser le nom du pc ? o/n n=nom par defaut AyoubAD'

$defauthostn = 'AyoubAD'
```


## Le script 2
```
#mon mots de passe de la forêt
$monmdpad = ConvertTo-SecureString -String "Btssio92" -AsPlainText -Force
    #bypass securiter pour instalation du gestionaire paquets choco et pour burn toast module qui permet la perssonalisation des notifs
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
```
	
	
	
	
## Une partie du script 3

```
$parentOU = 'OU=Departement Quantique,DC=AYOUB,DC=local'
$dptq = 'Departement Quantique'
$itnom = 'IT'
$spnom = 'SUPPORT'
$IT       = 'OU=IT,OU=Departement Quantique,DC=AYOUB,DC=local'
$SUPPORT = 'OU=SUPPORT,OU=Departement Quantique,DC=AYOUB,DC=local'
$grp= 'portail captif'

Write-Host -ForegroundColor Green "Vérifions si les Unités d'organisation et le groupe $grp existe si non créons les"
                    
#Vérifions si le groupe pour le portail catif existe existe si non créons le

        if(Get-ADGroup -filter {Name -eq $grp} -ErrorAction Continue)
            {
                Write-Host  -ForegroundColor GREEN "le groupe $grp existe "            
            }
 else 
    {
        Write-Host  -ForegroundColor CYAN "$grp n'existe pas, ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADGroup -Name $grp -GroupScope Global -Path "CN=Users,DC=AYOUB,DC=local"
    }
   
   # Vérifions si les Unités d'organisation existe si non créons les    
       
if([ADSI]::Exists("LDAP://$parentOU")) {            
        Write-Host  -ForegroundColor GREEN "$dptq existe"            
                                            }
```


## Une partie du script 4 

``` 
# Boucle foreach contenant le csv et son contenu
       foreach ($User in $ecchi)
       {
              $Username    = $User.Username
              $Password    = $User.password
              $Prenom      = $User.Prenom 
              $ID          = $User.ID
              $Nom         = $User.Nom
              $Chemin      = $User.Chemin

# On vérifie si l'utilisateur n'existe pas déjà dans le domaine
       if ( Get-ADUser -F { SamAccountName -eq $Username }) {

           # On affiche un message 
          Write-Host -ForegroundColor Green "OHOHO! $Username est deja présent dans l'AD"
                                                               }
# instructions quelque soit les choix possibles creation des utilisateur
              else {

                     New-ADUser -SamAccountName $Username -UserPrincipalName "$Username@AYOUB.local" -Name "$Prenom $Nom" -GivenName $Prenom -Surname $Nom -Enabled $True -DisplayName "$Nom, $Prenom" -Path $Chemin -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
                     Write-Host -ForegroundColor Green "$Username il a été créé"
                     }
		   
#la variable  $Usercsv recupere les SamAccountName directement sous format cn=U$sername,ou="spesifier",dc="AYOUB",dc=local sans ça on obtient une erreur lors du déplacement de l'objet $Username vers un Ou
```


```
		                       __       __  ________  _______    ______   ______ 
		                      |  \     /  \|        \|       \  /      \ |      \
		                      | $$\   /  $$| $$$$$$$$| $$$$$$$\|  $$$$$$\ \$$$$$$
		                      | $$$\ /  $$$| $$__    | $$__| $$| $$   \$$  | $$  
		                      | $$$$\  $$$$| $$  \   | $$    $$| $$        | $$  
		                      | $$\$$ $$ $$| $$$$$   | $$$$$$$\| $$   __   | $$  
		                      | $$ \$$$| $$| $$_____ | $$  | $$| $$__/  \ _| $$_ 
		                      | $$  \$ | $$| $$     \| $$  | $$ \$$    $$|   $$ \
		                       \$$      \$$ \$$$$$$$$ \$$   \$$  \$$$$$$  \$$$$$$
		                                                   
```



</details>
