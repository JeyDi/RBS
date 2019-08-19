﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RBS.DAL
{
    public partial class Resources
    {
        /// <summary>
        /// Map resource_detail_result to resources
        /// </summary>
        /// <param name="new_resource"></param>
        public Resources(resource_detail_Result new_resource)
        {
            this.name = new_resource.Name;
            this.surname = new_resource.Surname;
            this.email = new_resource.Email;
            this.username = new_resource.Username;
            this.id_resource = new_resource.ID;
            this.insert_date = new_resource.Insert_Date;
            this.update_date = new_resource.Update_Date;
            this.admin = new_resource.Admin;
            this.status = new_resource.Status;
            
        }

        /// <summary>
        /// Map resource_create_result object in result object
        /// </summary>
        /// <param name="new_resource"></param>
        public Resources(resource_create_Result new_resource)
        {
            this.name = new_resource.name;
            this.surname = new_resource.surname;
            this.email = new_resource.email;
            this.username = new_resource.username;
            this.id_resource = new_resource.id_resource;
            this.insert_date = new_resource.insert_date;
            this.update_date = new_resource.update_date;
            this.admin = new_resource.admin;
            this.status = new_resource.status;

        }

        /// <summary>
        /// Extension to Map resource_list_result in resources list
        /// </summary>
        /// <param name="resource_list"></param>
        /// <returns></returns>
        public List<Resources> ConvertList(List<resource_list_Result> resource_list)
        {

            List<Resources> new_list = new List<Resources>();

            foreach (resource_list_Result r in resource_list)
            {
                Resources element = new Resources();
                element.name = r.name;
                element.surname = r.surname;
                element.email = r.email;
                element.username = r.username;
                element.id_resource = r.id_resource;
                element.insert_date = r.insert_date;
                element.update_date = r.update_date;
                element.admin = r.admin;
                element.status = r.status;

                new_list.Add(element);

            }

            return new_list;
        }
    }

    public partial class Buildings
    {
        public Buildings(building_list_Result nb)
        {
            this.id_building = nb.id_building;
            this.name = nb.name;
            this.address = nb.address;
            this.insert_date = nb.insert_date;
            this.update_date = nb.update_date;
            this.status = nb.status;
        }

        public Buildings(building_create_Result nb)
        {
            this.id_building = nb.id_building;
            this.name = nb.name;
            this.address = nb.address;
            this.insert_date = nb.insert_date;
            this.status = nb.status;
            
        }

        public Buildings(building_detail_Result nb)
        {
            this.id_building = nb.id_building;
            this.name = nb.name;
            this.address = nb.address;
            this.insert_date = nb.insert_date;
            this.status = nb.status;
        }

        public List<Buildings> ConvertList(List<building_list_Result> buildings_list)
        {

            List<Buildings> new_list = new List<Buildings>();

            foreach (building_list_Result b in buildings_list)
            {
                Buildings r = new Buildings();
                r.id_building = b.id_building;
                r.name = b.name;
                r.address = b.address;
                r.insert_date = b.insert_date;
                r.status = b.status;

                new_list.Add(r);

            }

            return new_list;
        }
    }


    public partial class Reservations
    {

        public Reservations()
        {

        }

        public Reservations(reservation_create_Result rsv)
        {
            this.id_reservation = rsv.reserv_id;
            this.description = rsv.reserv_description;
            this.start_date = rsv.reserv_start_date;
            this.end_date = rsv.reserv_end_date;
            this.id_resource = rsv.resource_id;
            //this.Resources.name = rsv.resource_name;
            //this.Resources.surname = rsv.resource_surname;
            //this.Resources.username = rsv.resource_username;
            //this.Resources.email = rsv.resource_email;
            this.id_room = rsv.room_id;
            //this.Rooms.name = rsv.room_name;
            //this.Rooms.sittings = rsv.room_sittings;
            //this.Rooms.id_building = rsv.build_id;
            //this.Rooms.Buildings.name = rsv.build_name;

        }


        public Reservations(reservation_list_Result rsv)
        {
            this.id_reservation = rsv.reserv_id;
            this.description = rsv.reserv_description;
            this.start_date = rsv.reserv_start_date;
            this.end_date = rsv.reserv_end_date;
            this.id_resource = rsv.resource_id;
            //this.Resources.name = rsv.resource_name;
            //this.Resources.surname = rsv.resource_surname;
            //this.Resources.username = rsv.resource_username;
            //this.Resources.email = rsv.resource_email;
            this.id_room = rsv.room_id;
            //this.Rooms.name = rsv.room_name;
            //this.Rooms.sittings = rsv.room_sittings;
            //this.Rooms.id_building = rsv.build_id;
            //this.Rooms.Buildings.name = rsv.build_name;

        }

        public List<Reservations> ConvertList(List<reservation_list_Result> rsv_list)
        {

            List<Reservations> new_list = new List<Reservations>();

            foreach (reservation_list_Result rsv in rsv_list)
            {
                
                this.id_reservation = rsv.reserv_id;
                this.description = rsv.reserv_description;
                this.start_date = rsv.reserv_start_date;
                this.end_date = rsv.reserv_end_date;
                this.id_resource = rsv.resource_id;
                //this.Resources.name = rsv.resource_name;
                //this.Resources.surname = rsv.resource_surname;
                //this.Resources.username = rsv.resource_username;
                //this.Resources.email = rsv.resource_email;
                this.id_room = rsv.room_id;
                //this.Rooms.name = rsv.room_name;
                //this.Rooms.sittings = rsv.room_sittings;
                //this.Rooms.id_building = rsv.build_id;
                //this.Rooms.Buildings.name = rsv.build_name;

                new_list.Add(this);

            }

            return new_list;
            
        }

    }


    public partial class Rooms
    {
        public Rooms(room_create_Result nr)
        {
            this.id_room = nr.room_id;
            this.name = nr.room_name;
            this.sittings = nr.room_sittings;
            //this.Buildings.name = nr.build_name;
            this.id_building = nr.build_id;
        }

        public Rooms(room_detail_Result nr)
        {
            this.id_room = nr.room_id;
            this.name = nr.room_name;
            this.sittings = nr.room_sittings;
            //this.Buildings.name = nr.build_name;
            this.id_building = nr.build_id;
        }
            
        public List<Rooms> ConvertList(List<room_list_Result> nr_list)
        {

            List<Rooms> new_list = new List<Rooms>();

            foreach (room_list_Result nr in nr_list)
            {
                Rooms r = new Rooms();

                r.id_room = nr.room_id;
                r.name = nr.room_name;
                r.sittings = nr.room_sittings;
                //r.Buildings.name = nr.build_name;
                r.id_building = nr.build_id;

                new_list.Add(r);

            }

            return new_list;

        }

    }


    //Estensione di prova della Stored Procedure di dettaglio
    public partial class RBSEntities : DbContext
    {
        public virtual ObjectResult<Resources> resource_detail_extended(string name, string surname, string username, string email)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));

            var surnameParameter = surname != null ?
                new ObjectParameter("Surname", surname) :
                new ObjectParameter("Surname", typeof(string));

            var usernameParameter = username != null ?
                new ObjectParameter("Username", username) :
                new ObjectParameter("Username", typeof(string));

            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));

            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Resources>("resource_detail", nameParameter, surnameParameter, usernameParameter, emailParameter);
        }

    }




}
