[CmdletBinding()]
param (
    [Parameter(Mandatory)] [ValidateSet("unpack", "repack")] [String] $Action,
    [Parameter(Mandatory)] [String] $SteamGameDirectory,
    [Parameter()] [String] $QbmsScriptName = "farever_res_pak.bms",
    [Parameter()] [String] $PakFilename = "res.pak",
    [Parameter()] [String] $SourceDirectory = "Farever",
    [Parameter()] [String] $TargetDirectory = "Farever",
    [Parameter()] [switch] $AppendDateToOutput,
    [Parameter()] [switch] $ClearAfter
)

Import-Module -Name "${PSScriptRoot}\quickbms.psm1" -Force

switch (${Action}) {
    "unpack" { Invoke-QbmsExtractScript -QbmsScriptName ${QbmsScriptName} -PakFilename ${PakFilename} -SourceDirectory ${SourceDirectory} -TargetDirectory ${TargetDirectory} -SteamGameDirectory ${SteamGameDirectory} -AppendDateToOutput:$AppendDateToOutput -ClearAfter:$ClearAfter }
    "repack" { Invoke-QbmsRepackScript -QbmsScriptName ${QbmsScriptName} -PakFilename ${PakFilename} -SourceDirectory ${SourceDirectory} -TargetDirectory ${TargetDirectory} -SteamGameDirectory ${SteamGameDirectory} -AppendDateToOutput:$AppendDateToOutput -ClearAfter:$ClearAfter }
}