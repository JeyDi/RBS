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

        // GET api/Resources
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

        // GET api/Resources
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


        // GET api/Resources
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

        [HttpGet]
        [Route("Delete")]
        public IHttpActionResult BuildingDelete()
        {
            try
            {
                BLRooms rooms = new BLRooms();
                var result = rooms.Delete();
                //if (result > 0)
                //{
                //    return Ok();
                //}
                //else
                //{
                //    return NotFound();
                //}
                return Ok(result);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}
