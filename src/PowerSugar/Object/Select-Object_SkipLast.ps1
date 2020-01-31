
function Select-Object_SkipLast {
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
        ${SkipLast} = 1,

        [Parameter(ParameterSetName='DefaultParameter')]
        [switch]
        ${Wait}
    )

    begin {
        try {
            $PSBoundParameters['SkipLast'] = $SkipLast

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

Set-Alias -Name 'skiplast' -Value 'Select-Object_SkipLast' -ErrorAction SilentlyContinue
