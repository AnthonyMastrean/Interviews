function Search-ReviewIndex($keyword) {
  Get-ChildItem $CACHE_DIR `
    | Select-String $keyword `
    | Group-Object Path `
    | Select-Object -Property @{Name="School";Expression={$school,$rest = (Get-Content $_.Name) -split "`n"; $school}},@{Name="Count";Expression={$_.Count}}
}

function Format-ReviewIndex {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [PSObject] $InputObject
  )

  $Input `
    | Sort-Object @{Expression={$_.Count};Descending=$true}, School `
    | Select-Object -First 10 `
    | Format-Table -AutoSize
}
