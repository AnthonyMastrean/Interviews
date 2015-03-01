function Get-Review([string] $url, [string] $item) {
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

  Write-Progress -Activity "Indexing College Reviews"

  foreach($url in $Input) {
    $progress++
    $completed = $progress / $Input.count * 100

    $item = Get-CachePath $url

    if(-not(Test-CachePath $item)) {
      Get-Review $url $item
    }

    if(Test-CacheExpiry $item) {
      Get-Review $url $item
    }

    Write-Progress -Activity "Indexing College Reviews" -Status "Fetching Reviews" -CurrentOperation $url -PercentComplete $completed
    $item
  }

  Write-Progress -Activity "Indexing College Reviews" -Completed
}
