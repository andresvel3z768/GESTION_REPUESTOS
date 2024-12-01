using GESTION_REPUESTOS.Clases.Gestion.Empleados;
using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GESTION_REPUESTOS.Controllers.GESTION_DE.EMPLEADOS
{
    [RoutePrefix("api/Empleado")]
    public class EmpleadoController : ApiController
    {
        [HttpGet]
        [Route("ConsultarEmpleado")]
        public Empleado consultarEmpleado(string Documento)
        {
            ClsEmpleado empleado = new ClsEmpleado();
            return empleado.consulta(Documento);
        }
    }
}