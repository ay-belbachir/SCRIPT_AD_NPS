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
$demande = Read-Host -Prompt ''saisissez le nom du pc ? o/n n=nom par defaut AyoubAD'

$defauthostn = 'AyoubAD'

switch($demande){
 o {  
        $newhostnm = Read-Host -Prompt 'saisir un Nom d'hôte pour votre machine '
          if ($myhost -eq $newhostnm) {
              Write-Host -ForegroundColor Yellow " $newhostnm est déjà le nom de la machine "            
                                            }
          else {            
             Write-Host  -ForegroundColor Green " le nom de la machin sera $newhostnm apres redémarrage"   
                rename-computer -NewName $newhostnm -Force
                 Write-Host -ForegroundColor Yellow " l'ordinateur redemarre tout seul dans 15s"
                 Start-Sleep -s 15 
                    Restart-Computer -Force
                         }
    }
 n{
          if ($myhost -eq $defauthostn) {
                Write-Host -ForegroundColor Yellow " $defauthostn est déjà le nom de la machine " 
                 }

        if  ($myhost -ne $defauthostn ) {
                Write-Host  -ForegroundColor Green " le nom de la machin sera $defauthostn apres redémarrage"   
                rename-computer -NewName $defauthostn -Force
                Write-Host -ForegroundColor Yellow " l'ordinateur redemarre tout seul dans 30s"
                Start-Sleep -s 30
                Restart-Computer -Force
                                                }
}
   #pour les saisie invalide
    default{write-warning "Saisie invalide" 
                 }
}

