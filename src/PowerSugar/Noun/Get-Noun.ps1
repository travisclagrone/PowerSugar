function Get-Noun {
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([NounInfo])]
    param(
        [Parameter(Position=0)]
        [SupportsWildcards()]
        [string[]]
        [ValidateNotNullOrEmpty()]
        $Noun,

        [Parameter()]
        [SupportsWildcards()]
        [string[]]
        [ValidateNotNullOrEmpty()]
        $Module
    )

    filter WhereLikeAny ([string[]] $Globs) {
        foreach ($glob in $Globs) {
            if ($_ -like $glob) {
                $_
                break
            }
        }
    }

    if ($Noun) {
        $commands = Get-Command -Noun $Noun
        if ($Module) {
            $commands = $commands | WhereLikeAny $Module
        }
    }
    elseif ($Module) {
        $commands = Get-Command -Module $Module
    }
    else {
        $commands = Get-Command
    }

    $commands |
        Group-Object 'Noun' |
        ForEach-Object { [NounInfo]::new($_.Name, $_.Group) }
}
