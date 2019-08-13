CREATE TABLE df.Reservations (

	id_reservation INT PRIMARY KEY IDENTITY (1, 1),
	[event] varchar(50) not null,
	[description] varchar(max) null,
	[start_date] datetime2 not null,
	[end_date] datetime2 not null,
	[insert_date] datetime2 null default getdate(),
	[update_date] datetime2 null,
	id_resource int not null,
	id_room int not null
	FOREIGN KEY (id_resource) REFERENCES df.Resources (id_resource),
	FOREIGN KEY (id_room) REFERENCES df.Rooms (id_room)
	
);