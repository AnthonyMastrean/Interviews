function Search-ReviewIndex($keyword) {
  $INDEX[$keyword]
}

function Print-ReviewIndex {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [PSObject] $InputObject
  )

  $InputObject.GetEnumerator() `
    | Sort-Object Value -Descending `
    | Select-Object -First 10 `
    | Format-Table -AutoSize
}
