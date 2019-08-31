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
    [RoutePrefix("api/rooms")]
    public class RoomsController : ApiController
    {

        /// <summary>
        /// Get all the rooms for a building
        /// </summary>
        /// <param name="build_name"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetAll/{build_name}")]
        public IHttpActionResult GetAll(string build_name)
        {
            try
            {

                BLRooms rooms = new BLRooms();
                var room_list = rooms.GetAll(build_name);

                RoomsVM obj = new RoomsVM();
                
                return Ok(obj.CreateList(room_list));

            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

        /// <summary>
        /// Get all the rooms without any filter
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("All")]
        public IHttpActionResult All()
        {
            try
            {

                BLRooms rooms = new BLRooms();
                var room_list = rooms.All();

                RoomsVM obj = new RoomsVM();

                return Ok(obj.CreateList(room_list));

            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

        /// <summary>
        /// Insert a new building
        /// </summary>
        /// <param name="name"></param>
        /// <param name="sittings"></param>
        /// <param name="build_name"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("Insert/{name}/{sittings}/{build_name}")]
        public IHttpActionResult BuildingInsert(string name = null, string sittings = "1", string build_name = null)
        {
            try
            {
                int sittings_number = Int32.Parse(sittings.Trim());
                BLRooms rooms = new BLRooms();
                var room = rooms.Insert(name, sittings_number, build_name);

                return Ok(new RoomsVM(room));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }


        /// <summary>
        /// Get the details of a building searching by name
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("Detail/{name}")]
        public IHttpActionResult BuildingDetail(string name = null)
        {
            try
            {

                BLRooms rooms = new BLRooms();
                var room_detail = rooms.GetDetail(name);


                //Return a ResourceVM Object mapped from Resource
                return Ok(new RoomsVM(room_detail));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }


        /// <summary>
        /// Delete a building
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("Delete/{room_name}")]
        public IHttpActionResult BuildingDelete(string room_name)
        {
            try
            {
                BLRooms rooms = new BLRooms();
                var result = rooms.Delete(room_name);
                //if (result > 0)
                //{
                //    return Ok(result);
                //}
                //else
                //{
                //    return NotFound();
                //}
                return Ok("Build deleted");               
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}
