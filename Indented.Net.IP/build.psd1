@{
    ModuleManifest           = 'Indented.Net.IP.psd1'
    SourceDirectories        = @(
        'enum'
        'class'
        'private'
        'public'
    )
    PublicFilter             = 'public\*.ps1'
    OutputDirectory          = '../build'
    VersionedOutputDirectory = $true
}
