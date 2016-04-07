Chocolatey install
==================

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

KMSAutoNet install
==================
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/setup-kmsautonet.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin


librarian-puppet install
==================
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-libarian-puppet.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

