﻿using RBS.Common;
using RBS.Common.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace RBS.WebAPI.Controllers
{
    [RoutePrefix("api/buildings")]
    public class BuildingsController : ApiController
    {
    
        [HttpGet]
        [Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            try
            {

                BLBuildings buildings = new BLBuildings();
                var buildings_list = buildings.GetAll();

                BuildingsVM obj = new BuildingsVM();

                return Ok(obj.CreateList(buildings_list));


            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

       
        [HttpPost]
        [Route("Insert/{name}/{address}")]
        public IHttpActionResult BuildingInsert(string name = null, string address = null)
        {
            try
            {
                BLBuildings buildings = new BLBuildings();
                var building = buildings.Insert(name, address);
                
                return Ok(new BuildingsVM(building));
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

                BLBuildings buildings = new BLBuildings();
                var building_detail = buildings.GetDetail(name);


                //Return a ResourceVM Object mapped from Resource
                return Ok(new BuildingsVM(building_detail));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }

        [HttpGet]
        [Route("Delete/{name}")]
        public IHttpActionResult BuildingDelete(string name)
        {
            try
            {
                BLBuildings buildings = new BLBuildings();
                var result = buildings.Delete(name);
                //if(result > 0)
                //{
                //    return Ok(result);
                //}
                //else
                //{
                //    return NotFound();
                //}
                return Ok("Building deleted");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

    }
}
