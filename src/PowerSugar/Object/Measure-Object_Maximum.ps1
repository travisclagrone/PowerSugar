function Measure-Object_Maximum {
    <#
    .Synopsis
        Measures the maximum of the input objects.

    .Description
        Measures the maximum of all input objects--or one or more properties thereof--that are non-null. Null objects and properties are ignored. If there are zero non-null input objects, then nothing is returned.

    .Parameter Property
        Specifies one or more numeric properties to measure. If no properties are specified, then either the object itself (if it is numeric) or the Count property of the object (if it is non-numeric), is measured.

    .Inputs
        System.Management.Automation.PSObject
            You can pipe objects to `Measure-Object_Maximum`.

    .Outputs
        System.Double, Microsoft.PowerShell.Commands.GenericMeasureInfo
            If more than one property is specified, then the command returns a GenericMeasureInfo object for each property. Otherwise, it returns a double.

            If there are zero non-null input objects, then nothing is returned.

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
                    $Input | Measure-Object -Maximum -Property:$Property
                } else {
                    $Input | Measure-Object -Maximum
                }

            if ($null -ne $genericMeasureInfo) {
                if ($Property.Count -gt 1) {
                    $genericMeasureInfo
                } else {
                    $genericMeasureInfo.Maximum
                }
            }
        } catch {
            throw
        }
    }
}

Set-Alias -Name 'max' -Value 'Measure-Object_Maximum' -ErrorAction SilentlyContinue

Export-ModuleMember -Function 'Measure-Object_Maximum' -Alias 'max'
