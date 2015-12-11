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