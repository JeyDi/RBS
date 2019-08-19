using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.DAL
{
    /// <summary>
    /// All Stored procedure implementation and mappings from Entity Framework
    /// </summary>
    public class EFSPRepository
    {

        private DbContext mContext;

        protected DbContext Context
        {
            get { return mContext ?? (mContext = ((EFUnitOfWork)GlobalUnitOfWork.Current).Context); }
        }

       /// <summary>
       /// Insert a new resource (person) in the database
       /// </summary>
       /// <param name="name"></param>
       /// <param name="surname"></param>
       /// <param name="admin"></param>
       /// <returns></returns>
        public Resources SP_Resources_Create(string name, string surname, bool? admin)
        {

            //Usare FirstOfDefault se si vuole gestire l'errore
            var resource = ((RBSEntities)Context).resource_create(name, surname, admin).First();

            //Resources new_resource = new Resources();

            //Trasformo oggetto in risorsa grazie al costruttore in: Model Extension
            return new Resources(resource);
            
        }

        /// <summary>
        /// Get all resources in the database
        /// </summary>
        /// <returns></returns>
        public List<Resources> SP_Resources_GetAll()
        {
            //Devi fare tolist perchè altrimenti non materializza subito l'oggetto
            var resource_list = ((RBSEntities)Context).resource_list().ToList();

            Resources resources = new Resources();
            List<Resources> resource_list_converted = new List<Resources>();

            resource_list_converted = resources.ConvertList(resource_list);

            return resource_list_converted;
        } 


        /// <summary>
        /// Get all resources (mock custom object) - not used anymore
        /// </summary>
        /// <returns></returns>
        public List<Resources> SP_Resources_GetAll_Mock()
        {
            return null;
        }

        /// <summary>
        /// Get detail from a single resource
        /// </summary>
        /// <param name="name"></param>
        /// <param name="surname"></param>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public Resources SP_Resources_Get(string name, string surname, string username, string email)
        {

            var resource = ((RBSEntities)Context).resource_detail(name,surname,username,email).First();

            //Trasformo oggetto resource_detail in Resources con il costruttore in: Model Extension
            return new Resources(resource);
        }

        //TODO
        public Resources SP_Resources_Delete()
        {
            return null;
        }

        //TODO
        public Resources SP_Resources_Update()
        {
            return null;
        }

        
        public List<Buildings> SP_Buildings_GetAll()
        {
            var building = ((RBSEntities)Context).building_list().ToList();

            Buildings buildings = new Buildings();
            var building_list = buildings.ConvertList(building);

            return building_list;
        }

        public Buildings SP_Buildings_Create(string name, string address)
        {
            //Usare FirstOfDefault se si vuole gestire l'errore
            var building = ((RBSEntities)Context).building_create(name, address).First();

            //Resources new_resource = new Resources();

            //Trasformo oggetto in risorsa grazie al costruttore in: Model Extension
            return new Buildings(building);
        }

        public Buildings SP_Buildings_Get(string name)
        {
            var building = ((RBSEntities)Context).building_detail(name).First();

            return new Buildings(building);
        }

        public int SP_Buildings_Delete(string name)
        {
            //The result of the deletion is an int = 1 if succeded, -1 not
            var result = ((RBSEntities)Context).building_delete(name);

            return result;
        }
        
        //TODO
        public Buildings SP_Buildings_Update()
        {
            return null;
        }


        public List<Rooms> SP_Rooms_GetAll(string build_name)
        {
            var rooms = ((RBSEntities)Context).room_list(build_name).ToList();

            Rooms room_obj = new Rooms();
            var room_list = room_obj.ConvertList(rooms);

            return room_list;
        }

        public Rooms SP_Rooms_Create(string name, int sittings, string build_name)
        {
            //Usare FirstOfDefault se si vuole gestire l'errore
            var room = ((RBSEntities)Context).room_create(name, sittings, build_name).First();

            //Resources new_resource = new Resources();

            //Trasformo oggetto in risorsa grazie al costruttore in: Model Extension
            return new Rooms(room);
        }

        public Rooms SP_Rooms_Get(string room_name)
        {
            var room = ((RBSEntities)Context).room_detail(room_name).First();

            return new Rooms(room);
        }

        
        //TODO
        public Rooms SP_Rooms_Delete()
        {
            return null;
        }

        public List<Reservations> SP_Reservation_Get(DateTime start_date, DateTime end_date, string username)
        {
            var reservations = ((RBSEntities)Context).reservation_list(start_date,end_date,username).ToList();

            Reservations reservation_obj = new Reservations();
            var reservation_list = reservation_obj.ConvertList(reservations);

            return reservation_list;
        }

        public Reservations SP_Reservation_Create(string event_name, string description, string username, string room, DateTime start_date, DateTime end_date)
        {
            //Usare FirstOfDefault se si vuole gestire l'errore
            var reservations = ((RBSEntities)Context).reservation_create(event_name,description,username, room, start_date, end_date).First();

            //Resources new_resource = new Resources();

            //Trasformo oggetto in risorsa grazie al costruttore in: Model Extension
            return new Reservations(reservations);
        }

        //TODO
        public Reservations SP_Reservation_Update()
        {
            return null;
        }

        
        //TODO
        public Reservations SP_Reservation_Delete()
        {


            return null;
        }



    }
}
