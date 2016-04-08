#iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
#choco feature enable --name allowGlobalConfirmation # stop the -y flag being needed for all "choco install"s

#choco install -f git 
#choco install -f puppet

Remove-Item -Recurse -Force librarian_puppet
puppet module install puppetlabs-stdlib
puppet module install chocolatey-chocolatey
puppet module install basti1302-windows_path
git clone https://github.com/st01tkh/puppet-librarian_puppet librarian_puppet
cd librarian_puppet
puppet module build
puppet module install pkg\*.tar.gz --ignore-dependencies
cd ..
Remove-Item -Recurse -Force librarian_puppet
puppet apply %SYSTEMDRIVE%\ProgramData\PuppetLabs\puppet\etc\modules\librarian_puppet\tests\init.pp
