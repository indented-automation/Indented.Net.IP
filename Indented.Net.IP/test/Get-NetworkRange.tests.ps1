InModuleScope Indented.Net.IP {
    Describe 'Get-NetworkRange' {
        It 'Returns an array of IPAddress' {
            Get-NetworkRange 1.2.3.4/32 -IncludeNetworkAndBroadcast | Should BeOfType [IPAddress]
        }
        
        It 'Returns 255.255.255.255 when passed 255.255.255.255/32' {
            $Range = Get-NetworkRange 0/30
            $Range -contains '0.0.0.1' | Should Be $true
            $Range -contains '0.0.0.2' | Should Be $true
            
            $Range = Get-NetworkRange 0.0.0.0/30
            $Range -contains '0.0.0.1' | Should Be $true
            $Range -contains '0.0.0.2' | Should Be $true            

            $Range = Get-NetworkRange 0.0.0.0 255.255.255.252
            $Range -contains '0.0.0.1' | Should Be $true
            $Range -contains '0.0.0.2' | Should Be $true            
        }
       
        It 'Accepts pipeline input' {
            '20/24' | Get-NetworkRange | Select-Object -First 1 | Should Be '20.0.0.1'
        }
        
        It 'Throws an error if passed something other than an IPAddress' {
            { Get-NetworkRange 'abcd' } | Should Throw
        }
        
        It 'Has valid examples' {
            (Get-Help Get-NetworkRange).Examples.Example.Code | ForEach-Object {
                $ScriptBlock = [ScriptBlock]::Create($_.Trim())
                $ScriptBlock | Should Not Throw
            }
        }
    }
}