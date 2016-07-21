$CACHE_EXPIRY = (Get-Date).AddDays(-1)
$CACHE_DIR    = Join-Path $PSSCRIPTROOT ".cache"

Get-ChildItem $PSSCRIPTROOT\niche\*.ps1 | %{ . $_ }

New-Item $CACHE_DIR -Type Directory -Force | Out-Null
Get-Content $PSSCRIPTROOT\urls.txt | Initialize-ReviewCache

function reviewsfor {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string] $keyword
  )

  Search-ReviewIndex $keyword | Format-ReviewIndex
}

Export-ModuleMember -Function reviewsfor, Search-ReviewIndex, Format-ReviewIndex
