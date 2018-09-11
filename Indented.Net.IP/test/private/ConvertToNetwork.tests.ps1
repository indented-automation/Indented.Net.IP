InModuleScope Indented.Net.IP {
    Describe 'ConvertToNetwork' {
        It 'Translates the string 0/0 to 0.0.0.0/0 (mask 0.0.0.0)' {
            $Network = ConvertToNetwork 0/0
            $Network.IPAddress | Should Be '0.0.0.0'
            $Network.SubnetMask | Should Be '0.0.0.0'
            $Network.MaskLength | Should Be 0
        }

        It 'Translates the string 1.2/27 to 1.2.0.0/27 (mask 255.255.255.224)' {
            $Network = ConvertToNetwork 1.2/27
            $Network.IPAddress | Should Be '1.2.0.0'
            $Network.SubnetMask | Should Be '255.255.255.224'
            $Network.MaskLength | Should Be 27
        }
        
        It 'Translates a string containing "3.4.5 255.255.0.0" to 3.4.5.0/16 (mask 255.255.0.0)' {
            $Network = ConvertToNetwork "3.4.5 255.255.0.0"
            $Network.IPAddress | Should Be '3.4.5.0'
            $Network.SubnetMask | Should Be '255.255.0.0'
            $Network.MaskLength | Should Be 16
        }
        
        It 'Translates IPAddress argument 1.2.3.4 and SubnetMask argument 24 to 1.2.3.4/24 (mask 255.255.255.0)' {
            $Network = ConvertToNetwork 1.2.3.4 -SubnetMask 24
            $Network.IPAddress | Should Be '1.2.3.4'
            $Network.SubnetMask | Should Be '255.255.255.0'
            $Network.MaskLength | Should Be 24
        }
        
        It 'Translates IPAddress argument 212.44.56.21 and SubnetMask argument 255.255.128.0 to 212.44.56.21/17' {
            $Network = ConvertToNetwork 212.44.56.21 255.255.128.0
            $Network.IPAddress | Should Be '212.44.56.21'
            $Network.SubnetMask | Should Be '255.255.128.0'
            $Network.MaskLength | Should Be 17
        }
        
        It 'Translates IPAddres argument 1.0.0.0 with no SubnetMask argument to 1.0.0.0/32 (mask 255.255.255.255)' {
            $Network = ConvertToNetwork 1.0.0.0
            $Network.IPAddress | Should Be '1.0.0.0'
            $Network.SubnetMask | Should Be '255.255.255.255'
            $Network.MaskLength | Should Be 32
        }
        
        It 'Handles all MaskLength values' {
            $HasError = $false
            0..32 | ForEach-Object {
                try {
                    ConvertToNetwork "10.0.0.0/$_"
                } catch {
                    $HasError = $true
                }
                
                $HasError | Should Be $false
            }
        }
       
        It 'Handles all valid subnet mask values' {
            $ValidSubnetMaskValues = 
                "0.0.0.0", "128.0.0.0", "192.0.0.0", 
                "224.0.0.0", "240.0.0.0", "248.0.0.0", "252.0.0.0",
                "254.0.0.0", "255.0.0.0", "255.128.0.0", "255.192.0.0",
                "255.224.0.0", "255.240.0.0", "255.248.0.0", "255.252.0.0",
                "255.254.0.0", "255.255.0.0", "255.255.128.0", "255.255.192.0",
                "255.255.224.0", "255.255.240.0", "255.255.248.0", "255.255.252.0",
                "255.255.254.0", "255.255.255.0", "255.255.255.128", "255.255.255.192",
                "255.255.255.224", "255.255.255.240", "255.255.255.248", "255.255.255.252",
                "255.255.255.254", "255.255.255.255"
            $HasError = $false
            $ValidSubnetMaskValues | ForEach-Object {
                try {
                    ConvertToNetwork '10.0.0.0' $_
                } catch {
                    $HasError = $true
                }
                
                $HasError | Should Be $false
            }
        }
    }
}