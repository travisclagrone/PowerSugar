function Select-Object_Last {
    <#

    .ForwardHelpTargetName Microsoft.PowerShell.Utility\Select-Object
    .ForwardHelpCategory Cmdlet

    #>
    [CmdletBinding(DefaultParameterSetName='DefaultParameter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=113387', RemotingCapability='None')]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Position=0, ParameterSetName='DefaultParameter')]
        [ValidateRange(0, 2147483647)]
        [int]
        ${Last} = 1,

        [Parameter(ParameterSetName='DefaultParameter')]
        [switch]
        ${Wait}
    )

    begin {
        try {
            $PSBoundParameters['Last'] = $Last

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Select-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
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

Set-Alias -Name 'last' -Value 'Select-Object_Last' -ErrorAction SilentlyContinue
