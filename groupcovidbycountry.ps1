$snapshotRequest = Invoke-WebRequest -Uri https://coronadatascraper.com/data.csv -Method Get
$snapshotRequest.Content > .\snapshot\covid-19.csv
$snapshotData = Import-Csv -Path .\snapshot\covid-19.csv
$casesByCountry = $snapshotData | Group-Object -Property Country | ForEach-Object { 
    New-Object -TypeName psobject -Property @{
        Country = $_.Name
        Cases = ($_.Group | Measure-Object -Property Cases -Sum).Sum
        Active = ($_.Group | Measure-Object -Property Active -Sum).Sum
        Deaths = ($_.Group | Measure-Object -Property Deaths -Sum).Sum
        Recovered = ($_.Group | Measure-Object -Property Recovered -Sum).Sum
    }
 }
 
 $sortedCasesByCountry = $casesByCountry | Sort-Object -Property Cases -Descending

 #output
if (!(Test-Path output)) {
    New-Item output -ItemType Directory
}
$sortedCasesByCountry | Export-Csv -Path .\output\cases-by-country.csv