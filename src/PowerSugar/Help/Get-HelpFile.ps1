function Get-HelpFile {
    <#
    .ForwardHelpTargetName Microsoft.PowerShell.Core\Get-Help
    .ForwardHelpCategory Cmdlet
    #>
    [Alias('about')]
    [CmdletBinding(DefaultParameterSetName='AllUsersView', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096483')]
    param(
        [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
        [SupportsWildcards()]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch '^\s+$' }, ErrorMessage = 'Name may not consist of only whitespace.')]
        [string]
        $Name,

        [string[]]
        $Component,

        [string[]]
        $Functionality,

        [string[]]
        $Role,

        [Parameter(ParameterSetName='Online', Mandatory=$true)]
        [switch]
        $Online,

        [Parameter(ParameterSetName='ShowWindow', Mandatory=$true)]
        [switch]
        $ShowWindow
    )
    begin {
        try {
            function Resolve-Name ([string] $Name) {
                $Name = $Name.Trim() -replace '\s+', '_'
                $Name =
                    ($Name -in @('Help', 'about', 'default')) ? 'default' :
                    ($Name -like 'about_*') ? $Name.Substring('about_'.Length) :
                    $Name.TrimStart('_')
                $Name = 'about_{0}' -f $Name
                return $Name
            }

            $isPipelined = $true
            if ($Name) {
                $PSBoundParameters['Name'] = Resolve-Name $Name
                $isPipelined = $false
            }

            $PSBoundParameters['Category'] = 'HelpFile'

            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Get-Help', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }
    process {
        try {
            if ($isPipelined) {
                $steppablePipeline.Process((Resolve-Name $Name))
            } else {
                $steppablePipeline.Process()
            }
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
