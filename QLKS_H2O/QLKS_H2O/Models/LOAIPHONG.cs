﻿//------------------------------------------------------------------------------
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
    using System.ComponentModel;

    public partial class LOAIPHONG
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LOAIPHONG()
        {
            this.PHONGs = new HashSet<PHONG>();
            this.VATTU_LOAIPHONG = new HashSet<VATTU_LOAIPHONG>();
        }
    
        [DisplayName("Mã loại phòng")]
        
        public string MA_LOAIPHONG { get; set; }
        [DisplayName("Tên loại phòng")]
        public string TEN_LOAIPHONG { get; set; }
        [DisplayName("Kích thước")]
        public int KICHTHUOC { get; set; }
        [DisplayName("Mã màu")]
        public string MAMAU { get; set; }
        [DisplayName("Ảnh")]
        public string ANH { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PHONG> PHONGs { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<VATTU_LOAIPHONG> VATTU_LOAIPHONG { get; set; }
    }
}