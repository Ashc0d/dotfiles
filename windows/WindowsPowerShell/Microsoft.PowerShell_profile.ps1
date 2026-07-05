Remove-Item alias:curl -Force
Remove-Item alias:si -Force -ErrorAction SilentlyContinue
Set-Alias curl "${env:SystemRoot}\System32\curl.exe"
function Get-PublicIP { (Invoke-WebRequest -UseBasicParsing http://ifconfig.me/ip).Content }

function mkcd {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path
    )

    New-Item -ItemType Directory -Force -Path $Path | Out-Null
    Set-Location -Path $Path
}

function ffile {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Pattern
    )

    Get-ChildItem -Recurse -File | Where-Object { $_.FullName -match $Pattern }
}

function fhis {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Pattern
    )

    $historyPath = (Get-PSReadLineOption).HistorySavePath
    if ($historyPath -and (Test-Path -Path $historyPath)) {
        Get-Content -Path $historyPath | Where-Object { $_ -match $Pattern }
        return
    }

    Get-History | Where-Object { $_.CommandLine -match $Pattern } | ForEach-Object { $_.CommandLine }
}

function Get-PathSize {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path
    )

    $item = Get-Item -Force -Path $Path
    if ($item.PSIsContainer) {
        $total = (Get-ChildItem -Path $item.FullName -Recurse -Force -File | Measure-Object -Property Length -Sum).Sum
    } else {
        $total = $item.Length
    }

    if ($null -eq $total) {
        $total = 0
    }

    return $total
}

function Format-PathSize {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [long]$Bytes
    )

    $kilobytes = $Bytes / 1KB
    if ($kilobytes -gt 1024) {
        return "{0:N2} MB" -f ($Bytes / 1MB)
    }

    return "{0:N2} KB" -f $kilobytes
}

function si {
    param(
        [Parameter(Position = 0)]
        [string]$Path = "."
    )

    $total = Get-PathSize -Path $Path
    "{0}`t{1}" -f (Format-PathSize -Bytes $total), $Path
}

function siall {
    Get-ChildItem -Force | ForEach-Object {
        $total = Get-PathSize -Path $_.FullName
        "{0}`t{1}" -f (Format-PathSize -Bytes $total), $_.Name
    }
}
