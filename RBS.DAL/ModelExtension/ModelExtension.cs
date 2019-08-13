using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.DAL
{
    public partial class Resources
    {
        public Resources(resource_detail_Result new_resource)
        {
            this.name = new_resource.Name;
            this.surname = new_resource.Surname;
            this.email = new_resource.Email;
            this.username = new_resource.Username;
            this.id_resource = new_resource.ID;
            this.insert_date = new_resource.Insert_Date;
            this.update_date = new_resource.Update_Date;
            this.admin = new_resource.Admin;
            this.status = new_resource.Status;
            
        }
    }


    public partial class RBSEntities : DbContext
    {
        public virtual ObjectResult<Resources> resource_detail_extended(string name, string surname, string username, string email)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));

            var surnameParameter = surname != null ?
                new ObjectParameter("Surname", surname) :
                new ObjectParameter("Surname", typeof(string));

            var usernameParameter = username != null ?
                new ObjectParameter("Username", username) :
                new ObjectParameter("Username", typeof(string));

            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));

            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Resources>("resource_detail", nameParameter, surnameParameter, usernameParameter, emailParameter);
        }

    }




}
