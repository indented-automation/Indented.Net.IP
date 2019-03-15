InModuleScope Indented.Net.IP {
    Describe 'ConvertTo-MaskLength' {
        It 'Returns a 32-bit integer' {
            ConvertTo-MaskLength 255.0.0.0 | Should BeOfType [Int32]
        }

        It 'Converts 0.0.0.0 to 0' {
            ConvertTo-MaskLength 0.0.0.0 | Should Be 0
        }

        It 'Converts 255.255.224.0 to ' {
            ConvertTo-MaskLength 255.255.224.0 | Should Be 19
        }

        It 'Converts 255.255.255.255 to 32' {
            ConvertTo-MaskLength 255.255.255.255 | Should Be 32
        }

        It 'Accepts pipeline input' {
            '128.0.0.0' | ConvertTo-MaskLength | Should Be 1
        }

        It 'Throws an error if passed something other than an IPAddress' {
            { ConvertTo-MaskLength 'abcd' } | Should Throw
        }

        It 'Has valid examples' {
            (Get-Help ConvertTo-MaskLength).Examples.Example.Code | ForEach-Object {
                $ScriptBlock = [ScriptBlock]::Create($_.Trim())
                $ScriptBlock | Should Not Throw
            }
        }
    }
}