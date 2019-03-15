InModuleScope Indented.Net.IP {
    Describe 'Test-SubnetMember' {
        It 'Returns a Boolean' {
            Test-SubnetMember 10.0.0.0/24 -ObjectIPAddress 10.0.0.0/8 | Should BeOfType [Boolean]
        }

        It 'Returns true if the subject falls within the object network' {
            Test-SubnetMember 1.2.3.4 -ObjectIPAddress 1.2.3.0/24 | Should Be $true
        }

        It 'Returns false if the subject does fall within the object network' {
            Test-SubnetMember 1.2.3.4 -ObjectIPAddress 2.0.0.0/24 | Should Be $false
        }

        It 'Throws an error if passed something other than an IPAddress for Subject or Object' {
            { Test-SubnetMember -SubjectIPAddress 'abcd' -ObjectIPAddress 10.0.0.0/8 } | Should Throw
            { Test-SubnetMember -SubjectIPAddress 10.0.0.0/8  -ObjectIPAddress 'abcd' } | Should Throw
        }

        It 'Has valid examples' {
            (Get-Help Test-SubnetMember).Examples.Example.Code | ForEach-Object {
                $ScriptBlock = [ScriptBlock]::Create($_.Trim())
                $ScriptBlock | Should Not Throw
            }
        }
    }
}