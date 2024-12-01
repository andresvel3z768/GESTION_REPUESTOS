using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Facturacion
{
    public class ClsFacturacion
    {
        private Gestion_RepuestosEntities Gestion = new Gestion_RepuestosEntities();
        public Factura facturacion { get; set; }
        public Factura ConsultarXCodigo(int IdFactura)
        {
            return Gestion.Facturas.FirstOrDefault(F => F.FacturaID == IdFactura);
        }
    }
}