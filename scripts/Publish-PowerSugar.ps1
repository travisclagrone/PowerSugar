#Requires -Version 7.1
[CmdletBinding(PositionalBinding = $false, SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [Alias('key')]
    [string]
    $NuGetApiKey,

    [Alias('root')]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Container })]
    [string]
    $RepoRoot = $(Split-Path -LiteralPath $PSScriptRoot)
)

Publish-Module `
    -Path $(Join-Path $RepoRoot 'src' 'PowerSugar') `
    -NuGetApiKey $NuGetApiKey
