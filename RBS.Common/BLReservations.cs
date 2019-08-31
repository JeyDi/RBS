using RBS.Common.Entities;
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
        /// Get all the reservation without any filter for the user
        /// </summary>
        /// <returns></returns>
        public List<Reservations> All()
        {

            try
            {
                EFSPRepository SPRepo = new EFSPRepository();
                List<Reservations> reservations = SPRepo.SP_Reservation_All();

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

                if(reservation is null)
                {
                    return null;
                }
                else
                {
                    return reservation;
                }
                

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

        /// <summary>
        /// Check the front-end input date with the dates into database
        /// </summary>
        /// <param name="check"></param>
        /// <returns></returns>
        //public bool checkReservationDate(ReservationInputVM check)
        //{
        //    IEnumerable<ReservationsVM> result = null;
            
        //    try
        //    {
        //        EFRepository<ReservationsVM> reservations = new EFRepository<ReservationsVM>();
        //        result = reservations.GetQuery().Where(x => x.room_name == check.room)
        //                                        .Where(x =>
        //                                              (x.start_date <= DateTime.Parse(check.start_date) && x.end_date > DateTime.Parse(check.start_date)) ||
        //                                              (x.start_date <= DateTime.Parse(check.end_date) && x.end_date > DateTime.Parse(check.end_date)) ||
        //                                              (x.start_date > DateTime.Parse(check.start_date) && x.end_date <= DateTime.Parse(check.end_date))).ToList();
        //    }
        //    catch(Exception)
        //    {
        //        return false;
        //    }
        //    if(result != null && result.Count() != 0)
        //    {
        //        return false;
        //    }
        //    else
        //    {
        //        return true;
        //    }
        //}
        

    }
}
