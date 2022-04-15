
$parentOU = 'OU=Departement_Quantique,DC=AYOUB,DC=local'

$IT       = 'OU=IT,OU=Departement_Quantique,DC=AYOUB,DC=local'
$SUPPORT = 'OU=SUPPORT,OU=Departement_Quantique,DC=AYOUB,DC=local'

Write-Host -ForegroundColor Green "Vérifions si les Unités d'organisation existe"

                    # Vérifions si les Unités d'organisation existe si non créons 
         
if([ADSI]::Exists("LDAP://$parentOU")) {            
        Write-Host  -ForegroundColor GREEN "Departement Quantique existe"            
                                            }
else {            
        Write-Host  -ForegroundColor CYAN "Departement Quantique n'existe pas, ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name Departement_Quantique -Path "DC=AYOUB,DC=local"
            }     
 
   if([ADSI]::Exists("LDAP://$IT")) {            
        Write-Host  -ForegroundColor GREEN "IT exists "            
                                        }
else {            
        Write-Host  -ForegroundColor CYAN "IT n'existe pas,Ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name IT -Path "OU=Departement_Quantique,DC=AYOUB,DC=local"
        } 
    if([ADSI]::Exists("LDAP://$SUPPORT")) {            
        Write-Host  -ForegroundColor GREEN "SUPPORT existe "            
                                            }
else {            
        Write-Host  -ForegroundColor CYAN "SUPPORT n'existe pas, ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name SUPPORT -Path "OU=Departement_Quantique,DC=AYOUB,DC=local"
           
        }           
#notif
New-BurntToastNotification -Text "Script 3 ", "execution du script 3 terminer" -AppLogo C:\Windows\SCRIPT_AYOUB_BELBACHIR\tmp.png
