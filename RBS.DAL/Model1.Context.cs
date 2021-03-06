﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace RBS.DAL
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class RBSEntities : DbContext
    {
        public RBSEntities()
            : base("name=RBSEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Buildings> Buildings { get; set; }
        public virtual DbSet<Resources> Resources { get; set; }
        public virtual DbSet<Rooms> Rooms { get; set; }
        public virtual DbSet<Reservations> Reservations { get; set; }
    
        [DbFunction("RBSEntities", "udf_reservation_search")]
        public virtual IQueryable<udf_reservation_search_Result> udf_reservation_search(Nullable<System.DateTime> start_date, Nullable<System.DateTime> end_date)
        {
            var start_dateParameter = start_date.HasValue ?
                new ObjectParameter("Start_date", start_date) :
                new ObjectParameter("Start_date", typeof(System.DateTime));
    
            var end_dateParameter = end_date.HasValue ?
                new ObjectParameter("End_date", end_date) :
                new ObjectParameter("End_date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<udf_reservation_search_Result>("[RBSEntities].[udf_reservation_search](@Start_date, @End_date)", start_dateParameter, end_dateParameter);
        }
    
        [DbFunction("RBSEntities", "udf_reservation_search_byUser")]
        public virtual IQueryable<udf_reservation_search_byUser_Result> udf_reservation_search_byUser(Nullable<System.DateTime> start_date, Nullable<System.DateTime> end_date, Nullable<int> resource_ID)
        {
            var start_dateParameter = start_date.HasValue ?
                new ObjectParameter("Start_date", start_date) :
                new ObjectParameter("Start_date", typeof(System.DateTime));
    
            var end_dateParameter = end_date.HasValue ?
                new ObjectParameter("End_date", end_date) :
                new ObjectParameter("End_date", typeof(System.DateTime));
    
            var resource_IDParameter = resource_ID.HasValue ?
                new ObjectParameter("Resource_ID", resource_ID) :
                new ObjectParameter("Resource_ID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<udf_reservation_search_byUser_Result>("[RBSEntities].[udf_reservation_search_byUser](@Start_date, @End_date, @Resource_ID)", start_dateParameter, end_dateParameter, resource_IDParameter);
        }
    
        [DbFunction("RBSEntities", "udf_reservation_search_count")]
        public virtual IQueryable<udf_reservation_search_count_Result> udf_reservation_search_count(Nullable<System.DateTime> start_date, Nullable<System.DateTime> end_date)
        {
            var start_dateParameter = start_date.HasValue ?
                new ObjectParameter("Start_date", start_date) :
                new ObjectParameter("Start_date", typeof(System.DateTime));
    
            var end_dateParameter = end_date.HasValue ?
                new ObjectParameter("End_date", end_date) :
                new ObjectParameter("End_date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<udf_reservation_search_count_Result>("[RBSEntities].[udf_reservation_search_count](@Start_date, @End_date)", start_dateParameter, end_dateParameter);
        }
    
        public virtual int building_getID(string name)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("building_getID", nameParameter);
        }
    
        public virtual int check_names(string name, string surname, string table)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var surnameParameter = surname != null ?
                new ObjectParameter("Surname", surname) :
                new ObjectParameter("Surname", typeof(string));
    
            var tableParameter = table != null ?
                new ObjectParameter("Table", table) :
                new ObjectParameter("Table", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("check_names", nameParameter, surnameParameter, tableParameter);
        }
    
        public virtual int reservation_delete_single(Nullable<System.DateTime> date, string username)
        {
            var dateParameter = date.HasValue ?
                new ObjectParameter("Date", date) :
                new ObjectParameter("Date", typeof(System.DateTime));
    
            var usernameParameter = username != null ?
                new ObjectParameter("Username", username) :
                new ObjectParameter("Username", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("reservation_delete_single", dateParameter, usernameParameter);
        }
    
        public virtual int reservation_duplicates(Nullable<int> building, Nullable<int> room, Nullable<System.DateTime> start_date, Nullable<System.DateTime> end_date)
        {
            var buildingParameter = building.HasValue ?
                new ObjectParameter("Building", building) :
                new ObjectParameter("Building", typeof(int));
    
            var roomParameter = room.HasValue ?
                new ObjectParameter("Room", room) :
                new ObjectParameter("Room", typeof(int));
    
            var start_dateParameter = start_date.HasValue ?
                new ObjectParameter("Start_date", start_date) :
                new ObjectParameter("Start_date", typeof(System.DateTime));
    
            var end_dateParameter = end_date.HasValue ?
                new ObjectParameter("End_date", end_date) :
                new ObjectParameter("End_date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("reservation_duplicates", buildingParameter, roomParameter, start_dateParameter, end_dateParameter);
        }
    
        public virtual int reservation_getID(Nullable<System.DateTime> date, string resource_username)
        {
            var dateParameter = date.HasValue ?
                new ObjectParameter("Date", date) :
                new ObjectParameter("Date", typeof(System.DateTime));
    
            var resource_usernameParameter = resource_username != null ?
                new ObjectParameter("Resource_username", resource_username) :
                new ObjectParameter("Resource_username", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("reservation_getID", dateParameter, resource_usernameParameter);
        }
    
        public virtual int resource_getID(string name, string surname, string username, string email)
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
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("resource_getID", nameParameter, surnameParameter, usernameParameter, emailParameter);
        }
    
        public virtual int resource_getUsername(string name, string surname, string email)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var surnameParameter = surname != null ?
                new ObjectParameter("Surname", surname) :
                new ObjectParameter("Surname", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("resource_getUsername", nameParameter, surnameParameter, emailParameter);
        }
    
        public virtual int room_getID(string name)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("room_getID", nameParameter);
        }
    
        public virtual ObjectResult<resource_create_Result> resource_create(string name, string surname, Nullable<bool> admin)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var surnameParameter = surname != null ?
                new ObjectParameter("Surname", surname) :
                new ObjectParameter("Surname", typeof(string));
    
            var adminParameter = admin.HasValue ?
                new ObjectParameter("Admin", admin) :
                new ObjectParameter("Admin", typeof(bool));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<resource_create_Result>("resource_create", nameParameter, surnameParameter, adminParameter);
        }
    
        public virtual ObjectResult<resource_detail_Result> resource_detail(string name, string surname, string username, string email)
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
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<resource_detail_Result>("resource_detail", nameParameter, surnameParameter, usernameParameter, emailParameter);
        }
    
        public virtual ObjectResult<resource_list_Result> resource_list()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<resource_list_Result>("resource_list");
        }
    
        public virtual ObjectResult<room_create_Result> room_create(string name, Nullable<int> sittings, string building_Name)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var sittingsParameter = sittings.HasValue ?
                new ObjectParameter("Sittings", sittings) :
                new ObjectParameter("Sittings", typeof(int));
    
            var building_NameParameter = building_Name != null ?
                new ObjectParameter("Building_Name", building_Name) :
                new ObjectParameter("Building_Name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<room_create_Result>("room_create", nameParameter, sittingsParameter, building_NameParameter);
        }
    
        public virtual ObjectResult<room_detail_Result> room_detail(string roomName)
        {
            var roomNameParameter = roomName != null ?
                new ObjectParameter("RoomName", roomName) :
                new ObjectParameter("RoomName", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<room_detail_Result>("room_detail", roomNameParameter);
        }
    
        public virtual ObjectResult<building_create_Result> building_create(string name, string address)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var addressParameter = address != null ?
                new ObjectParameter("Address", address) :
                new ObjectParameter("Address", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<building_create_Result>("building_create", nameParameter, addressParameter);
        }
    
        public virtual int building_delete(string name)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("building_delete", nameParameter);
        }
    
        public virtual ObjectResult<building_detail_Result> building_detail(string name)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<building_detail_Result>("building_detail", nameParameter);
        }
    
        public virtual ObjectResult<building_list_Result> building_list()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<building_list_Result>("building_list");
        }
    
        public virtual ObjectResult<reservation_create_Result> reservation_create(string @event, string description, string resource_username, string room_name, Nullable<System.DateTime> start_date, Nullable<System.DateTime> end_date)
        {
            var eventParameter = @event != null ?
                new ObjectParameter("Event", @event) :
                new ObjectParameter("Event", typeof(string));
    
            var descriptionParameter = description != null ?
                new ObjectParameter("Description", description) :
                new ObjectParameter("Description", typeof(string));
    
            var resource_usernameParameter = resource_username != null ?
                new ObjectParameter("Resource_username", resource_username) :
                new ObjectParameter("Resource_username", typeof(string));
    
            var room_nameParameter = room_name != null ?
                new ObjectParameter("Room_name", room_name) :
                new ObjectParameter("Room_name", typeof(string));
    
            var start_dateParameter = start_date.HasValue ?
                new ObjectParameter("Start_date", start_date) :
                new ObjectParameter("Start_date", typeof(System.DateTime));
    
            var end_dateParameter = end_date.HasValue ?
                new ObjectParameter("End_date", end_date) :
                new ObjectParameter("End_date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<reservation_create_Result>("reservation_create", eventParameter, descriptionParameter, resource_usernameParameter, room_nameParameter, start_dateParameter, end_dateParameter);
        }
    
        public virtual ObjectResult<reservation_list_Result> reservation_list(Nullable<System.DateTime> start_Date, Nullable<System.DateTime> end_Date, string resource_username)
        {
            var start_DateParameter = start_Date.HasValue ?
                new ObjectParameter("Start_Date", start_Date) :
                new ObjectParameter("Start_Date", typeof(System.DateTime));
    
            var end_DateParameter = end_Date.HasValue ?
                new ObjectParameter("End_Date", end_Date) :
                new ObjectParameter("End_Date", typeof(System.DateTime));
    
            var resource_usernameParameter = resource_username != null ?
                new ObjectParameter("Resource_username", resource_username) :
                new ObjectParameter("Resource_username", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<reservation_list_Result>("reservation_list", start_DateParameter, end_DateParameter, resource_usernameParameter);
        }
    
        public virtual ObjectResult<room_list_Result> room_list(string building_name)
        {
            var building_nameParameter = building_name != null ?
                new ObjectParameter("Building_name", building_name) :
                new ObjectParameter("Building_name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<room_list_Result>("room_list", building_nameParameter);
        }
    
        public virtual ObjectResult<reservation_all_Result> reservation_all(string resource_username)
        {
            var resource_usernameParameter = resource_username != null ?
                new ObjectParameter("Resource_username", resource_username) :
                new ObjectParameter("Resource_username", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<reservation_all_Result>("reservation_all", resource_usernameParameter);
        }
    
        public virtual ObjectResult<reservation_all_unfiltered_Result> reservation_all_unfiltered()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<reservation_all_unfiltered_Result>("reservation_all_unfiltered");
        }
    
        public virtual ObjectResult<room_all_Result> room_all()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<room_all_Result>("room_all");
        }
    
        public virtual int room_delete(string name)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("room_delete", nameParameter);
        }
    
        public virtual int reservation_delete(Nullable<int> identifier)
        {
            var identifierParameter = identifier.HasValue ?
                new ObjectParameter("Identifier", identifier) :
                new ObjectParameter("Identifier", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("reservation_delete", identifierParameter);
        }
    
        public virtual int resource_delete(string name, string surname, string username, string email)
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
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("resource_delete", nameParameter, surnameParameter, usernameParameter, emailParameter);
        }
    }
}
