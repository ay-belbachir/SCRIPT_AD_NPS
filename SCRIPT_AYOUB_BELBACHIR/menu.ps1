#!!!!!!!!!!!!! pour que le script s'execute à la perfection veuillez respecter les chemins tout les script et le media dans "C:\Windows\SCRIPT_AYOUB_BELBACHIR\"
$ayoubascii = @"
                            █████╗ ██╗   ██╗ ██████╗ ██╗   ██╗██████╗ 
                           ██╔══██╗╚██╗ ██╔╝██╔═══██╗██║   ██║██╔══██╗
                           ███████║ ╚████╔╝ ██║   ██║██║   ██║██████╔╝
                           ██╔══██║  ╚██╔╝  ██║   ██║██║   ██║██╔══██╗
                           ██║  ██║   ██║   ╚██████╔╝╚██████╔╝██████╔╝
                           ╚═╝  ╚═╝   ╚═╝    ╚═════╝  ╚═════╝ ╚═════╝                                          
"@


Write-Host $ayoubascii -ForegroundColor Cyan
$menu = @"
      ╔═════════════════════TP AYOUB BELBACHIR═════════════════════════════════════╗
      ║  1. Mettre l'adresse IP en statique et modifier le nom de la machine       ║
      ║  2. Création de l'AD du DNS et de la forêt                                 ║ 
      ║  3. Création Des OUs                                                       ║ 
      ║  4. Création des utilisateurs et déplacements de de ceux-là selon leurs ID ║
      ║  0. Je Quitter                                                             ║
      ╚═════════════════════MENU BY AYOUB══════════════════════════════════════════╝
"@
$PlayWav=New-Object System.Media.SoundPlayer
$PlayWav.SoundLocation= 'C:\Windows\SCRIPT_AYOUB_BELBACHIR\ecchi.wav'
$menups1 = 'C:\Windows\SCRIPT_AYOUB_BELBACHIR\menu.ps1'
Write-Host $menu -ForegroundColor Yellow
$choix = Read-Host "Veuillez choisir une option..."


switch ($choix) {
   1{
       Write-Host "Mettre l'adresse IP en statique et modifier le nom de la machine"  
      $PlayWav.playsync()
        C:\Windows\SCRIPT_AYOUB_BELBACHIR\Script1.ps1 
      Read-Host -Prompt "Appuyer sur une touche une fois la lecture terminée"
      clear
       PowerShell -NoExit $menups1 
         }
   2{
	 Write-Host "mise en route du scripte creation de l'ad"
    $PlayWav.playsync()
      	C:\Windows\SCRIPT_AYOUB_BELBACHIR\Script2.3.ps1
         Read-Host -Prompt "Appuyer sur une touche une fois la lecture terminée"
         clear
          PowerShell -NoExit $menups1
         }
   3{
    Write-Host "Création Des OUs"
     $PlayWav.playsync()
	   C:\Windows\SCRIPT_AYOUB_BELBACHIR\Script3.ps1
      Read-Host -Prompt "Appuyer sur une touche une fois la lecture terminée"
      Clear
       PowerShell -NoExit $menups1
            }
 4{
   Write-Host "Création des utilisateurs et déplacements de de ceux-là selon leurs ID"
   $PlayWav.playsync()
	C:\Windows\SCRIPT_AYOUB_BELBACHIR\Script4.ps1
   https://gitlab.com/digi-boy1/SCRIPT/-/blob/d81b025c208c6202334182aee7dafe8744ee3a50/readme.md
      Clear
      PowerShell -NoExit $menups1
            } 

    0{
       $PlayWav.playsync()
      Stop-Process -Name PowerShell
            }


   default{ Write-Host -ForegroundColor RED "$choix ne correspond pas au choix possible"
      Read-Host -Prompt "appuyez sur n'importe qu'elle touche pour réessayer "
      Clear
      PowerShell -NoExit $menups1
                }

}
