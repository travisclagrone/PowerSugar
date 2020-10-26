#Requires -Version 7.0.3

# Build Parameters
param(
    [string] $NuGetApiKey = (property NuGetApiKey $(Get-Secret -Name 'NuGetApiKey' | ConvertFrom-SecureString -AsPlainText)),

    [ValidateSet('Major', 'Minor', 'Patch', '')]
    [string] $BumpVersion = (property BumpVersion ''),

    [string] $PrereleaseLabel = (property PrereleaseLabel ''),

    [string] $BuildLabel = (property BuildLabel (Get-Date -Format 'FileDateTimeUniversal')),

    [SupportsWildcards()]
    [PSDefaultValue(Help='All automatically created/generated module manifests.')]
    [ValidateNotNull()]
    [AllowEmptyCollection()]
    [string[]] $NormalizeNewlinePath
)


$ModuleName = 'PowerSugar'
$ModuleRoot = Join-Path $BuildRoot 'src' $ModuleName
$ModuleManifest = Join-Path $ModuleRoot "$ModuleName.psd1"

$NormalizeNewlinePath = $NormalizeNewlinePath ? (Convert-Path $NormalizeNewlinePath | Test-Path -PathType Leaf) : $ModuleManifest


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

task NormalizeNewlines {
    foreach ($file in $script:NormalizeNewlinePath) {
        $txt = Get-Content -Raw $file
        if ($txt.Contains("`r")) {
            $txt = $txt.Replace("`r`n", "`n").Replace("`r", '')
            Set-Content $file $txt -Encoding UTF8
        }
    }
}

task Build Version, NormalizeNewlines

task Publish Build, {
    Publish-Module -Path $script:ModuleRoot -NuGetApiKey $script:NuGetApiKey
}
