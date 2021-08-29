function Resolve-String {
    <#
    .SYNOPSIS
        Expands a PowerShell string.

    .DESCRIPTION
        Expands (interpolates) a string as if it were an expandable (double-quoted) string in the current PowerShell context.

    .PARAMETER InputObject
        The string to expand.

    .EXAMPLE
        PS> $MessageTemplate = 'Hello, $name!'; foreach ($name in 'Susie', 'Bobby', 'Johnny') { Resolve-String $MessageTemplate }
        Hello, Susie!
        Hello, Bobby!
        Hello, Johnny!

    .EXAMPLE
        PS> Get-ChildItem /Users -Directory -PipelineVariable Path | Select-Object -ExpandProperty Name -PipelineVariable Name | Resolve-String '${Path}/${Name}.log'

    .EXAMPLE
        PS> expand $template

    #>
    [Alias('expand')]
    [CmdletBinding(PositionalBinding)]
    [SuppressMessage('PSAvoidAssignmentToAutomaticVariable', '', Target = '$_',
                     Justification = 'Cannot create any auxiliary variables due to danger of namespace clash with expandable string contents, which is unavoidably evaluated in the same scope.')]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [ValidateNotNull()]
        [string]
        $InputObject
    )
    process {
        $ExecutionContext.InvokeCommand.ExpandString($InputObject)
    }
}
