$sources = @(
    'DateTime/Format-Now.ps1'
    'DateTime/Format-Today.ps1'
    'DateTime/Get-Now.ps1'
    'DateTime/Get-Today.ps1'
    'Object/Measure-Object_All.ps1'
    'Object/Measure-Object_AllStats.ps1'
    'Object/Measure-Object_Any.ps1'
    'Object/Measure-Object_Average.ps1'
    'Object/Measure-Object_Character.ps1'
    'Object/Measure-Object_Count.ps1'
    'Object/Measure-Object_Line.ps1'
    'Object/Measure-Object_Maximum.ps1'
    'Object/Measure-Object_Minimum.ps1'
    'Object/Measure-Object_StandardDeviation.ps1'
    'Object/Measure-Object_Sum.ps1'
    'Object/Measure-Object_Word.ps1'
    'Object/Select-Object_First.ps1'
    'Object/Select-Object_Index.ps1'
    'Object/Select-Object_Last.ps1'
    'Object/Select-Object_Skip.ps1'
    'Object/Select-Object_SkipIndex.ps1'
    'Object/Select-Object_SkipLast.ps1'
    'PSItem/Where-PSItem.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
