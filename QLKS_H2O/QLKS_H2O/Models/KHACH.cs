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
    
    public partial class KHACH
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KHACH()
        {
            this.PHIEU_THUEPHONG = new HashSet<PHIEU_THUEPHONG>();
        }
    
        public string MA_KHACH { get; set; }
        public string HOTEN_KHACH { get; set; }
        public string CMND { get; set; }
        public string DIENTHOAI { get; set; }
        public string QUOCTICH { get; set; }
        public bool GIOITINH { get; set; }
        public System.DateTime NGAYSINH { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PHIEU_THUEPHONG> PHIEU_THUEPHONG { get; set; }
    }
}
