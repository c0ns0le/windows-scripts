#iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-librarian-puppet.ps1'))

function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

$useSess = $False
$curSessId = Get-Date -Format "yyyyMMddHHmmss"
$scriptDir = Get-ScriptDirectory

function Download-ToFileInScriptDir($url)
{
    $dir = $scriptDir
    $filename = [System.IO.Path]::GetFileName(([System.Uri]"${url}").AbsolutePath)
    $path = Join-Path -Path "${dir}" -ChildPath "${filename}"
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($url, $path)
}

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

function Create-PuppetfileTempDir($url)
{
    $dir = Get-TempDir
    #$dir = Join-Path -Path "${tmpDir}" -ChildPath "Puppetfile.${curSessId}"
    $filename = [System.IO.Path]::GetFileName(([System.Uri]"${url}").AbsolutePath)
    if ($useSess) { 
        $filename = "${filename}.${curSessId}"
    }
    $path = Join-Path -Path "${dir}" -ChildPath "${filename}"
    if (!(Test-Path -Path "$path")) {
        New-Item -ItemType Directory -Path "$path"
    }
    return $path
}

function Download-ToFileToSessDir($url)
{
    $dir = Create-PuppetfileTempDir($url)
    Write-Host "dir: $dir"
    #$filename = [System.IO.Path]::GetFileName(([System.Uri]"${url}").AbsolutePath)
    #$filename = "Puppetfile"
    #$path = Join-Path -Path "${dir}" -ChildPath "${filename}"
    $path = Join-Path -Path "${dir}" -ChildPath "Puppetfile"
    Write-Host "path: $path"
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($url, $path)
    return $path
}

function DownloadAndRun-Puppetfile($url) 
{
    $path = Download-ToFileToSessDir("https://raw.githubusercontent.com/st01tkh/windows-scripts/master/Puppetfile.cygwin")
    $dir = Split-Path "$path" -parent
    $filename = Split-Path "$path" -leaf
    $modDir = Join-Path -ChildPath "modules" "$dir"

    $cwd = $pwd
    $pf = (Get-ChildItem env:ProgramFiles).Value
    $pl = Join-Path -Path "$pf" -ChildPath "Puppet Labs"
    $plBasedir = Join-Path -Path "$pl" -ChildPath "Puppet"
    $plBaseSysDir = Join-Path -Path "$plBasedir" -ChildPath "sys"
    $plBaseRubyDir = Join-Path -Path "$plBaseSysdir" -ChildPath "ruby"
    $plBaseRubyBinDir = Join-Path -Path "$plBaseRubydir" -ChildPath "bin"
    $plBaseBinDir = Join-Path -Path "$plBasedir" -ChildPath "bin"
    $lpExec = Join-Path -Path "$plBaseRubyBinDir" -ChildPath "librarian-puppet.bat"
    #Write-Host "plBaseBinDir: $plBaseBinDir"
    Write-Host "lpExec: $lpExec"
    cd "$dir"
    cmd /c "${lpExec}" install --verbose --clean
    cd "$cwd"

    $progDataDir = (Get-ChildItem env:ALLUSERSPROFILE).Value
    $pupLabsDir = Join-Path -ChildPath "PuppetLabs" "$progDataDir"
    $pupDir = Join-Path -ChildPath "puppet" "$pupLabsDir"
    $etcDir = Join-Path -ChildPath "etc" "$pupDir"
    $dstModDir = Join-Path -ChildPath "modules" "$etcDir"
    Write-Host "modDir: $modDir progDataDir: $progDataDir pupLabsDir: $pupLabsDir etcDir: $etcDir dstModDir: $dstModDir"
    if (!(Test-Path -Path "$dstModDir")) {
        Write-Host "No such directory $dstModDir. Creating ..."
        New-Item "$dstModDir" -ItemType Directory
    }
    Copy-Item "$modDir" "$etcDir" -Force -Recurse
    Remove-Item -Recurse -Force "$dir"
}

DownloadAndRun-Puppetfile("https://raw.githubusercontent.com/st01tkh/windows-scripts/master/Puppetfile.cygwin")
puppet apply %SYSTEMDRIVE%\ProgramData\PuppetLabs\puppet\etc\modules\cygwin_common\tests\init.pp
