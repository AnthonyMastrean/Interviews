$CACHE_EXPIRY = (Get-Date).AddDays(-1)
$CACHE_DIR    = ".cache"

function Get-Review([string] $url, [string] $item) {
  Write-Progress -Activity "Indexing College Reviews" -Status "Fetching Review" -CurrentOperation $url

  $progressPreference = "SilentlyContinue"
  (Invoke-WebRequest $url).Content | Set-Content $item
  $progressPreference = "Continue"
}

function Test-CachePath([string] $item) {
  Test-Path $item
}

function Test-CacheExpiry([string] $item) {
  (Get-ChildItem $item).LastWriteTime -le $CACHE_EXPIRY
}

function Get-CachePath([string] $url) {
  Join-Path $CACHE_DIR (Split-Path $url -Leaf)
}

function Initialize-ReviewCache {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string[]] $InputObject
  )

  BEGIN{}

  PROCESS{
    foreach($url in $InputObject) {
      $item = Get-CachePath $url

      if(-not(Test-CachePath $item)) {
        Invoke-FetchReview $url $item
      }

      if(Test-CacheExpiry $item) {
        Invoke-FetchReview $url $item
      }

      $item
    }
  }
  
  END{}
}
