using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Gestion.Empleados
{
    public class ClsEmpleado
    {
        private Gestion_RepuestosEntities Gestion_ = new Gestion_RepuestosEntities();
        public Empleado empleado { get; set; }
        public Empleado consulta (string Documento)
        {
            return Gestion_.Empleados.FirstOrDefault(E => E.Documento_Trabajador == Documento);
        }
    }
}