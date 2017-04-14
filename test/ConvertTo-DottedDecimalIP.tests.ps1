InModuleScope Indented.Net.IP {
    Describe 'ConvertTo-DottedDecimalIP' {
        It 'Converts 00000001.00000010.00000011.00000100 to 1.2.3.4' {
            ConvertTo-DottedDecimalIP '00000001.00000010.00000011.00000100' | Should Be 1.2.3.4
        }
        
        It 'Converts 16909060 to 1.2.3.4' {
            ConvertTo-DottedDecimalIP 16909060 | Should Be 1.2.3.4
        }
        
        It 'Accepts pipeline input' {
            16909060 | ConvertTo-DottedDecimalIP | Should Be 1.2.3.4
        }
        
        It 'Throws an error if passed an unrecognised format' {
            { ConvertTo-DottedDecimalIP abcd -ErrorAction Stop } | Should Throw
        }
        
        It 'Has valid examples' {
            (Get-Help ConvertTo-DottedDecimalIP).Examples.Example.Code | ForEach-Object {
                $ScriptBlock = [ScriptBlock]::Create($_.Trim())
                $ScriptBlock | Should Not Throw
            }
        }
    }
}