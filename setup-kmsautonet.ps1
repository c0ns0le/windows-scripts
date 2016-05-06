iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-chocolatey.ps1'))
choco install -f -y KMSAutoNet2015 -source https://www.myget.org/F/rkan15/auth/1ef99fe0-2b5c-46b1-8265-30605d4139b6/api/v2
$chocoInstall = Get-Content Env:ChocolateyInstall 
$execPath = "$chocoInstall\lib\kmsautonet2015\tools\rkan15142np\KMSAuto Net.exe"
Write-Host "Starting KMSAutoNet 2015: $execPath ..."
& "$execPath" /win=act /task=yes /taskrun=yes /sound=yes
Write-Host "Sleeping for 30 seconds until KMS Auto finishes ..."
Start-Sleep -s 30
