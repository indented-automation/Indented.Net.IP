#requires -Module psake, Configuration, pester

# Self-update
Assert (Test-Path "$psscriptroot\..\BuildTools") 'Cannot find build tools'

if (-not (Test-Path "$psscriptroot\build")) {
    $null = New-Item "$psscriptroot\build" -ItemType Directory
}

Get-ChildItem "$psscriptroot\..\BuildTools" |
    Where-Object {
        $_.Name -like 'build*' -and
        (
            -not (Test-Path "$psscriptroot\build\$($_.Name)") -or 
            $_.LastWriteTime -gt (Get-Item "$psscriptroot\build\$($_.Name)").LastWriteTime
        )
    } | ForEach-Object {
        Copy-Item $_.FullName -Destination "$psscriptroot\build"
    }

Include "$psscriptroot\build\build_utils.ps1"
Include "$psscriptroot\build\build_tasks.ps1"