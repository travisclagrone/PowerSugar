function Measure-Object_StandardDeviation {
    <#
    .Synopsis
        Measures the standard deviation of the input objects.

    .Description
        Measures the standard deviation of all input objects--or one or more properties thereof--that are non-null. Null objects and properties are ignored. If there are zero non-null input objects, then the standard deviation is zero.

    .Parameter Property
        Specifies one or more numeric properties to measure. If no properties are specified, then either the object itself (if it is numeric) or the Count property of the object (if it is non-numeric), is measured.

    .Inputs
        System.Management.Automation.PSObject
            You can pipe objects to `Measure-Object_StandardDeviation`.

    .Outputs
        System.Double, Microsoft.PowerShell.Commands.GenericMeasureInfo
            If more than one property is specified, then this command returns a GenericMeasureInfo object for each property. Otherwise, it returns a double.

    .Notes
        The InputObject parameter should not be invoked directly. Rather, input should piped to this command.

        This command is a wrapper function of `Measure-Object`.

    .Link
        Measure-Object
    #>

    [CmdletBinding(RemotingCapability='None')]
    [OutputType([System.Double], [Microsoft.PowerShell.Commands.GenericMeasureInfo])]
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
            $genericMeasureInfo =
                if ($PSBoundParameters.ContainsKey('Property')) {
                    $Input | Measure-Object -StandardDeviation -Property:$Property
                } else {
                    $Input | Measure-Object -StandardDeviation
                }

            if ($Property.Count -gt 1) {
                $genericMeasureInfo
            } else {
                $genericMeasureInfo.StandardDeviation
            }
        } catch {
            throw
        }
    }
}

Set-Alias -Name 'stddev' -Value 'Measure-Object_StandardDeviation' -ErrorAction SilentlyContinue
