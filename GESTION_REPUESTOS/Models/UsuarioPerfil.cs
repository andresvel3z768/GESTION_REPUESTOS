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
    
    public partial class UsuarioPerfil
    {
        public int UsuarioID { get; set; }
        public int PerfilID { get; set; }
        public bool Activo { get; set; }
    
        public virtual Perfile Perfile { get; set; }
        public virtual Usuario Usuario { get; set; }
    }
}
