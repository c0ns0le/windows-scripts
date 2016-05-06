Enable Remote PowerShell
========================

powershell> Enable-PSRemoting -force
powershell> Set-ExecutionPolicy RemoteSigned -Force 

Chocolatey install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))


KMSAutoNet install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/setup-kmsautonet.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/setup-kmsautonet.ps1'))


minimal install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-minimal.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-minimal.ps1'))


puppet install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-puppet.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-puppet.ps1'))


cygwin install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-cygwin.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-cygwin.ps1'))

ca certificates install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-ca_certificates.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-ca_certificates.ps1'))



librarian-puppet install
==================

* @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-librarian-puppet.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
* iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-librarian-puppet.ps1'))

