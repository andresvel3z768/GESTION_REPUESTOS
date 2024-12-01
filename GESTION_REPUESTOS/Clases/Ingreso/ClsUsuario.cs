using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Ingreso
{
    public class ClsUsuario
    {
        private Gestion_RepuestosEntities Gestion = new Gestion_RepuestosEntities();
        public Usuario usuario { get; set; }

    }
}