CREATE TABLE df.Buildings(
	id_building INT PRIMARY KEY IDENTITY (1, 1),
	[name] varchar(50) not null,
	[address] varchar(50) not null,
	[status] bit not null default 1,
	[insert_date] datetime2 null default GETDATE(),
	[update_date] datetime2 null

);