using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            var dbContext = new RBSEntities();
            var resources = dbContext.resource_list();

            
            foreach( var c in resources)
            {
                Console.WriteLine(c.name);
            }

            //LINQ Syntax
            var query =
               from c in dbContext.Resources
               where c.admin == true
               join a in dbContext.Reservations on c.id_resource equals a.id_resource
               select new { Name = c.name, Surname = c.surname, Event = a.@event };
               
            
            foreach(var resource in query.ToList())
            {
                Console.WriteLine(resource.Name + "\t" +resource.Surname + "\t" + resource.Event);
            }

            //Extension methods
            var person = dbContext.Resources.Where(c => c.admin == true).OrderBy(c => c.name).Select(c => new { Name = c.name, Surname = c.surname});

            foreach( var p in person.ToList())
            {
                Console.WriteLine(p.Name + p.Surname);

            }


            Console.ReadKey();
        }
    }
}
