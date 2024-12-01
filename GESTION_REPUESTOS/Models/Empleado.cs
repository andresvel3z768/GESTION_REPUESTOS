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
    using System;
    using System.Collections.Generic;
    
    public partial class Empleado
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Empleado()
        {
            this.EmpleadoCargoes = new HashSet<EmpleadoCargo>();
            this.Facturas = new HashSet<Factura>();
            this.Usuarios = new HashSet<Usuario>();
            this.Ventas = new HashSet<Venta>();
        }
    
        public string Documento_Trabajador { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public Nullable<System.DateTime> FechaNacimiento { get; set; }
        public string Teléfono { get; set; }
        public int EmpleadoDetalleID { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EmpleadoCargo> EmpleadoCargoes { get; set; }
        public virtual EmpleadoDetalle EmpleadoDetalle { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Factura> Facturas { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Usuario> Usuarios { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Venta> Ventas { get; set; }
    }
}