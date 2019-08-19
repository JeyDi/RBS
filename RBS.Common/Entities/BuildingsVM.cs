using RBS.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.Common.Entities
{
    public class BuildingsVM
    {
        public int id_building { get; set; }
        public string name { get; set; }
        public string address { get; set; }
        public bool status { get; set; }
        public Nullable<System.DateTime> insert_date { get; set; }
        public Nullable<System.DateTime> update_date { get; set; }


        public BuildingsVM()
        {

        }

        public BuildingsVM(Buildings buildings)
        {
            this.id_building = buildings.id_building;
            this.name = buildings.name;
            this.address = buildings.address;
            this.status = buildings.status;
            this.insert_date = buildings.insert_date;
            this.update_date = buildings.update_date;


        }

        public List<BuildingsVM> CreateList(List<Buildings> building_list)
        {
            List<BuildingsVM> result = new List<BuildingsVM>();

            

            foreach(Buildings b in building_list)
            {

                BuildingsVM r = new BuildingsVM();
                r.id_building = b.id_building;
                r.name = b.name;
                r.address = b.address;
                r.status = b.status;
                r.insert_date = b.insert_date;
                r.update_date = b.update_date;

                result.Add(r);
            }

            return result;
        }

    }



}
