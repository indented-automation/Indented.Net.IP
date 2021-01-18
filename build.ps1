param (
    [string[]]$TaskName = ('Clean', 'Build', 'Test')
)

function Clean {
    $path = Join-Path -Path $PSScriptRoot -ChildPath 'build'
    if (Test-Path $path) {
        Remove-Item $path -Recurse
    }
}

function Build {
    Build-Module -Path (Resolve-Path $PSScriptRoot\*\build.psd1)
}

function Test {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath 'build\*\*\*.psd1' |
        Get-Item |
        Where-Object { $_.BaseName -eq $_.Directory.Parent.Name }
    $rootModule = $modulePath -replace 'd1$', 'm1'

    $stubPath = Join-Path -Path $PSScriptRoot -ChildPath '*\tests\stub\*.psm1'
    if (Test-Path -Path $stubPath) {
        foreach ($module in $stubPath | Resolve-Path) {
            Import-Module -Name $module -Global
        }
    }

    Import-Module -Name $modulePath -Force -Global

    $configuration = @{
        Run          = @{
            Path     = Join-Path -Path $PSScriptRoot -ChildPath '*\tests' | Resolve-Path
            PassThru = $true
        }
        CodeCoverage = @{
            Enabled    = $true
            Path       = $rootModule
            OutputPath = Join-Path -Path $PSScriptRoot -ChildPath 'build\codecoverage.xml'
        }
        TestResult   = @{
            Enabled    = $true
            OutputPath = Join-Path -Path $PSScriptRoot -ChildPath 'build\nunit.xml'
        }
        Output       = @{
            Verbosity = 'Detailed'
        }
    }
    $testResult = Invoke-Pester -Configuration $configuration

    if ($env:APPVEYOR_JOB_ID) {
        $path = Join-Path -Path $PSScriptRoot -ChildPath 'build\nunit.xml'

        if (Test-Path $path) {
            [System.Net.WebClient]::new().UploadFile(('https://ci.appveyor.com/api/testresults/nunit/{0}' -f $env:APPVEYOR_JOB_ID), $path)
        }
    }

    if ($testResult.FailedCount -gt 0) {
        throw 'One or more tests failed!'
    }
}

function Publish {
    $modulePath = Join-Path -Path $PSScriptRoot -ChildPath 'build\*\*\*.psd1' |
        Get-Item |
        Where-Object { $_.BaseName -eq $_.Directory.Parent.Name } |
        Select-Object -ExpandProperty Directory

    Publish-Module -Path $modulePath.FullName -NuGetApiKey $env:NuGetApiKey -Repository PSGallery -ErrorAction Stop
}

function WriteMessage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Message,

        [ValidateSet('Information', 'Warning', 'Error')]
        [string]$Category = 'Information',

        [string]$Details
    )

    $colour = switch ($Category) {
        'Information' { 'Cyan' }
        'Warning' { 'Yellow' }
        'Error' { 'Red' }
    }
    Write-Host -Object $Message -ForegroundColor $colour

    if ($env:APPVEYOR_JOB_ID) {
        Add-AppveyorMessage @PSBoundParameters
    }
}

function InvokeTask {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$TaskName
    )

    begin {
        Write-Host ('Build {0}' -f $PSCommandPath) -ForegroundColor Green
    }

    process {
        $ErrorActionPreference = 'Stop'
        try {
            $stopWatch = [System.Diagnostics.Stopwatch]::StartNew()

            WriteMessage -Message ('Task {0}' -f $TaskName)
            & "Script:$TaskName"
            WriteMessage -Message ('Done {0} {1}' -f $TaskName, $stopWatch.Elapsed)
        } catch {
            WriteMessage -Message ('Failed {0} {1}' -f $TaskName, $stopWatch.Elapsed) -Category Error -Details $_.Exception.Message

            exit 1
        } finally {
            $stopWatch.Stop()
        }
    }
}

$TaskName | InvokeTask
