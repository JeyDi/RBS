using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common
{
    public class BLRooms
    {
        /// <summary>
        /// Get all the rooms, it's need the build name to understand in which building need to search
        /// </summary>
        /// <param name="build_name"></param>
        /// <returns></returns>
        public List<Rooms> GetAll(string build_name)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Rooms> rooms = SPRepo.SP_Rooms_GetAll(build_name);

                return rooms;

            }
            catch (Exception)
            {
                return null;
            }

        }

        /// <summary>
        /// Return all the rooms without any filters
        /// </summary>
        /// <returns></returns>
        public List<Rooms> All()
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Rooms> rooms = SPRepo.SP_Rooms_All();

                return rooms;

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
        public Rooms GetDetail(string name)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Rooms room = SPRepo.SP_Rooms_Get(name);
                

                return room;

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
        public Rooms Insert(string name, int sittings, string build_name)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Rooms room = SPRepo.SP_Rooms_Create(name, sittings, build_name);


                return room;

            }
            catch (Exception)
            {
                return null;
            }

        }

        /// <summary>
        /// Delete a room if exist
        /// </summary>
        /// <param name="name"></param>
        /// <param name="address"></param>
        /// <returns></returns>
        public int Delete(string room_name)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                var result = SPRepo.SP_Rooms_Delete(room_name);


                return result;

            }
            catch (Exception)
            {
                return -1;
            }

        }

    }
}
