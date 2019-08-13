using RBS.Common;
using RBS.Common.Entities;
using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace RBS.WebAPI.Controllers
{
    [RoutePrefix("api/resources")]
    public class ResourcesController : ApiController
    {
        // GET api/Resources
        [HttpGet]
        [Route("GetAll")]
        public async Task<IHttpActionResult> GetAll()
        {
            try
            {
                //using (var dbContext = new RBSEntities())
                //{
                //    var resources = dbContext.resource_list();
                //    return Ok(resources.ToList());
                //};

                //ResourceManager BL = new ResourceManager();
                //List<Resource> result = BL.GetResources();
                //return Ok(result);


                //Dispose to close connection
                //dbContext.Dispose(); //not useful because using the using

                BLResources mng = new BLResources();
                IEnumerable<Resources> resource = mng.GetAll();

                List<ResourcesVM> resources_list = new List<ResourcesVM>();

                foreach(Resources es in resource)
                {
                    ResourcesVM rs = new ResourcesVM() {
                        id_resource = es.id_resource
                        , name = es.name
                        , surname = es.surname
                        , email = es.email
                        , username = es.username
                        , admin = es.admin
                        , status = es.status
                        , insert_date = es.insert_date
                        , update_date = es.update_date
                    };

                    resources_list.Add(rs);
                }
                return Ok(resources_list);
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }


        // GET api/Resources
        [HttpGet]
        [Route("GetAllStored")]
        public IHttpActionResult GetAllStored()
        {
            try
            {

                BLResources resource = new BLResources();
                var resource_list = resource.GetAllStored();

                return Ok(resource_list);

                //using (var dbContext = new RBSEntities())
                //{
                //    var resources = dbContext.resource_list();
                //    return Ok(resources.ToList());
                //};

                //ResourceManager BL = new ResourceManager();
                //List<Resource> result = BL.GetResources();
                //return Ok(result);


                //Dispose to close connection
                //dbContext.Dispose(); //not useful because using the using

                //BLResources mng = new BLResources();
                //IEnumerable<resource_list_Result> resource = mng.GetAllStored();

                //List<ResourcesVM> resources_list = new List<ResourcesVM>();

                //foreach (resource_list_Result es in resource)
                //{
                //    ResourcesVM rs = new ResourcesVM()
                //    {
                //        id_resource = es.ID
                //        ,
                //        name = es.Name
                //        ,
                //        surname = es.Surname
                //        ,
                //        email = es.Email
                //        ,
                //        username = es.Username
                //        ,
                //        admin = es.Admin
                //        ,
                //        status = es.Status
                //        ,
                //        insert_date = null
                //        ,
                //        update_date = null
                //    };

                //    resources_list.Add(rs);
                //}
                //return Ok(resources_list);
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

        // GET api/Resources
        [HttpGet]
        [Route("Get")]
        public async Task<IHttpActionResult> Get(string name, string surname, string username, string email)
        {
            try
            {
                var dbContext = new RBSEntities();
                var resources = dbContext.resource_list();

                return Ok(resources);
            }

            catch (Exception)
            {
                throw;

            }

        }


        // GET api/Resources
        [HttpGet]
        [Route("Detail")]
        public async Task<IHttpActionResult> ResourceDetail(string name = null, string surname = null, string username = null, string email = null)
        {
            try
            {

                BLResources resource = new BLResources();
                var resource_detail = resource.GetResourceDetail(name,surname,username,email);

                
                //Return a ResourceVM Object mapped from Resource
                return Ok(new ResourcesVM(resource_detail));
            }

            catch (Exception)
            {
                throw;

            }

        }

    }
}
