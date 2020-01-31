function Select-Object_Index {
    <#

    .ForwardHelpTargetName Microsoft.PowerShell.Utility\Select-Object
    .ForwardHelpCategory Cmdlet

    #>

    [CmdletBinding(DefaultParameterSetName='IndexParameter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=113387', RemotingCapability='None')]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Mandatory, Position=0, ParameterSetName='IndexParameter')]
        [ValidateRange(0, 2147483647)]
        [int[]]
        ${Index},

        [Parameter(ParameterSetName='IndexParameter')]
        [switch]
        ${Wait}
    )

    begin {
        try {
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

Set-Alias -Name 'index' -Value 'Select-Object_Index' -ErrorAction SilentlyContinue
