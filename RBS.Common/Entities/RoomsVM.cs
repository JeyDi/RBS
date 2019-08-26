using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common.Entities
{
    public class RoomsVM
    {
        public int id_room { get; set; }
        public string name { get; set; }
        public int sittings { get; set; }
        public Nullable<System.DateTime> insert_date { get; set; }
        public Nullable<System.DateTime> update_date { get; set; }
        public int id_building { get; set; }

        public string building_name { get; set; }

        public RoomsVM()
        {

        }


        public RoomsVM(Rooms rooms)
        {
            this.id_room = rooms.id_room;
            this.name = rooms.name;
            this.sittings = rooms.sittings;
            this.insert_date = rooms.insert_date;
            this.update_date = rooms.update_date;
            this.id_building = rooms.id_building;
            this.building_name = rooms.Buildings.name;
        }

        public List<RoomsVM> CreateList(List<Rooms> input_list)
        {
            List<RoomsVM> result = new List<RoomsVM>();
            foreach (Rooms e in input_list)
            {
                RoomsVM r = new RoomsVM();
                r.id_room = e.id_room;
                r.name = e.name;
                r.sittings = e.sittings;
                r.insert_date = e.insert_date;
                r.update_date = e.update_date;
                r.id_building = e.id_building;
                r.building_name = e.Buildings.name;
                result.Add(r);
            }

            return result;
        }

    }
   
}
