//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QLKS_H2O.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class CHITIET_THUEPHONG
    {
        public string SO_PHIEU { get; set; }
        public string MAPHONG { get; set; }
        public byte SONGUOI { get; set; }
        public decimal GIAPHONG { get; set; }
    
        public virtual PHONG PHONG { get; set; }
        public virtual PHIEU_THUEPHONG PHIEU_THUEPHONG { get; set; }
    }
}