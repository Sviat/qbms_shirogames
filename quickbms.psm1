Set-Variable QbmsDirectoryDefault -Option Constant -Value "quickbms"
Set-Variable QbmsBinaryDefault -Option Constant -Value "quickbms_4gb_files"
Set-Variable PakFileDefault -Option Constant -Value "res.pak"
Set-Variable ExtractDirSuffix -Option Constant -Value "extracted"
Set-Variable RepackDirDefault -Option Constant -Value "repak"

function Copy-PakFromSourceLocation {
    param (
        [Parameter(Mandatory)] [string] $SourceLocation,
        [Parameter()] [string] $TargetLocation = $PWD,
        [Parameter()] [ValidatePattern("\.pak$")][string] $PakFilename = ${PakFileDefault}
    )

    Copy-Item -Path (Join-Path ${SourceLocation} ${PakFilename}) -Destination ${TargetLocation} -Force
}

function Invoke-QbmsExtractPakToDirHelper {
    param (
        [Parameter(Mandatory)] [string] $QbmsScript,
        [Parameter(Mandatory)] [string] $SourceDirectory,
        [Parameter(Mandatory)] [string] $TargetDirectory,
        [Parameter()] [ValidatePattern("\.pak$")][string] $PakFilename = ${PakFileDefault},
        [Parameter()] [String] $QbmsDirectory = ${QbmsDirectoryDefault},
        [Parameter()] [String] $QbmsBinary = ${QbmsBinaryDefault},
        [Parameter()] [switch] $AppendDateToOutput
    )

    $PakCleanName = ${PakFilename} -replace '\.', '_'
    $ExtractDirName = "${PakCleanName}_${ExtractDirSuffix}"
    if ($AppendDateToOutput) {
        $DateSuffix = Get-Date -Format "yyyyMMdd"
        $ExtractDirName = "${ExtractDirName}_${DateSuffix}"
    }

    $QbmsBinaryLocation = Convert-ToAbsolutePath (Join-Path ${QbmsDirectory} "${QbmsBinary}.exe")
    $QbmsScriptLocation = (Convert-ToScriptLocalPath ${QbmsScript})
    $SourceLocation = Join-Path ${SourceDirectory} ${PakFilename}
    $TargetLocation = Join-Path ${TargetDirectory} ${ExtractDirName}
    & ${QbmsBinaryLocation} -o -D ${QbmsScriptLocation} ${SourceLocation} ${TargetLocation}
}

function Invoke-QbmsExtractScript {
    param (
        [Parameter(Mandatory)] [String] $QbmsScriptName,
        [Parameter(Mandatory)] [String] $PakFilename,
        [Parameter(Mandatory)] [String] $SourceDirectory,
        [Parameter(Mandatory)] [String] $TargetDirectory,
        [Parameter(Mandatory)] [String] $SteamGameDirectory,
        [Parameter()] [switch] $AppendDateToOutput,
        [Parameter()] [switch] $ClearAfter
    )

    $PakLocation = Join-Path ${SourceDirectory} ${PakFilename}
    if (-not (Test-Path ${PakLocation})) {
        Copy-PakFromSourceLocation -SourceLocation ${SteamGameDirectory} -TargetLocation ${PakLocation} -PakFilename ${PakFilename}
    }

    Invoke-QbmsExtractPakToDirHelper -QbmsScript ${QbmsScriptName} -SourceDirectory ${SourceDirectory} -TargetDirectory ${TargetDirectory} -PakFilename ${PakFilename} -AppendDateToOutput:$AppendDateToOutput

    if ($ClearAfter) {
        Remove-Item -Path ${PakLocation} -Force
    }
}

function Invoke-QbmsRepackScript {
    param (
        [Parameter(Mandatory)] [String] $QbmsScriptName,
        [Parameter(Mandatory)] [String] $PakFilename,
        [Parameter(Mandatory)] [String] $SourceDirectory,
        [Parameter(Mandatory)] [String] $TargetDirectory,
        [Parameter(Mandatory)] [String] $SteamGameDirectory,
        [Parameter()] [switch] $AppendDateToOutput,
        [Parameter()] [switch] $ClearAfter
    )

    # TODO: Implement repack logic
}

function Convert-ToAbsolutePath {
    param (
        [Parameter(Mandatory)] [string] $Path
    )

    if (-not [System.IO.Path]::IsPathRooted($Path)) {
        return (Join-Path (Get-Location) ${Path})
    }

    return $Path
}

function Convert-ToScriptLocalPath {
    param (
        [Parameter(Mandatory)] [string] $Path
    )

    return (Join-Path ${PSScriptRoot} ${Path})
}