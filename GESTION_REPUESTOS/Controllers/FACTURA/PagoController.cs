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
    [RoutePrefix("api/Pagos")]
    public class PagoController : ApiController
    {
        [HttpGet]
        [Route("EstadoDePago")]
        public Pago Consulta(int Id) 
        {
            ClsPagos clsPagos = new ClsPagos();
            return clsPagos.ConsultarPagos(Id);
        }
    }
}