$root = 't/wtp'

mkdir "../$root/tipitaka/data" -Force | Out-Null

Get-ChildItem ../wtp/tipitaka -rec -filt *.xml 
| ForEach-Object { 
    $fileName = $_.FullName.Replace("\", "/").Replace("/wtp/", "/$root/").Replace(".xml", ".html"); 
    "<!-- auto generated -->" | Out-File -FilePath $fileName -Encoding utf8BOM
    "<link href='/$root/main.css' rel='stylesheet'>" | Out-File -FilePath $fileName -Encoding utf8BOM -Append 
    ([xml](Get-Content $_.FullName)).xml.data | Out-File -FilePath $fileName -Encoding utf8BOM -Append 
    '<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>' | Out-File -FilePath $fileName -Encoding utf8BOM -Append
    "<script src='/$root/main.js'></script>" | Out-File -FilePath $fileName -Encoding utf8BOM -Append
}

Get-ChildItem tipitaka -filt *.xml 
| ForEach-Object { 
    $_.Name -imatch "^([0-9]+)([a-z]+)(.*)\.xml$" | Out-Null; 
    @{ n = $Matches.1; id = $Matches.2; sub = $Matches.3 } 
} 
| Group-Object -Property id  
| ForEach-Object { 
    Write-Output "<h3>$($_.Name)</h3><ul>"
    $_.Group 
    | Sort-Object { [int]$_.n },{ [int]$_.sub } 
    | ForEach-Object { 
        "<li><a href='/$root/tipitaka/$($_.n)$($_.id)$($_.sub).html'>$($_.n)$($_.id)$($_.sub)</a></li>" 
    } 
    Write-Output "</ul>" 
}  | Out-File -FilePath ../$root/index.html -Encoding utf8BOM

@("main.js", "main.css")
| ForEach-Object { Copy-Item $_ ../$root/ }