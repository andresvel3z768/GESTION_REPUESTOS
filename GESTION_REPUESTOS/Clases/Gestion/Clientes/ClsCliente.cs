using GESTION_REPUESTOS.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;

namespace GESTION_REPUESTOS.Clases.Gestion.Clientes
{
    public class ClsCliente
    {
        private Gestion_RepuestosEntities Gestion_ = new Gestion_RepuestosEntities();
        public Cliente cliente { get; set; }

        public Cliente Consultar(string Documento)
        {
            return Gestion_.Clientes.FirstOrDefault(C => C.Documento_Cliente.Equals(Documento));
        }
        public string CrearCliente(Cliente cliente)
        {
            try
            {
                Gestion_.Clientes.Add(cliente);
                Gestion_.SaveChanges();
                return "se creo un nuevo cliente en la base de datos";
            }
            catch (Exception ex) { return ex.Message; }
        }
        public string ActualizarCliente(Cliente cliente)
        {
            try
            {
                Gestion_.Clientes.AddOrUpdate(cliente);
                Gestion_.SaveChanges();
                return "se Actualizo un cliente que es " + cliente.NombreCliente;
            }
            catch (Exception ex) { return ex.Message; };
        }
    }
}