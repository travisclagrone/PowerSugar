function Measure-Object_Sum {
    <#
    .Synopsis
        Measures the sum of the input objects.

    .Description
        Measures the sum of all input objects--or one or more properties thereof--that are non-null. Null objects and properties are ignored. If there are zero non-null input objects, then the sum is zero.

    .Parameter Property
        Specifies one or more numeric properties to measure. If no properties are specified, then either the object itself (if it is numeric) or the Count property of the object (if it is non-numeric), is measured.

    .Inputs
        System.Management.Automation.PSObject
            You can pipe objects to `Measure-Object_Sum`.

    .Outputs
        System.Double, Microsoft.PowerShell.Commands.GenericMeasureInfo
            If more than one property is specified, then the command returns a GenericMeasureInfo object for each property. Otherwise, it returns a double.

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
                    $Input | Measure-Object -Sum -Property:$Property
                } else {
                    $Input | Measure-Object -Sum
                }

            if ($Property.Count -gt 1) {
                $genericMeasureInfo
            } else {
                $genericMeasureInfo.Sum
            }
        } catch {
            throw
        }
    }
}

Set-Alias -Name 'sum' -Value 'Measure-Object_Sum' -ErrorAction SilentlyContinue
