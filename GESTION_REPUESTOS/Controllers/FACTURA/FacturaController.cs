using GESTION_REPUESTOS.Clases.Facturacion;
using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GESTION_REPUESTOS.Controllers.FACTURA
{
    [RoutePrefix("api/Factura")]
    public class FacturaController : ApiController
    {
        [HttpGet]
        [Route("ConsultarFactura")]
        public Factura Consultar(int id)
        {
            ClsFacturacion clsFacturacion = new ClsFacturacion();
            return clsFacturacion.ConsultarXCodigo(id);
        }
    }
}