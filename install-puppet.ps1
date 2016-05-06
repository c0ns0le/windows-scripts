#iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-chocolatey.ps1'))
choco install git
choco install puppet
