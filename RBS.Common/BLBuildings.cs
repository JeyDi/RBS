using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common
{
    public class BLBuildings
    {

        public List<Buildings> GetAll()
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Buildings> buildings = SPRepo.SP_Buildings_GetAll();

                return buildings;

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
        public Buildings GetDetail(string name)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Buildings building = SPRepo.SP_Buildings_Get(name);


                return building;

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
        public Buildings Insert(string name, string address)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Buildings building = SPRepo.SP_Buildings_Create(name, address);


                return building;

            }
            catch (Exception)
            {
                return null;
            }

        }


        public int Delete(string name, string address)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                int result = SPRepo.SP_Buildings_Delete(name);


                return result;

            }
            catch (Exception)
            {
                return -1;
            }

        }

    }
}
