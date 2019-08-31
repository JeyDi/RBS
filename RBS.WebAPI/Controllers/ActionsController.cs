using RBS.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Web.Http;

namespace RBS.WebAPI.Controllers
{

    [RoutePrefix("api/actions")]
    public class ActionsController : ApiController
    {

        [HttpPost]
        [Route("SendEmail")]
        public IHttpActionResult SendEmail(Email new_email)
        {

            //All the config are into the Web.config
            var email_user = ConfigurationManager.AppSettings["email_usr"];
            var email_password = ConfigurationManager.AppSettings["email_pw"];
            var email_to = ConfigurationManager.AppSettings["email_to"];
            var stmp_address = ConfigurationManager.AppSettings["stmp_address"];
            var stmp_port = Int32.Parse(ConfigurationManager.AppSettings["stmp_port"]);

            // You should use a using statement
            using (SmtpClient client = new SmtpClient(stmp_address, stmp_port))
            {
                // Configure the client
                client.EnableSsl = true;
                client.Credentials = new NetworkCredential(email_user, email_password);
                // client.UseDefaultCredentials = true;

                // A client has been created, now you need to create a MailMessage object
                MailMessage message = new MailMessage(
                                         email_to, //Need to be the opposite!!! Just for test
                                         new_email.email_from,
                                         new_email.email_object,
                                         new_email.email_text
                                      );

                try
                {
                    client.Send(message);

                    return (Ok("Email has been sent."));
                }
                catch(Exception ex)
                {
                    return InternalServerError(ex);
                }

                

                
            }
        }

    }
}
