using RBS.Common;
using RBS.Common.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace RBS.WebAPI.Controllers
{
    [RoutePrefix("api/reservations")]
    public class ReservationsController : ApiController
    {

        /// <summary>
        /// Get a reservation details (search function)
        /// </summary>
        /// <param name="start_date"></param>
        /// <param name="end_date"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("Detail/{start_date}/{end_date}/{username}")]
        public IHttpActionResult ReservationDetail(string start_date, string end_date, string username)
        {
            try
            {

                BLReservations reservations = new BLReservations();
                var reservation_list = reservations.GetDetail(start_date, end_date, username);

                ReservationsVM obj = new ReservationsVM();

                return Ok(obj.CreateList(reservation_list));


            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

        /// <summary>
        /// Get all the reservation for an user
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAll/{username}")]
        public IHttpActionResult ReservationList(string username)
        {
            try
            {

                BLReservations reservations = new BLReservations();
                var reservation_list = reservations.GetAll(username);

                ReservationsVM obj = new ReservationsVM();

                return Ok(obj.CreateList(reservation_list));

            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }


        /// <summary>
        /// Get all the reservations without any filters
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("All")]
        public IHttpActionResult AllReservations()
        {
            try
            {

                BLReservations reservations = new BLReservations();
                var reservation_list = reservations.All();

                ReservationsVM obj = new ReservationsVM();

                return Ok(obj.CreateList(reservation_list));

            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

        /// <summary>
        /// Insert and create a new reservation
        /// </summary>
        /// <param name="event_name"></param>
        /// <param name="description"></param>
        /// <param name="username"></param>
        /// <param name="room"></param>
        /// <param name="start_date"></param>
        /// <param name="end_date"></param>
        /// <returns></returns>
        //[HttpPost]
        //[Route("Insert/{event_name}/{description}/{username}/{room}/{start_date}/{end_date}")]
        //public IHttpActionResult ReservationInsert(string event_name, string description, string username, string room, string start_date, string end_date)
        //{
        //    try
        //    {
        //        BLReservations reservations = new BLReservations();
        //        var reservation = reservations.Insert(event_name, description,username,room,start_date,end_date);

        //        return Ok(new ReservationsVM(reservation));
        //    }

        //    catch (Exception ex)
        //    {
        //        return InternalServerError(ex);

        //    }

        //}

        [HttpPost]
        [Route("Insert")]
        public IHttpActionResult ReservationInsert(ReservationInputVM input)
        {
            try
            {
                BLReservations reservations = new BLReservations();

                //if (!reservations.checkReservationDate(input))
                //{
                //    return Content(HttpStatusCode.BadRequest, "Slot non disponibile, cambia la tua data");
                //}
                //else
                //{
                //    var reservation = reservations.Insert(input.event_name, input.description, input.username, input.room, input.start_date, input.end_date);
                //    return Ok(new ReservationsVM(reservation));
                //}

                var reservation = reservations.Insert(input.event_name, input.description, input.username, input.room, input.start_date, input.end_date);
                return Ok(new ReservationsVM(reservation));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }

        /// <summary>
        /// Delete a single reservation using the id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("Delete/{id}")]
        public IHttpActionResult ReservationDelete(string id)
        {
            try
            {

                int reservation_id = Int32.Parse(id);
                BLReservations reservations = new BLReservations();
                var reservation_delete = reservations.Delete(reservation_id);

                //if (reservation_delete > 0)
                //{
                //    return Ok(reservation_id);
                //}
                //else
                //{
                //    return NotFound();
                //}

                return Ok("Reservation deleted");
               
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }



    }
}
