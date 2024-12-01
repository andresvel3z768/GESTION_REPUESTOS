using GESTION_REPUESTOS.Clases.Gestion.Clientes;
using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GESTION_REPUESTOS.Controllers.GESTION_DE.CLIENTES
{
    [RoutePrefix("api/Cliente")]
    public class ClientesController : ApiController
    {
        [HttpGet]
        [Route("Consulta")]
        public Cliente ConsultarCliente(string Documento)
        {
            ClsCliente cliente = new ClsCliente();
            return cliente.Consultar(Documento);
        }
    }
}