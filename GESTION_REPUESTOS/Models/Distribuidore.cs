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
    
    public partial class Distribuidore
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Distribuidore()
        {
            this.Repuestos = new HashSet<Repuesto>();
        }
    
        public string ProveedorID { get; set; }
        public string Nombre { get; set; }
        public string Teléfono { get; set; }
        public string Email { get; set; }
        public string Dirección { get; set; }
        public string Contacto { get; set; }
        public Nullable<System.DateTime> FechaRegistro { get; set; }
        public string Estado { get; set; }
        [JsonIgnore]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Repuesto> Repuestos { get; set; }
    }
}
