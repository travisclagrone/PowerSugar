function Get-Member {
    <#
        .ForwardHelpTargetName Microsoft.PowerShell.Utility\Get-Member
        .ForwardHelpCategory Cmdlet
    #>
    [CmdletBinding(DefaultParameterSetName='Standalone', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096704', RemotingCapability='None')]
    param(
        [Parameter(ParameterSetName='Standalone', Position=0)]
        [Parameter(ParameterSetName='Pipeline', ValueFromPipeline=$true, Mandatory)]
        [psobject]
        ${InputObject},

        [Parameter(ParameterSetName='Standalone', Position=1)]
        [Parameter(ParameterSetName='Pipeline', Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        ${Name},

        [Alias('Type')]
        [System.Management.Automation.PSMemberTypes]
        ${MemberType},

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
