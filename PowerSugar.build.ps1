#Requires -Version 7.1

# Build Parameters
param(
    [string] $NuGetApiKey = (property NuGetApiKey $(
        ConvertFrom-SecureString -AsPlainText $(
            Import-CliXml -LiteralPath (Join-Path $HOME '.keys' 'powershellgallery' "$((Get-ComputerInfo).CsName).clixml"))
    )),

    [ValidateSet('Major', 'Minor', 'Patch', $null)]
    [string] $BumpVersion = (property BumpVersion $null),

    [string] $PrereleaseLabel = (property PrereleaseLabel $null),

    [string] $BuildLabel = (property BuildLabel (Get-Date -Format 'FileDateTimeUniversal'))
)


$ModuleName = 'PowerSugar'
$ModuleRoot = Join-Path $RepoRoot 'src' $ModuleName
$ModuleManifest = Join-Path $ModuleRoot "$ModuleName.psd1"


function Import-ModuleManifest ([string] $Path = $script:ModuleManifest) { Import-PowerShellDataFile -LiteralPath $Path }

function coalesce { @($input) + $args | Where-Object { $_ } | Select-Object -First 1 }


task Version {
    $old = ((Import-ModuleManifest)['ModuleVersion'] -as [semver]) ?? [semver]::new(0)
    $new = switch ($BumpVersion) {
        Major {
            [semver]::new(
                $old.Major + 1,
                0,  # Minor
                0,  # Patch
                $script:PrereleaseLabel,
                $null)  # BuildLabel
        }
        Minor {
            [semver]::new(
                $old.Major,
                $old.Minor + 1,
                0,  # Patch
                $script:PrereleaseLabel,
                $null)  # BuildLabel
        }
        Patch {
            [semver]::new(
                $old.Major,
                $old.Minor,
                $old.Patch + 1,
                $script:PrereleaseLabel,
                $null)  # BuildLabel
        }
        default {
            [semver]::new(
                $old.Major,
                $old.Minor,
                $old.Patch,
                (coalesce $script:PrereleaseLabel $old.PrereleaseLabel),
                $script:BuildLabel ? ($script:PrereleaseLabel -eq ([string] $old.PrereleaseLabel)) : $null)
        }
    }
    Update-ModuleManifest -Path $ModuleManifest -ModuleVersion $new
}

task Build Version

task Publish Build, {
    Publish-Module -Path $script:ModuleRoot -NuGetApiKey $script:NuGetApiKey
}
