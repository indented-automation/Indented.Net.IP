namespace Indented.Net.IP
{
    using System;
    using System.Collections.Generic;
    using System.Net;
    using Indented.Net.IP;

    public class Network
    {
        #region Fields
        IPAddress ipAddress;
        IPAddress subnetMask;
        Int32 maskLength;
        List<IPAddress> validSubnetMasks = new List<IPAddress>();
        #endregion
        
        #region Constructors
        public Network(String value)
        {
            Initialize();
            
            ConvertFromCIDRNotation(value);
        }
        
        public Network(Object[] value)
        {
            Initialize();
            
            if (value.Length > 2) 
            {
              throw new ArgumentException("Invalid value");
            }
            
            if (value.Length == 2)
            {
                ConvertFromIPAndMask(value);
            }
            else if(value.Length == 1)
            {
                ConvertFromCIDRNotation(value[0].ToString());
            }
        }
        #endregion
        
        #region Operators
        static public explicit operator Network(String network)
        {
            return new Network(network);
        }

        static public explicit operator Network(Object[] network)
        {
            return new Network(network);
        }
        #endregion
        
        #region Properties
        public IPAddress IPAddress {
            get { return ipAddress; }
        }
        
        public AddressFamily AddressFamily {
            get { return (Indented.Net.IP.AddressFamily)ipAddress.AddressFamily; }
        }
        
        public IPAddress SubnetMask {
            get { return subnetMask; }
        }
        
        public Int32 MaskLength {
            get { return maskLength; }
        }
        #endregion        
        
        #region Methods
        private void Initialize()
        {
             String[] validSubnetMaskStrings = new String[] {
                "0.0.0.0", "128.0.0.0", "192.0.0.0", "224.0.0.0", 
                "240.0.0.0", "248.0.0.0", "252.0.0.0", "254.0.0.0", 
                "255.0.0.0", "255.128.0.0", "255.192.0.0", "255.224.0.0", 
                "255.240.0.0", "255.248.0.0", "255.252.0.0", "255.254.0.0",
                "255.255.0.0", "255.255.128.0", "255.255.192.0", "255.255.224.0", 
                "255.255.240.0", "255.255.248.0", "255.255.252.0", "255.255.254.0",
                "255.255.255.0", "255.255.255.128", "255.255.255.192", "255.255.255.224", 
                "255.255.255.240", "255.255.255.248", "255.255.255.252", "255.255.255.254", 
                "255.255.255.255" };
            foreach (String validSubnetMaskString in validSubnetMaskStrings)
            {
                validSubnetMasks.Add(IPAddress.Parse(validSubnetMaskString));
            }
        }
        
        private void ConvertFromIPAndMask(Object[] value)
        {
            ipAddress = ConvertToIPAddress(value[0]);
            
            ConvertToSubnetMask(value[1]);
        }

        ///<summary>Converts values which may be CIDR notation.</summary>
        private void ConvertFromCIDRNotation(String value)
        {
            IPAddress candidateIPAddress;
            if (IPAddress.TryParse(value, out candidateIPAddress))
            {
                ipAddress = candidateIPAddress;
                subnetMask = IPAddress.Parse("255.255.255.255");
                maskLength = 32;
            }
            else
            {
                Char[] separators = new Char[] { '\\', '/', ' ' };
                foreach(Char separator in separators)
                {
                    if (value.IndexOf(separator) > -1)
                    {
                        Int32 index = value.IndexOf(separator);
                        ipAddress = ConvertToIPAddress(value.Substring(0, index));
                        
                        ConvertToSubnetMask(value.Substring(index + 1, value.Length - index - 1));
                    }
                }
            }
        }

        private void ConvertToSubnetMask(Object value)
        {
            Int32 parsedMaskLength;
            if (value is Int32)
            {
                 maskLength = (Int32)value;
            }
            else if (Int32.TryParse(value.ToString(), out parsedMaskLength))
            {
                maskLength = parsedMaskLength;
            }
            else
            {
                subnetMask = ConvertToIPAddress(value);
            }
        }

        private IPAddress ConvertToIPAddress(Object value)
        {
            IPAddress parsedIPAddress;
            if (value is IPAddress)
            {
                return (IPAddress)value;
            }
            else if (IPAddress.TryParse(value.ToString(), out parsedIPAddress))
            {
                return parsedIPAddress;
            }
            else
            {
                throw new ArgumentException("Unrecognised IPAddress format");
            }
        }
        
        private Int32 ConvertToMaskLength(IPAddress value)
        {
            return 1;
        }
        
        private IPAddress ConvertFromMaskLength(Int32 value)
        {
            return IPAddress.Parse("1.2.3.4");
        }
        #endregion
    }
}