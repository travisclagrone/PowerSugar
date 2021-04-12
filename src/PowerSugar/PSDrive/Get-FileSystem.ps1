using namespace System.Management.Automation

function Get-FileSystem {
    <#
    .ForwardHelpTargetName Microsoft.PowerShell.Management\Get-PSDrive
    .ForwardHelpCategory Cmdlet
    #>
    [Alias('gfs')]  # spell-checker:ignore gfs
    [CmdletBinding(DefaultParameterSetName='Name', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096494')]
    param(
        [Parameter(ParameterSetName='Name', Position=0, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Name,

        [Parameter(ParameterSetName='LiteralName', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string[]]
        $LiteralName,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [string]
        $Scope
    )
    dynamicparam {
        try {
            $targetCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-PSDrive', [CommandTypes]::Cmdlet, $PSBoundParameters)
            $dynamicParams = @($targetCmd.Parameters.GetEnumerator() | Microsoft.PowerShell.Core\Where-Object { $_.Value.IsDynamic })
            if ($dynamicParams.Length -gt 0) {
                $paramDictionary = [RuntimeDefinedParameterDictionary]::new()
                foreach ($param in $dynamicParams) {
                    $param = $param.Value
                    if(-not $MyInvocation.MyCommand.Parameters.ContainsKey($param.Name)) {
                        $dynParam = [RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)  # spell-checker:ignore dyn
                        $paramDictionary.Add($param.Name, $dynParam)
                    }
                }
                return $paramDictionary
            }
        } catch {
            throw
        }
    }
    begin {
        try {
            $PSBoundParameters['PSProvider'] = 'FileSystem'

            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Management\Get-PSDrive', [CommandTypes]::Cmdlet)
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
