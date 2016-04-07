remove-item -recurse -force librarian_puppet
puppet module install puppetlabs-stdlib
puppet module install chocolatey-chocolatey
puppet module install basti1302-windows_path
git clone https://github.com/st01tkh/puppet-librarian_puppet librarian_puppet
cd librarian_puppet
puppet module build
puppet module install pkg\*.tar.gz --ignore-dependencies
cd ..
remove-item -recurse -force librarian_puppet
puppet apply %SYSTEMDRIVE%\ProgramData\PuppetLabs\puppet\etc\modules\librarian_puppet\tests\init.pp
