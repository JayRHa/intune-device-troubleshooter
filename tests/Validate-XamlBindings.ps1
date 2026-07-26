$ErrorActionPreference = 'Stop'

[xml]$xaml = Get-Content "$PSScriptRoot/../xaml/ui.xaml" -Raw
$namedNodes = $xaml.SelectNodes("//*[@*[local-name()='Name']]")
$controlNames = @(
    $namedNodes | ForEach-Object {
        ($_.Attributes | Where-Object { $_.LocalName -eq 'Name' } | Select-Object -First 1).Value
    }
)

if ($controlNames.Count -lt 1) {
    throw 'No x:Name controls were discovered in xaml/ui.xaml.'
}

$duplicates = $controlNames | Group-Object | Where-Object Count -gt 1
if ($duplicates) {
    throw "Duplicate XAML control names: $($duplicates.Name -join ', ')"
}

$source = Get-ChildItem "$PSScriptRoot/.." -Recurse -Include *.ps1,*.psm1 |
    Get-Content -Raw
$referencedControls = [regex]::Matches(($source -join "`n"), '\$WPF([A-Za-z0-9_]+)') |
    ForEach-Object { $_.Groups[1].Value } |
    Sort-Object -Unique
$missingControls = $referencedControls | Where-Object { $_ -notin $controlNames }

if ($missingControls) {
    throw "PowerShell references controls missing from XAML: $($missingControls -join ', ')"
}

Write-Host "Validated $($controlNames.Count) named controls and $($referencedControls.Count) PowerShell references."
