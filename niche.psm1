# Let's say we have an entry point like this...
#
#   PS> Import-Module niche
#   PS> Search-ReviewIndex "keyword"
#
#   Name  Value
#   ----  -----
#   Foo   3
#   Bar   1
# 

$INDEX = Import-CliXml .\.index.xml

Get-ChildItem .\niche\*.ps1 | %{ . $_ }

function Refresh-ReviewIndex {
  Get-Content .\urls.txt `
    | Initialize-ReviewCache `
    | Initialize-ReviewIndex (Get-Content .\stopWords.txt) `
    | Export-CliXml .\.index.xml  
}

Export-ModuleMember -Function Refresh-ReviewIndex, Search-ReviewIndex, Print-ReviewIndex
