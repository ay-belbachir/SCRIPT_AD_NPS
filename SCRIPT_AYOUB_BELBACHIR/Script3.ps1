
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
else {            
        Write-Host  -ForegroundColor CYAN "$dptq n'existe pas, ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name $dptq -Path "DC=AYOUB,DC=local"
            }     
 
   if([ADSI]::Exists("LDAP://$IT")) {            
        Write-Host  -ForegroundColor GREEN "$itnom exists "            
                                        }
else {            
        Write-Host  -ForegroundColor CYAN "$itnom n'existe pas,Ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name $itnom -Path "OU=Departement Quantique,DC=AYOUB,DC=local"
        } 
    if([ADSI]::Exists("LDAP://$SUPPORT")) {            
        Write-Host  -ForegroundColor GREEN "$spnom existe "            
                                            }
else {            
        Write-Host  -ForegroundColor CYAN "$spnom n'existe pas, ne t'inquiète pas je m'occupe de les créer pour toi."   
        New-ADOrganizationalUnit -Name $spnom -Path "OU=Departement Quantique,DC=AYOUB,DC=local"
           
        }           
#notif
New-BurntToastNotification -Text "Script 3 ", "execution du script 3 terminer" -AppLogo C:\Windows\SCRIPT_AYOUB_BELBACHIR\tmp.png
