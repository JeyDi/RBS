//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Reservations
    {
        public int id_reservation { get; set; }
        public string @event { get; set; }
        public string description { get; set; }
        public System.DateTime start_date { get; set; }
        public System.DateTime end_date { get; set; }
        public Nullable<System.DateTime> insert_date { get; set; }
        public Nullable<System.DateTime> update_date { get; set; }
        public int id_resource { get; set; }
        public int id_room { get; set; }
    
        public virtual Resources Resources { get; set; }
        public virtual Resources Resources1 { get; set; }
        public virtual Rooms Rooms { get; set; }
        public virtual Rooms Rooms1 { get; set; }
    }
}
