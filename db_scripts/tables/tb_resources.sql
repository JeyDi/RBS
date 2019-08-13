CREATE TABLE df.Resources(
	id_resource INT PRIMARY KEY IDENTITY (1, 1),
    [name] VARCHAR (50) NOT NULL,
    [surname] VARCHAR (50) NOT NULL,
    [email] VARCHAR (50) NOT NULL,
    [status] bit not null default 1,
	[admin] bit not null default 0,
	[username] VARCHAR(50) NOT NULL,
	insert_date datetime2 NULL default GETDATE(),
	update_date datetime2 NULL

);