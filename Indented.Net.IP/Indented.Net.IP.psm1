# Development time root module
Get-ChildItem $psscriptroot\private, $psscriptroot\public -Filter *.ps1 -File -Recurse | ForEach-Object {
    . $_.FullName
}