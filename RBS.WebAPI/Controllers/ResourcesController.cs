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
        [Route("GetAllCoded")]
        public IHttpActionResult GetAll_Coded()
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
                IEnumerable<Resources> resource = mng.GetAll_Coded();

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
        [Route("GetAll")]
        public IHttpActionResult GetAll()
        {
            try
            {

                BLResources resource = new BLResources();
                var resource_list = resource.GetAll();

                ResourcesVM obj = new ResourcesVM();

                return Ok(obj.CreateList(resource_list));
               
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);
            }

        }

        // GET api/Resources
        [HttpPost]
        [Route("Insert")]
        public IHttpActionResult ResultInsert(string name = null, string surname = null, bool admin = false)
        {
            try
            {
                BLResources resources = new BLResources();
                var resource = resources.Insert(name, surname, admin);

                return Ok(new ResourcesVM(resource));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }


        // GET api/Resources
        [HttpGet]
        [Route("Detail")]
        public IHttpActionResult ResourceDetail(string name = null, string surname = null, string username = null, string email = null)
        {
            try
            {

                BLResources resource = new BLResources();
                var resource_detail = resource.GetDetail(name,surname,username,email);

                
                //Return a ResourceVM Object mapped from Resource
                return Ok(new ResourcesVM(resource_detail));
            }

            catch (Exception ex)
            {
                return InternalServerError(ex);

            }

        }

    }
}
