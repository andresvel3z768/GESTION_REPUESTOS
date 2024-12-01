using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Gestion.Distribuidores
{
    public class ClsDistribucion
    {
        private Gestion_RepuestosEntities Gestion_ = new Gestion_RepuestosEntities();
        public Distribuidore distribuidore { get; set; }
        public Distribuidore ConsutarProveedor(string Documento)
        {
            return Gestion_.Distribuidores.FirstOrDefault(D => D.ProveedorID == Documento);
        }
        public string CrearProveedor(Distribuidore distribuidores)
        {
            try
            {
                Gestion_.Distribuidores.Add(distribuidores);
                Gestion_.SaveChanges();
                return "Se Creo un Proveedor: " + distribuidore.Nombre;
            }
            catch (Exception ex) { return ex.Message; }
        }
        public string ActualizarProveedor(Distribuidore distribuidore)
        {
            try
            {
                Gestion_.Distribuidores.Add(distribuidore);
                Gestion_.SaveChanges();
                return "se Actualizo el Proveedor: " + distribuidore.Nombre;
            }
            catch (Exception ex) { return ex.Message; }
        }
    }
}