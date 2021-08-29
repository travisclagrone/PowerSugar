function Invoke-Enumerator {
    [Alias('enumerate')]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [object]
        $InputObject
    )
    process {
        if ($null -eq $InputObject) {
            # pass
        }
        elseif ($InputObject -is [Collections.IEnumerator]) {
            $InputObject
        }
        elseif ($InputObject -is [Collections.IEnumerable]) {
            $InputObject.GetEnumerator()
        }
        else {
            $InputObject
        }
    }
}
