function Measure-Object_Line {
    <#
    .Synopsis
        Measures the count of lines across all of the input objects.

    .Description
        Measures the count of lines across all of the input objects--or one or more properties thereof--that are non-null. Null objects and properties are ignored. If there are zero non-null input objects, then zero is returned.

        Intended for convenience aliasing in interactive sessions.

    .Parameter Property
        Specifies one or more textual properties to measure. If no properties are specified, then either the object itself (if it is textual) or the string representation of the object (if it is non-textual), is measured.

    .Inputs
        System.Management.Automation.PSObject
            You can pipe objects to `Measure-Object_Line`.

    .Outputs
        System.Int32, Microsoft.PowerShell.Commands.TextMeasureInfo
            If more than one property is specified, then the command returns a TextMeasureInfo object for each property. Otherwise, it returns an int.

            If there are zero non-null input objects, then nothing is returned.

    .Notes
        The InputObject parameter should not be invoked directly. Rather, input should piped to this command.

        This command is a wrapper function of `Measure-Object`.

    .Link
        Measure-Object
    #>

    [CmdletBinding(RemotingCapability='None')]
    [OutputType([System.Int32], [Microsoft.PowerShell.Commands.TextMeasureInfo])]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [PSObject]
        $InputObject,

        [Parameter(Position=0)]
        [ValidateNotNullOrEmpty()]
        [PSPropertyExpression[]]
        $Property
    )

    end {
        try {
            $arguments = @{ }
            foreach ($parameterName in @('Property')) {
                if ($PSBoundParameters.ContainsKey($parameterName)) {
                    $arguments[$parameterName] = $PSBoundParameters[$parameterName]
                }
            }

            $textMeasureInfo = $Input | Measure-Object -Character @arguments

            if ($null -ne $textMeasureInfo) {
                if ($Property.Count -gt 1) {
                    $textMeasureInfo
                } else {
                    $textMeasureInfo.Lines
                }
            }
        } catch {
            throw
        }
    }
}

Set-Alias -Name 'lines' -Value 'Measure-Object_Line' -ErrorAction SilentlyContinue

Export-ModuleMember -Function 'Measure-Object_Line' -Alias 'lines'
