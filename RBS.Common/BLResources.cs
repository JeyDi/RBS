using RBS.Common.Entities;
using RBS.DAL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common
{
    public class BLResources
    {


        public IEnumerable<Resources> GetAll()
        {
            //List<Resources> list_resource = new List<Resources>();

            try
            {
                EFRepository<Resources> ResourceRepo = new EFRepository<Resources>();
                IEnumerable<Resources> resources = ResourceRepo.GetAll();
                //DAL.GlobalUnitOfWork.Commit();
                //foreach (Resources element in resources)
                //{
                //    list_resource.Add(element);
                //}
                return resources;

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public List<Resources> Get(int? id_resource, string name, string surname, string email, string username)
        {

            //TODO
            List<Resources> list_resource = new List<Resources>();

            try
            {
                EFRepository<Resources> ResourceRepo = new EFRepository<Resources>();
                IEnumerable<Resources> resources = ResourceRepo.GetAll();
                //DAL.GlobalUnitOfWork.Commit();
                foreach (Resources element in resources)
                {
                    list_resource.Add(element);
                }
                return list_resource;

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public bool Add(string Name, string Surname, string Email, string Username)
        {
            Resources new_resource = new Resources()
            {
                name = Name,
                surname = Surname,
                email = Email,
                username = Username


            };

            try
            {
                EFRepository<Resources> ResourceRepo = new EFRepository<Resources>();
                ResourceRepo.Add(new_resource);
                DAL.GlobalUnitOfWork.Commit();

                return true;

            }
            catch (Exception)
            {
                return false;
            }
        }

        public IEnumerable<resource_list_Result> GetAllStored()
        {


            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                IEnumerable<resource_list_Result> resources = SPRepo.GetAll();


                return resources;

            }
            catch (Exception)
            {
                return null;
            }
            //try
            //{

            //    //DAL.GlobalUnitOfWork.Commit();
            //    //foreach (Resources element in resources)
            //    //{
            //    //    list_resource.Add(element);
            //    //}
            //    return resources;
            //    //using (PercorsiCircolariDB_v2Entities1 db_context = new PercorsiCircolariDB_v2Entities1())
            //    //{
            //    //    List<Risorsa> result = db_context.GetRisorse(null, null, null, null, null, null).Select(x => new PercorsiManagerApp.Common.Entities.Risorsa
            //    //    {
            //    //        Id = x.Id,
            //    //        UserName = x.Username,
            //    //        Nome = x.Nome,
            //    //        Cognome = x.Cognome,
            //    //        FlagDisponibile = x.FlagDisponibile
            //    //    }).ToList();
            //    //    return result;
            //    //}
            //}
            //catch (Exception ex)
            //{
            //    return null;
            //}
        }


        public Resources GetResourceDetail(string name, string surname, string username, string email)
        {


            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Resources resources = SPRepo.GetDetail(name,surname,username,email);


                return resources;

            }
            catch (Exception)
            {
                return null;
            }


        }

    }
}
