# Let's say we have an entry point like this...
#
#   PS> Import-Module niche
#   PS> Search-ReviewIndex "keyword"
#   Matches <count> reviews for <school>
#   Matches <count> reviews for <school>
#   Matches <count> reviews for <school>
# 

$INDEX = Import-CliXml .\.index.xml

Get-ChildItem .\niche\*.ps1 | %{ . $_ }

function Refresh-ReviewIndex {
  Get-Content .\urls.txt `
    | Initialize-ReviewCache `
    | Initialize-ReviewIndex (Get-Content .\stopWords.txt) `
    | Export-CliXml .\.index.xml  
}

function Search-ReviewIndex($keyword) {
  $INDEX[$keyword] | Write-Host
}

Export-ModuleMember -Function Refresh-ReviewIndex, Search-ReviewIndex
