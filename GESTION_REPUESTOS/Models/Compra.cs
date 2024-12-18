//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GESTION_REPUESTOS.Models
{
    using Newtonsoft.Json;
    using System;
    using System.Collections.Generic;
    
    public partial class Compra
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Compra()
        {
            this.CompraRepuestos = new HashSet<CompraRepuesto>();
        }
    
        public int CompraID { get; set; }
        public Nullable<int> RepuestoID { get; set; }
        public string ClienteID { get; set; }
        public System.DateTime FechaCompra { get; set; }
        public decimal MontoTotal { get; set; }
        [JsonIgnore]
        public virtual Cliente Cliente { get; set; }
        [JsonIgnore]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CompraRepuesto> CompraRepuestos { get; set; }
        [JsonIgnore]
        public virtual Repuesto Repuesto { get; set; }
    }
}
