using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common.Entities
{
    public class ReservationsVM
    {
        public int id_reservation { get; set; }
        public string @event { get; set; }
        public string description { get; set; }
        public System.DateTime start_date { get; set; }
        public System.DateTime end_date { get; set; }
        public Nullable<System.DateTime> insert_date { get; set; }
        public Nullable<System.DateTime> update_date { get; set; }
        public int id_resource { get; set; }
        public string resource_name { get; set; }
        public string resource_surname { get; set; }
        public string resource_username { get; set; }
        public string resource_email { get; set; }
        public int id_room { get; set; }
        public string room_name { get; set; }
        public int room_sittings { get; set; }
        public int id_building { get; set; }
        public string building_name { get; set; }

        public ReservationsVM()
        {

        }

        public ReservationsVM(Reservations reservations)
        {
            this.id_reservation = reservations.id_reservation;
            this.@event = reservations.@event;
            this.description = reservations.description;
            this.start_date = reservations.start_date;
            this.end_date = reservations.end_date;
            this.insert_date = reservations.insert_date;
            this.update_date = reservations.update_date;
            this.id_resource = reservations.id_resource;
            this.resource_name = reservations.Resources.name;
            this.resource_surname = reservations.Resources.surname;
            this.resource_username = reservations.Resources.username;
            this.resource_email = reservations.Resources.email;
            this.id_room = reservations.id_room;
            this.room_name = reservations.Rooms.name;
            this.room_sittings = reservations.Rooms.sittings;
            this.id_building = reservations.Rooms.Buildings.id_building;
            this.building_name = reservations.Rooms.Buildings.name;
           
        }


        public List<ReservationsVM> CreateList(List<Reservations> input_list)
        {
            List<ReservationsVM> result = new List<ReservationsVM>();
            foreach (Reservations e in input_list)
            {
                ReservationsVM r = new ReservationsVM();
                r.id_reservation = e.id_reservation;
                r.@event = e.@event;
                r.description = e.description;
                r.start_date = e.start_date;
                r.end_date = e.end_date;
                r.insert_date = e.insert_date;
                r.update_date = e.update_date;
                r.id_resource = e.id_resource;
                r.resource_name = e.Resources.name;
                r.resource_surname = e.Resources.surname;
                r.resource_username = e.Resources.username;
                r.resource_email = e.Resources.email;
                r.id_room = e.id_room;
                r.room_name = e.Rooms.name;
                r.room_sittings = e.Rooms.sittings;
                r.id_building = e.Rooms.Buildings.id_building;
                r.building_name = e.Rooms.Buildings.name;

                result.Add(r);
            }

            return result;
        }

    }

    public class ReservationInputVM
    {


        public string event_name { get; set; }
        public string description { get; set; }
        public string username { get; set; }
        public string room { get; set; }
        public string start_date { get; set; }
        public string end_date { get; set; }

    }

}
