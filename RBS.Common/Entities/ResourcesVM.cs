using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common.Entities
{
    public class ResourcesVM
    {
        public int id_resource { get; set; }
        public string name { get; set; }
        public string surname { get; set; }
        public string email { get; set; }
        public bool status { get; set; }
        public bool admin { get; set; }
        public string username { get; set; }
        public Nullable<System.DateTime> insert_date { get; set; }
        public Nullable<System.DateTime> update_date { get; set; }

        public ResourcesVM()
        {

        }

        public ResourcesVM(Resources resource)
        {
            this.id_resource = resource.id_resource;
            this.name = resource.name;
            this.surname = resource.surname;
            this.username = resource.username;
            this.email = resource.email;
            this.status = resource.status;
            this.admin = resource.admin;
            this.insert_date = resource.insert_date;
            this.update_date = resource.update_date;
        }
    }

   
}
