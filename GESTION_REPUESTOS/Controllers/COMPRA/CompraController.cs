using GESTION_REPUESTOS.Clases.Compras;
using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GESTION_REPUESTOS.Controllers.COMPRA
{
    [RoutePrefix("api/compra")]
    public class CompraController : ApiController
    {
        [HttpGet]
        [Route("EstadoCompra")]
        public Compra Estado (int CompraID)
        {
            ClsComprar clsComprar = new ClsComprar();
            return clsComprar.estadoCompra(CompraID);
        }
    }
}