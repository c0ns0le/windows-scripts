iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-ca_certificates.ps1'))
#iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
#choco feature enable --name allowGlobalConfirmation # stop the -y flag being needed for all "choco install"s

#choco install git 
#choco install puppet

$curSessId = Get-Date -Format "yyyyMMddHHmmss"

function Get-TempDir
{
    $tmpDir = (Get-ChildItem env:Temp).Value
    Write-Host $tmpDir
    if (!$tmpDir) {
        $drive = (Get-ChildItem env:SystemDrive).Value
        $tmpDir = Join-Path -Path "$drive" -ChildPath "temp"
        if (!(Test-Path -Path "$tmpDir")) {
            New-Item -ItemType Directory -Path "$tmpDir"
        }
    }
    return $tmpDir
}

Function Install-PuppetModule($url, $mod) {
    Write-Host "URL: $url MOD: $mod"
    if (!$mod) {
        $mod = "unknownPuppetModule"
    }
    get-childitem $env:temp
    $tmpRootDir = Get-TempDir
    $tmpModDir = Join-Path -ChildPath "puppet.module.${mod}.$curSessId" "$tmpRootDir"
    Write-Host $tmpModDir
    if (!(Test-Path "$tmpModDir")) {
        New-Item "$tmpModDir" -ItemType Directory
    }
    if (!(Test-Path "$tmpModDir")) {
        return 10
    }
    $cwd = $pwd
    cd "$tmpModDir"
    git clone "$url" "$mod"
    cd "$mod"
    puppet module build
    puppet module install -f pkg\*.tar.gz --ignore-dependencies
    cd "$cwd"
    Remove-Item -Recurse -Force "$tmpModDir"
}

Install-PuppetModule "https://github.com/puppetlabs/puppetlabs-stdlib" "stdlib"
Install-PuppetModule "https://github.com/puppetlabs/puppetlabs-powershell" "powershell"
Install-PuppetModule "https://github.com/chocolatey/puppet-chocolatey" "chocolatey"
Install-PuppetModule "https://github.com/basti1302/puppet-windows-path" "windows_path"
Install-PuppetModule "https://github.com/st01tkh/puppet-librarian_puppet" "librarian_puppet"
puppet apply %SYSTEMDRIVE%\ProgramData\PuppetLabs\puppet\etc\modules\librarian_puppet\tests\init.pp
