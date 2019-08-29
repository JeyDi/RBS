using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common
{
    public class BLReservations
    {


        /// <summary>
        /// Get Single Resource Detail (using stored procedure logic)
        /// </summary>
        /// <param name="name"></param>
        /// <param name="surname"></param>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public List<Reservations> GetDetail(String start_date_string, string end_date_string, string username)
        {


            DateTime start_date = DateTime.Parse(start_date_string);
            DateTime end_date = DateTime.Parse(end_date_string);
            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Reservations> reservations = SPRepo.SP_Reservation_Get(start_date,end_date,username);

                return reservations;

            }
            catch (Exception)
            {

                return null;
            }


        }

        /// <summary>
        /// Get all reservations created by a specific user
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public List<Reservations> GetAll(string username)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Reservations> reservations = SPRepo.SP_Reservation_GetAll(username);

                return reservations;

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
        public Reservations Insert(string event_name, string description, string username, string room, string start_date_string, string end_date_string)
        {
            DateTime start_date = DateTime.Parse(start_date_string);
            DateTime end_date = DateTime.Parse(end_date_string);
            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                Reservations reservation = SPRepo.SP_Reservation_Create(event_name, description, username, room, start_date, end_date);

                return reservation;

            }
            catch (Exception)
            {
                return null;
            }

        }

        //TODO
        public int Delete(int id)
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                var result = SPRepo.SP_Reservation_Delete(id);

                return result;

            }
            catch (Exception)
            {
                return -1;
            }

        }

    }
}
