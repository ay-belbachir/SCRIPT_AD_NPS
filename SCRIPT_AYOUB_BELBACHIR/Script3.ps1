
$parentOU = 'OU=Departement Quantique,DC=AYOUB,DC=local'

$IT       = 'OU=IT,OU=Departement Quantique,DC=AYOUB,DC=local'
$SUPPORT = 'OU=SUPPORT,OU=Departement Quantique,DC=AYOUB,DC=local'
$grp= 'portail captif'

Write-Host -ForegroundColor Green "Vérifions si les Unités d'organisation et le groupe $grp existe si non créons les"
                    
#Vérifions si le grpoupe pour le portail catif existe existe si non créons le

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
        Write-Host  -ForegroundColor GREEN "Filliale existe"            
                                            }
else {            
        Write-Host  -ForegroundColor CYAN "FILLIAL n'existe pas, ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name FILLIALE -Path "DC=AYOUB,DC=local"
            }     
       
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
