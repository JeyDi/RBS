CREATE TABLE df.Rooms(
	id_room INT PRIMARY KEY IDENTITY (1, 1),
	[name] varchar(50) not null,
	[sittings] int not null,
	[insert_date] datetime2 null default getdate(),
	[update_date] datetime2 null,
	id_building int not null,
	FOREIGN KEY (id_building) REFERENCES df.Buildings (id_building)

);