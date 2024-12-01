using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Compras
{
    public class ClsComprar
    {
        private Gestion_RepuestosEntities Gestion  = new Gestion_RepuestosEntities();
        public Compra comprar {  get; set; }
        public Compra estadoCompra (int CompraID)
        {
            return Gestion.Compras.FirstOrDefault(C => C.CompraID == CompraID);
        }
    }
}