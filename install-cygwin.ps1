iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/st01tkh/windows-scripts/master/install-librarian-puppet.ps1'))

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
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile($url, $path)
    return $path
}

function DownloadAndRun-Puppetfile($url) 
{
    $path = Download-ToFileToSessDir("https://raw.githubusercontent.com/st01tkh/windows-scripts/master/Puppetfile.cygwin")
    $dir = Split-Path "$path" -parent
    $filename = Split-Path "$path" -leaf
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
}

DownloadAndRun-Puppetfile("https://raw.githubusercontent.com/st01tkh/windows-scripts/master/Puppetfile.cygwin")
