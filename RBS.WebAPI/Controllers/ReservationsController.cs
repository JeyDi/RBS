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


        [HttpPost]
        [Route("Insert/{event_name}/{description}/{username}/{room}/{start_date}/{end_date}")]
        public IHttpActionResult ReservationInsert(string event_name, string description, string username, string room, string start_date, string end_date)
        {
            try
            {
                BLReservations reservations = new BLReservations();
                var reservation = reservations.Insert(event_name, description,username,room,start_date,end_date);

                return Ok(new ReservationsVM(reservation));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }


        [HttpGet]
        [Route("Delete")]
        public IHttpActionResult ReservationDelete()
        {
            try
            {
                BLReservations reservations = new BLReservations();
                var reservation_delete = reservations.Delete();
                //if (building_delete > 0)
                //{
                //    return Ok();
                //}
                //else
                //{
                //    return NotFound();
                //}
                return null;
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }



    }
}
