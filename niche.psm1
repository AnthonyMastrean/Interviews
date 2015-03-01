$CACHE_EXPIRY = (Get-Date).AddDays(-1)
$CACHE_DIR    = ".cache"

Get-ChildItem niche\*.ps1 | %{ . $_ }
Get-Content urls.txt | Initialize-ReviewCache

function reviewsfor {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string] $keyword
  )

  Search-ReviewIndex $keyword | Format-ReviewIndex
}

Export-ModuleMember -Function reviewsfor, Search-ReviewIndex, Format-ReviewIndex
