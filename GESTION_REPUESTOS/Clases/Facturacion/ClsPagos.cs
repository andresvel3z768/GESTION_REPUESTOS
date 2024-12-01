using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Facturacion
{
    public class ClsPagos
    {
        private Gestion_RepuestosEntities Gestion = new Gestion_RepuestosEntities();
        public Pago pago { get; set; }
        public Pago ConsultarPagos(int IdPago)
        {
            return Gestion.Pagos.FirstOrDefault(P => P.PagoID == IdPago);
        }
    }
}