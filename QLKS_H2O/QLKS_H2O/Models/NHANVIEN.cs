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
    
    public partial class NHANVIEN
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NHANVIEN()
        {
            this.PHIEU_THUEPHONG = new HashSet<PHIEU_THUEPHONG>();
        }
    
        public string MA_NHANVIEN { get; set; }
        public string PASSWORD { get; set; }
        public string HOTEN_NHANVIEN { get; set; }
        public System.DateTime NGAYSINH { get; set; }
        public string DIENTHOAI { get; set; }
        public string DIACHI { get; set; }
        public string BOPHAN { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PHIEU_THUEPHONG> PHIEU_THUEPHONG { get; set; }
    }
}
