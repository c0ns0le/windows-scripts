iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable --name allowGlobalConfirmation # stop the -y flag being needed for all "choco install"s

choco install -f cygwin
choco install -f cyg-get

remove-item -recurse -force cygwin_common
puppet module install puppetlabs-stdlib
puppet module install puppetlabs-powershell 
puppet module install chocolatey-chocolatey
git clone https://github.com/st01tkh/puppet-cygwin_common cygwin_common
cd cygwin_common
puppet module build
puppet module install pkg\*.tar.gz --ignore-dependencies
cd ..
remove-item -recurse -force cygwin_common
puppet apply %SYSTEMDRIVE%\ProgramData\PuppetLabs\puppet\etc\modules\cygwin_common\tests\init.pp
