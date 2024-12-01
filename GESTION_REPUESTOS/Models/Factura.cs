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
    
    public partial class Factura
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Factura()
        {
            this.Garantias = new HashSet<Garantia>();
        }
    
        public int FacturaID { get; set; }
        public string ClienteID { get; set; }
        public string EmpleadoID { get; set; }
        public System.DateTime FechaEmision { get; set; }
        public Nullable<int> Garantia_Servicio { get; set; }
        public Nullable<int> PagoID { get; set; }
        [JsonIgnore]
        public virtual Cliente Cliente { get; set; }
        [JsonIgnore]
        public virtual Empleado Empleado { get; set; }
        [JsonIgnore]
        public virtual Pago Pago { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        [JsonIgnore]
        public virtual ICollection<Garantia> Garantias { get; set; }
    }
}
