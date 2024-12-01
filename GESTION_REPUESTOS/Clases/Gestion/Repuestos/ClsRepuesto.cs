using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Gestion.Repuestos
{
    public class ClsRepuesto
    {
        private Gestion_RepuestosEntities Gestion = new Gestion_RepuestosEntities();
        public Repuesto Repuesto { get; set; }

        public Repuesto ConsultarRepuesto (int id)
        {
            return Gestion.Repuestos.FirstOrDefault(R => R.RepuestoID == id);
        }
    }
}