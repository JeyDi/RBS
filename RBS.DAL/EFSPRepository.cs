using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.DAL
{
    //All Stored Procedure Implementation
    public class EFSPRepository
    {

        private DbContext mContext;

        protected DbContext Context
        {
            get { return mContext ?? (mContext = ((EFUnitOfWork)GlobalUnitOfWork.Current).Context); }
        }

       
        public resource_create_Result InsertStoredValues(string name, string surname, bool? admin)
        {
            var resource = ((RBSEntities)Context).resource_create(name, surname, admin).First();

            //Resources new_resource = new Resources();


            return resource;
            //Usare FirstOfDefault se si vuole gestire l'errore
        }

        public List<resource_list_Result> GetAll()
        {
            //Devi fare tolist perchè altrimenti non materializza subito l'oggetto
            return ((RBSEntities)Context).resource_list().ToList();
        } 


        public List<Resources> GetAll_Different()
        {
            return null;
        }

        //Prova modificando l'oggetto con il get detail resources
        public Resources GetDetail(string name, string surname, string username, string email)
        {

            var resource = ((RBSEntities)Context).resource_detail(name,surname,username,email).First();

            //Trasformo oggetto resource_detail in Resources con il costruttore
            return new Resources(resource);
        }
    }
}
