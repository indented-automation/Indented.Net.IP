Describe 'ConvertFrom-HexIP' {
  It 'Converts FFFFFFFF to 255.255.255.255' {
    ConvertFrom-HexIP FFFFFFFF | Should Be '255.255.255.255'
  }
  
  It 'Converts 00000000 to 0.0.0.0' {
    ConvertFrom-HexIP 00000000 | Should Be '0.0.0.0'
  }
  
  It 'Converts C0A87BDD to 192.168.123.221' {
    ConvertFrom-HexIP C0A87BDD | Should Be '192.168.123.221'
  }
  
  It 'Returns an IP Address' {
    ConvertFrom-HexIP FF00FF00 | Should BeOfType [IPAddress]
  }
}

Describe 'ConvertTo-BinaryIP' {
  It 'Converts 1.2.3.4 to 00000001.00000010.00000011.00000100' {
    ConvertTo-BinaryIP 1.2.3.4 | Should Be 00000001.00000010.00000011.00000100
  }
  
  It 'Returns a string' {
    ConvertTo-BinaryIP 255.255.255.255 | Should BeOfType [String]
  }
}

Describe 'ConvertTo-DecimalIP' {
  It 'Converts 0.0.0.0 to UInt32.MinValue' {
    ConvertTo-DecimalIP 0.0.0.0 | Should Be ([UInt32]::MinValue)
  }
  
  It 'Converts 255.255.255.255 to UInt32.MaxValue' {
    ConvertTo-DecimalIP 255.255.255.255 | Should Be ([UInt32]::MaxValue)
  }

  It 'Converts 1.2.3.4 to 16909060' {
    ConvertTo-DecimalIP 1.2.3.4 | Should Be 16909060
  }
}

Describe 'ConvertTo-DottedDecimalIP' {
  It 'Converts UInt32.MaxValue to 255.255.255.255' {
    ConvertTo-DottedDecimalIP ([UInt32]::MaxValue) | Should Be ([IPAddress]"255.255.255.255")
  }
  
  It 'Converts 00000001.00000010.00000011.00000100 to 1.2.3.4' {
    ConvertTo-DottedDecimalIP 00000001.00000010.00000011.00000100 | Should Be ([IPAddress]"1.2.3.4")
  }
}

Describe 'ConvertTo-HexIP' {
  It 'Converts 192.168.0.1 to C0A80001' {
    ConvertTo-HexIP 192.168.0.1 | Should Be C0A80001
  } 
}

Describe 'ConvertTo-Mask' {
  It 'Converts 21 to 255.255.248.0' {
    ConvertTo-Mask 21 | Should Be ([IPAddress]"255.255.248.0") 
  }
  
  It 'Converts 8 to 255.0.0.0' {
    ConvertTo-Mask 8 | Should Be ([IPAddress]"255.0.0.0")
  }
}

Describe 'ConvertTo-MaskLength' {
  It 'Converts 255.255.254.0 to 23' {
    ConvertTo-MaskLength '255.255.254.0' | Should Be 23
  }
}

Describe 'ConvertTo-Subnet' {
  It 'Converts a start address of 12.2.3.32 and an end address of 12.2.3.96 to the closest subnet, 12.2.3.0/25' {
    (ConvertTo-Subnet -Start 12.2.3.32 -End 12.2.3.96).CIDRNotation | Should Be '12.2.3.0/25'
  }
}

Describe 'Get-BroadcastAddress' {
  It 'Gets 172.23.23.255 when given 172.23.23.241/24' {
    Get-BroadcastAddress 172.23.23.241/24 | Should Be ([IPAddress]"172.23.23.255")
  }
}

Describe 'Get-NetworkAddres' {
  It 'Gets 172.23.40.0 when given 172.23.41.21 255.255.254.0' {
    Get-NetworkAddress 172.23.41.21 255.255.254.0 | Should Be ([IPAddress]"172.23.40.0")
  }
}

Describe 'Get-NetworkRange' {
  It 'Gets 1.0.0.1 and 1.0.0.2 when given 1.0.0.0 255.255.255.252' {
    (Get-NetworkRange 1.0.0.0 255.255.255.252) -join ' ' | Should Be '1.0.0.1 1.0.0.2' 
  }
}

Describe 'Get-NetworkSummary' {
  It 'A summary of 248.231.32.43/29 reports class A' {
    (Get-NetworkSummary 10.40.2.32/12).Class | Should Be 'A'
  }

  It 'A summary of 192.168.1.2/25 reports that the range is private' {
    (Get-NetworkSummary 192.168.1.2/25).IsPrivate | Should Be $true
  }
}

Describe 'Get-Subnets' {

}

Describe 'Test-SubnetMember' {
  
}