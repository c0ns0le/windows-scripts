iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable --name allowGlobalConfirmation # stop the -y flag being needed for all "choco install"s
choco install -f vim
choco install -f git 
choco install -f clink
choco install -f conemu
choco install -f notepadplusplus 
choco install -f clover
