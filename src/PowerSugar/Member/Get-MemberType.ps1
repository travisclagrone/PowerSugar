function Get-MemberType {
    [Alias('gmt')]
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Position=0)]
        [Alias('Type')]
        [System.Management.Automation.PSMemberTypes]
        ${MemberType},

        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${Name},

        [System.Management.Automation.PSMemberViewTypes]
        ${View},

        [switch]
        ${Static},

        [switch]
        ${Force}
    )
    begin {
        try {
            if ($PSBoundParameters.ContainsKey('OutBuffer')) {
                $PSBoundParameters['OutBuffer'] = 1
            }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Get-Member', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }
    process {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }
    end {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
}
