#Requires -Version 7.1

# Build Parameters
param(
    [Parameter(HelpMessage = 'Major, Minor, Patch, or nothing (defaults to applying current timestamp as build specifier)')]
    [ValidateSet('Major', 'Minor', 'Patch', '')]
    [string] $BumpVersion = (property BumpVersion ''),

    [string] $PrereleaseLabel = (property PrereleaseLabel ''),

    [string] $BuildLabel = (property BuildLabel (Get-Date -Format 'FileDateTimeUniversal')),

    [SupportsWildcards()]
    [PSDefaultValue(Help = 'All automatically created/generated module manifests.')]
    [ValidateNotNull()]
    [AllowEmptyCollection()]
    [string[]] $NormalizeNewlinePath,

    [string] $NuGetApiKey = (property NuGetApiKey)
)

#region Variables

$ModuleName = 'PowerSugar'
$ModuleRoot = Join-Path $BuildRoot 'src' $ModuleName
$ModuleManifest = Join-Path $ModuleRoot "$ModuleName.psd1"

$NormalizeNewlinePath = $NormalizeNewlinePath ? (Convert-Path $NormalizeNewlinePath | Test-Path -PathType Leaf) : $ModuleManifest

#endregion

#region Functions

function Import-ModuleManifest ([string] $Path = $script:ModuleManifest) { Import-PowerShellDataFile -LiteralPath $Path }

function coalesce { @($input) + $args | Where-Object { $_ } | Select-Object -First 1 }

function ConvertTo-ModuleVersionString ([semver] $SemVer) {
    [semver]::new($SemVer.Major, $SemVer.Minor, $SemVer.Patch).ToString()
}

function ConvertTo-PrereleaseString ([semver] $SemVer) {
    [string] $SemVer.PrereleaseLabel
}

#endregion

#region Tasks

task Version {
    $oldVersion = ((Import-ModuleManifest)['ModuleVersion'] -as [semver]) ?? [semver]::new(0)
    $oldModuleVersion = ConvertTo-ModuleVersionString $oldVersion
    $oldPrerelease = ConvertTo-PrereleaseString $oldVersion

    $newVersion = switch ($BumpVersion) {
        Major {
            [semver]::new(
                $oldVersion.Major + 1,
                0,  # Minor
                0,  # Patch
                $script:PrereleaseLabel,
                $null)  # BuildLabel
        }
        Minor {
            [semver]::new(
                $oldVersion.Major,
                $oldVersion.Minor + 1,
                0,  # Patch
                $script:PrereleaseLabel,
                $null)  # BuildLabel
        }
        Patch {
            [semver]::new(
                $oldVersion.Major,
                $oldVersion.Minor,
                $oldVersion.Patch + 1,
                $script:PrereleaseLabel,
                $null)  # BuildLabel
        }
        default {
            [semver]::new(
                $oldVersion.Major,
                $oldVersion.Minor,
                $oldVersion.Patch,
                (coalesce $script:PrereleaseLabel $oldVersion.PrereleaseLabel),
                ($script:PrereleaseLabel -eq ([string] $oldVersion.PrereleaseLabel)) ? $script:BuildLabel : $null)
        }
    }
    $newModuleVersion = ConvertTo-ModuleVersionString $newVersion
    $newPrerelease = ConvertTo-PrereleaseString $newVersion

    $content = Get-Content -LiteralPath $ModuleManifest -Raw
    $content = $content.Replace("ModuleVersion = '$oldModuleVersion'", "ModuleVersion = '$newModuleVersion'")
    $content = $content.Replace("Prerelease = '$oldPrerelease'", "Prerelease = '$newPrerelease'")
    Set-Content -LiteralPath $ModuleManifest -Value $content -NoNewline
}

task NormalizeNewlines {
    foreach ($file in $script:NormalizeNewlinePath) {
        $txt = Get-Content -Raw $file
        if ($txt.Contains("`r")) {
            $txt = $txt.Replace("`r`n", "`n").Replace("`r", '')
            Set-Content $file $txt -NoNewLine
        }
    }
}

task Build Version, NormalizeNewlines

task Publish Build, {
    Publish-Module -Path $script:ModuleRoot -NuGetApiKey $script:NuGetApiKey
}

task . Build

#endregion
