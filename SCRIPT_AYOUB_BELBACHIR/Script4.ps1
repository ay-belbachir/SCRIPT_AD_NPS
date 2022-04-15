
# On importe le module Active Directory
Import-Module ActiveDirectory

# On utilise le module Import-csv sur notre calc pour en faire une variable
$ecchi = Import-csv -Delimiter ";" -Path C:\Windows\SCRIPT_AYOUB_BELBACHIR\yohoho.csv
$OUIT = 'OU=IT,OU=FILLIALE,DC=AYOUB,DC=local'
$SUPPORT = 'OU=SUPPORT,OU=FILLIALE,DC=AYOUB,DC=local'

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
		   

		   #pour RADIUS   
Install-WindowsFeature NPAS -IncludeManagementTools

#scripte 4 le trie et la creation de du group pour le portail captif
New-ADGroup -Name "portalcaptif" -GroupScope Global -Path "CN=Users,DC=AYOUB,DC=local"
 $Usercsv  = (Get-ADUser $Username).distinguishedName
#la variable recuperer les SamAccountName directement sous format cn=Username,ou=informatique,dc=it-connect,dc=local sans ça on obtient une erreur lors du déplacement de l'objet $Username vers un Ou

If ( $ID -le 500 )  {
        Move-ADObject -Identity  $Usercsv   -TargetPath $OUIT
	Add-ADGroupMember -Identity portalcaptif -Members $Username
              }
		 If ( $ID -ge 501 ) {
	Move-ADObject -Identity  $Usercsv  -TargetPath $SUPPORT

                                   }

}
#noyif
New-BurntToastNotification -Text "Script 3 ", "execution du script 3 terminer" -AppLogo C:\Windows\SCRIPT_AYOUB_BELBACHIR\tmp.png








   
