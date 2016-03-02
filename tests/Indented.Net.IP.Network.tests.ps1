Add-Type -TypeDefinition (Get-ChildItem C:\Stuff\Development\Indented.Net.IP\classes | Get-Content -Raw | Out-String)

# Describe 'Indented.Net.IP.Network' {
[Indented.Net.IP.Network]"1.2.3.4 255.255.255.0"
# }