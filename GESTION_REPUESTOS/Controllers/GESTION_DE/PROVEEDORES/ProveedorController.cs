using GESTION_REPUESTOS.Clases.Gestion.Distribuidores;
using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GESTION_REPUESTOS.Controllers.GESTION_DE.PROVEEDORES
{
    [RoutePrefix("api/Proveedor")]
    public class ProveedorController : ApiController
    {
        [HttpGet]
        [Route("ConsultarProveedor")]
        public Distribuidore ConsultaProveedor(string Documento)
        {
            ClsDistribucion distribucion = new ClsDistribucion();
            return distribucion.ConsutarProveedor(Documento);
        }
    }
}