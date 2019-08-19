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


        public IEnumerable<Resources> GetAll_Coded()
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

        public List<Resources> Get_Coded(int? id_resource, string name, string surname, string email, string username)
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

        public bool Add_Coded(string Name, string Surname, string Email, string Username)
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

        /// <summary>
        /// Get all resources info (using stored procedure logic)
        /// </summary>
        /// <returns></returns>
        public List<Resources> GetAll()
        {


            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Resources> resources = SPRepo.SP_Resources_GetAll();

                return resources;

            }
            catch (Exception)
            {
                return null;
            }
          
        }

        /// <summary>
        /// Get Single Resource Detail (using stored procedure logic)
        /// </summary>
        /// <param name="name"></param>
        /// <param name="surname"></param>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public Resources GetDetail(string name, string surname, string username, string email)
        {


            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Resources resources = SPRepo.SP_Resources_Get(name,surname,username,email);


                return resources;

            }
            catch (Exception)
            {
                return null;
            }


        }

        /// <summary>
        /// Insert a new Resource (using stored procedure logic)
        /// </summary>
        /// <param name="name"></param>
        /// <param name="surname"></param>
        /// <param name="admin"></param>
        /// <returns></returns>
        public Resources Insert(string name, string surname, bool admin = false)
        {


            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Resources resource = SPRepo.SP_Resources_Create(name, surname, admin);


                return resource;

            }
            catch (Exception)
            {
                return null;
            }

        }

     

    }
}
