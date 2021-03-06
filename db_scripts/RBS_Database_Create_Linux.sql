USE [master]
GO
/****** Object:  Database [RBS]    Script Date: 31/08/2019 15:37:42 ******/
CREATE DATABASE [RBS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RBS', FILENAME = N'/var/opt/mssql/data/RBS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RBS_log', FILENAME = N'/var/opt/mssql/data/RBS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [RBS] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RBS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RBS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RBS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RBS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RBS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RBS] SET ARITHABORT OFF 
GO
ALTER DATABASE [RBS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RBS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RBS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RBS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RBS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RBS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RBS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RBS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RBS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RBS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RBS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RBS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RBS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RBS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RBS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RBS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RBS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RBS] SET RECOVERY FULL 
GO
ALTER DATABASE [RBS] SET  MULTI_USER 
GO
ALTER DATABASE [RBS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RBS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RBS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RBS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RBS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RBS', N'ON'
GO
ALTER DATABASE [RBS] SET QUERY_STORE = OFF
GO
USE [RBS]
GO
/****** Object:  Schema [df]    Script Date: 31/08/2019 15:37:42 ******/
CREATE SCHEMA [df]
GO
/****** Object:  Table [df].[Reservations]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [df].[Reservations](
	[id_reservation] [int] IDENTITY(1,1) NOT NULL,
	[event] [varchar](50) NOT NULL,
	[description] [varchar](max) NULL,
	[start_date] [datetime2](7) NOT NULL,
	[end_date] [datetime2](7) NOT NULL,
	[insert_date] [datetime2](7) NULL,
	[update_date] [datetime2](7) NULL,
	[id_resource] [int] NOT NULL,
	[id_room] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_reservation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [df].[udf_reservation_search]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Search and get Reservations by date
-- =============================================
CREATE FUNCTION [df].[udf_reservation_search] 
(	
	-- Add the parameters for the function here
	@Start_date datetime2, 
	@End_date datetime2
)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT 
		s.id_reservation as ID
	FROM df.Reservations as s
	WHERE start_date BETWEEN @Start_date AND @End_date
	AND end_date BETWEEN @Start_date AND @End_date
)
GO
/****** Object:  UserDefinedFunction [df].[udf_reservation_search_count]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Search and get Reservations by date
-- =============================================
CREATE FUNCTION [df].[udf_reservation_search_count] 
(	
	-- Add the parameters for the function here
	@Start_date datetime2 = NULL, 
	@End_date datetime2 = NULL
)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT COUNT(*) as ReservationNumbers 
		--s.id_reservation as ID
	FROM df.Reservations as s
	WHERE start_date BETWEEN @Start_date AND @End_date
	AND end_date BETWEEN @Start_date AND @End_date
)
GO
/****** Object:  UserDefinedFunction [df].[udf_reservation_search_byUser]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Search and get Reservations by date
-- =============================================
CREATE FUNCTION [df].[udf_reservation_search_byUser] 
(	
	-- Add the parameters for the function here
	@Start_date datetime2, 
	@End_date datetime2,
	@Resource_ID INT

)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT TOP 1
		s.id_reservation as ID
	FROM df.Reservations as s
	WHERE start_date >= @Start_date
	AND end_date <= @End_date
	AND id_resource = @Resource_ID
)
GO
/****** Object:  Table [df].[Buildings]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [df].[Buildings](
	[id_building] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[status] [bit] NOT NULL,
	[insert_date] [datetime2](7) NULL,
	[update_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_building] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [df].[Resources]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [df].[Resources](
	[id_resource] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[surname] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[status] [bit] NOT NULL,
	[admin] [bit] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[insert_date] [datetime2](7) NULL,
	[update_date] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_resource] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [df].[Rooms]    Script Date: 31/08/2019 15:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [df].[Rooms](
	[id_room] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[sittings] [int] NOT NULL,
	[insert_date] [datetime2](7) NULL,
	[update_date] [datetime2](7) NULL,
	[id_building] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_room] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [df].[Buildings] ON 

INSERT [df].[Buildings] ([id_building], [name], [address], [status], [insert_date], [update_date]) VALUES (2, N'Edificio 1', N'Via Giuseppe Mazzini, 11, 21052 Busto Arsizio VA', 1, CAST(N'2019-08-05T16:19:40.0033333' AS DateTime2), NULL)
INSERT [df].[Buildings] ([id_building], [name], [address], [status], [insert_date], [update_date]) VALUES (3, N'Villa', N'Via Dante Alighieri, 6, 21052 Busto Arsizio VA', 1, CAST(N'2019-08-05T17:28:53.0366667' AS DateTime2), NULL)
INSERT [df].[Buildings] ([id_building], [name], [address], [status], [insert_date], [update_date]) VALUES (1005, N'Edificio 2', N'Via indefinito 1', 1, CAST(N'2019-08-31T12:54:41.2400000' AS DateTime2), NULL)
INSERT [df].[Buildings] ([id_building], [name], [address], [status], [insert_date], [update_date]) VALUES (1006, N'Edificio 3', N'Via Nascosta dietro', 1, CAST(N'2019-08-31T12:54:49.6333333' AS DateTime2), NULL)
SET IDENTITY_INSERT [df].[Buildings] OFF
SET IDENTITY_INSERT [df].[Reservations] ON 

INSERT [df].[Reservations] ([id_reservation], [event], [description], [start_date], [end_date], [insert_date], [update_date], [id_resource], [id_room]) VALUES (1, N'Percorso Circolare', N'Lezione del percorso circolare', CAST(N'2019-06-08T09:00:00.0000000' AS DateTime2), CAST(N'2019-06-08T18:00:00.0000000' AS DateTime2), CAST(N'2019-08-06T14:37:18.0333333' AS DateTime2), NULL, 11, 6)
INSERT [df].[Reservations] ([id_reservation], [event], [description], [start_date], [end_date], [insert_date], [update_date], [id_resource], [id_room]) VALUES (2, N'Percorso Circolare', N'Seconda lezione del percorso circolare', CAST(N'2019-10-08T09:00:00.0000000' AS DateTime2), CAST(N'2019-10-08T18:00:00.0000000' AS DateTime2), CAST(N'2019-08-06T14:39:36.0666667' AS DateTime2), NULL, 11, 6)
INSERT [df].[Reservations] ([id_reservation], [event], [description], [start_date], [end_date], [insert_date], [update_date], [id_resource], [id_room]) VALUES (3, N'Percorso circolare', N'Lezione 3 del percorso circolare', CAST(N'2019-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2019-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2019-08-29T16:18:35.8866667' AS DateTime2), NULL, 11, 8)
INSERT [df].[Reservations] ([id_reservation], [event], [description], [start_date], [end_date], [insert_date], [update_date], [id_resource], [id_room]) VALUES (5, N'Percorso Data Science', N'Lezione del progetto di data science', CAST(N'2019-08-06T00:00:00.0000000' AS DateTime2), CAST(N'2019-08-06T00:00:00.0000000' AS DateTime2), CAST(N'2019-08-29T17:20:49.6466667' AS DateTime2), NULL, 14, 8)
INSERT [df].[Reservations] ([id_reservation], [event], [description], [start_date], [end_date], [insert_date], [update_date], [id_resource], [id_room]) VALUES (1012, N'Test', N'Test', CAST(N'2019-08-31T10:00:00.0000000' AS DateTime2), CAST(N'2019-08-31T12:00:00.0000000' AS DateTime2), CAST(N'2019-08-31T12:26:02.2300000' AS DateTime2), NULL, 11, 5)
SET IDENTITY_INSERT [df].[Reservations] OFF
SET IDENTITY_INSERT [df].[Resources] ON 

INSERT [df].[Resources] ([id_resource], [name], [surname], [email], [status], [admin], [username], [insert_date], [update_date]) VALUES (11, N'Andrea', N'Guzzo', N'andrea.guzzo@reti.it', 1, 1, N'guzzoan1', CAST(N'2019-08-05T17:23:45.6000000' AS DateTime2), NULL)
INSERT [df].[Resources] ([id_resource], [name], [surname], [email], [status], [admin], [username], [insert_date], [update_date]) VALUES (12, N'Salvatore', N'Albore', N'salvatore.albore@reti.it', 1, 0, N'alborsa1', CAST(N'2019-08-05T17:24:54.0466667' AS DateTime2), NULL)
INSERT [df].[Resources] ([id_resource], [name], [surname], [email], [status], [admin], [username], [insert_date], [update_date]) VALUES (13, N'Edoardo', N'Tiboldo', N'edoardo.tiboldo@reti.it', 1, 0, N'tiboled1', CAST(N'2019-08-05T17:24:54.0500000' AS DateTime2), NULL)
INSERT [df].[Resources] ([id_resource], [name], [surname], [email], [status], [admin], [username], [insert_date], [update_date]) VALUES (14, N'Gianluca', N'Bragoli', N'gianluca.bragoli@reti.it', 1, 0, N'bragogi1', CAST(N'2019-08-19T17:00:13.6466667' AS DateTime2), NULL)
INSERT [df].[Resources] ([id_resource], [name], [surname], [email], [status], [admin], [username], [insert_date], [update_date]) VALUES (24, N'Dario', N'Cecchetto', N'dario.cecchetto@reti.it', 1, 1, N'cecchda1', CAST(N'2019-08-23T18:01:14.5966667' AS DateTime2), NULL)
INSERT [df].[Resources] ([id_resource], [name], [surname], [email], [status], [admin], [username], [insert_date], [update_date]) VALUES (2015, N'Simone', N'Visconti', N'simone.visconti@reti.it', 1, 0, N'viscosi1', CAST(N'2019-08-31T12:44:30.7666667' AS DateTime2), NULL)
SET IDENTITY_INSERT [df].[Resources] OFF
SET IDENTITY_INSERT [df].[Rooms] ON 

INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (5, N'R102', 50, CAST(N'2019-08-05T19:40:33.0433333' AS DateTime2), NULL, 2)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (6, N'R101', 50, CAST(N'2019-08-05T19:40:42.3033333' AS DateTime2), NULL, 2)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (8, N'R103', 30, CAST(N'2019-08-29T15:57:54.0033333' AS DateTime2), NULL, 2)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (1007, N'Sala Riunioni', 10, CAST(N'2019-08-31T12:54:26.8366667' AS DateTime2), NULL, 3)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (1008, N'Nuova sala 1', 40, CAST(N'2019-08-31T12:55:11.5200000' AS DateTime2), NULL, 1005)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (1009, N'R301', 40, CAST(N'2019-08-31T12:56:24.8666667' AS DateTime2), NULL, 1006)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (1010, N'R302', 30, CAST(N'2019-08-31T13:01:10.9833333' AS DateTime2), NULL, 1006)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (1011, N'R303', 20, CAST(N'2019-08-31T13:01:52.2566667' AS DateTime2), NULL, 1006)
INSERT [df].[Rooms] ([id_room], [name], [sittings], [insert_date], [update_date], [id_building]) VALUES (1012, N'R304', 20, CAST(N'2019-08-31T13:02:00.0766667' AS DateTime2), NULL, 1006)
SET IDENTITY_INSERT [df].[Rooms] OFF
ALTER TABLE [df].[Buildings] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [df].[Buildings] ADD  DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [df].[Reservations] ADD  DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [df].[Resources] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [df].[Resources] ADD  DEFAULT ((0)) FOR [admin]
GO
ALTER TABLE [df].[Resources] ADD  DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [df].[Rooms] ADD  DEFAULT (getdate()) FOR [insert_date]
GO
ALTER TABLE [df].[Reservations]  WITH CHECK ADD FOREIGN KEY([id_resource])
REFERENCES [df].[Resources] ([id_resource])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [df].[Reservations]  WITH CHECK ADD FOREIGN KEY([id_resource])
REFERENCES [df].[Resources] ([id_resource])
GO
ALTER TABLE [df].[Reservations]  WITH CHECK ADD FOREIGN KEY([id_room])
REFERENCES [df].[Rooms] ([id_room])
GO
ALTER TABLE [df].[Reservations]  WITH CHECK ADD FOREIGN KEY([id_room])
REFERENCES [df].[Rooms] ([id_room])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [df].[Rooms]  WITH CHECK ADD FOREIGN KEY([id_building])
REFERENCES [df].[Buildings] ([id_building])
GO
/****** Object:  StoredProcedure [df].[building_create]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Create and define a new Building
-- =============================================
CREATE PROCEDURE [df].[building_create] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '', 
	@Address varchar(50) = ''

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Identity INT

	--Check if the person already exist (we are not using the duplicate system for people)
	IF EXISTS (SELECT 1 FROM df.Buildings WHERE name = @Name and LOWER(TRIM(address)) = LOWER(TRIM(@Address)) )
		BEGIN
			print('Sorry this building already exist')
			return -1
		END
	ELSE
		BEGIN
			

			--Insert into the table
			INSERT INTO df.Buildings(name,address,status)
			values(@Name,@Address,1)

			--Get the ID inserted
			SET @Identity = Scope_Identity()

			print('New building created')

			--Check if the building was inserted correctly
			select 
				[id_building],
				[name], 
				[address], 
				[status], 
				[insert_date],
				[update_date]

			from df.Buildings
			where id_building = @Identity

			return 1
		END


END
GO
/****** Object:  StoredProcedure [df].[building_delete]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Delete building already exist
-- =============================================
CREATE PROCEDURE [df].[building_delete] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Room_ID int
	
	EXEC @Identity = df.building_getID @Name = @Name

    -- Remove by name and surname
	IF @Identity > 0 AND @Identity IS NOT NULL
		BEGIN
			
			--Remove all the rooms associated with the building
			DELETE FROM df.Rooms where id_building = @Identity

			--Remove the building
			DELETE from df.Buildings where id_building = @Identity

			--On cascade all the Reservation associated with the building and the room will be deleted

			print('Resource deleted with:' + @Name + ' and ID: ' + cast(@Identity as varchar(2)))
			return 1
		END
	ELSE
		BEGIN
			print('No buildings available, impossible to remove the building that you are looking for...')
			return -1
		END

	
	print('Impossible to remove the person that you looking for..')

END
GO
/****** Object:  StoredProcedure [df].[building_detail]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Single Building Details
-- =============================================
CREATE PROCEDURE [df].[building_detail] 
	
	--Input parameters
	@Name varchar(50) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity INT
	EXEC @Identity = df.building_getID @Name = @Name

	-- Check by name and surname
	IF @Identity IS NOT NULL
			BEGIN
				SELECT 
					[id_building] as id_building
					,[name] as name
					,[address] as address
					,[status] as status
					,[insert_date] as insert_date
					,[update_date] as update_date
				FROM df.Buildings
				WHERE
					id_building = @Identity

			END
		ELSE
			BEGIN
				print('There is no Buildings with this name')
				return -1
			END	
END
GO
/****** Object:  StoredProcedure [df].[building_getID]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get Resource ID
-- =============================================
CREATE PROCEDURE [df].[building_getID] 
	@Name varchar(50) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identifier INT

    
    -- Get ID by building name
	IF @Name IS NOT NULL
		BEGIN
			SET @Identifier = (SELECT TOP 1 id_building from df.Buildings where TRIM(LOWER(name)) like TRIM(LOWER(@Name)))
			print('Resource with:' + @Name + ' has ID: ' + CAST(@Identifier as varchar(2)))
			return @Identifier
		END
	ELSE
		BEGIN
			print('No buildings available, impossible to remove the building that you are looking for...')
			SET @Identifier = -1
			return @Identifier
		END
END
GO
/****** Object:  StoredProcedure [df].[building_list]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	List of all Buildings
-- =============================================
CREATE PROCEDURE [df].[building_list] 
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		[id_building] as id_building
		,[name] as name
		,[address] as address
		,[status] as status
		,[insert_date] as insert_date
		,[update_date] as update_date
		
	FROM df.Buildings
END
GO
/****** Object:  StoredProcedure [df].[check_names]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Check same names
-- =============================================
CREATE PROCEDURE [df].[check_names] 
	
	--TODO: Need to create a function to better generalize the Count

	@Name varchar(50) = ''
	,@Surname varchar(50) = ''

	--Define the table that you want to use for the check
	-- R = rooms
	-- B = buildings
	-- S = resources
	,@Table varchar(2) = ''

AS
BEGIN

	DECLARE @Count int
	DECLARE @Result int

	SET NOCOUNT ON;

	--Case 1: Rooms
	IF TRIM(LOWER(@Table)) like 'r'
		BEGIN
			SET @Count = ( SELECT Count(*)
							FROM df.Rooms
							WHERE TRIM(LOWER(name)) = TRIM(LOWER(@Name))
							)
			IF @Count > 0
				BEGIN
					print('Duplicate found in rooms')
					SET @Result = 1
				END
			ELSE
				BEGIN
					print('Duplicate not found in rooms')
					SET @Result = 0
				END
		END


	--Case 2: Buildings
	IF TRIM(LOWER(@Table)) like 'b'
		BEGIN
			SET @Count = (SELECT Count(*)
							FROM df.Buildings
							WHERE TRIM(LOWER(name)) LIKE TRIM(LOWER(@Name))
							)
			IF @Count > 0
				BEGIN
					print('Duplicate found in buildings')
					SET @Result = 1
				END
			ELSE
				BEGIN
					print('Duplicate not found in buildings')
					SET @Result = 0
				END
		END	

	--Case 3: Resources --> use to check if there is Homonyms
	IF TRIM(LOWER(@Table)) like 's'
		BEGIN
			SET @Count = (SELECT Count(*)
							FROM df.Resources
							WHERE TRIM(LOWER(name)) LIKE TRIM(LOWER(@Name)) AND
									TRIM(LOWER(surname)) LIKE TRIM(LOWER(@Surname))
							)
				IF @Count > 0
				BEGIN
					print('Duplicate found in resource')
					SET @Result = 1
				END
			ELSE
				BEGIN
					print('Duplicate not found in resource')
					SET @Result = 0
				END
		END

	----Case: Invalid
	--IF TRIM(LOWER(@Table)) NOT LIKE 'r' OR TRIM(LOWER(@Table)) NOT LIKE 'b' OR TRIM(LOWER(@Table)) NOT LIKE 's'
	--	BEGIN
	--		print('Please define a correct Table Like: b,s,r')
	--		SET @Result = 0
	--	END

	
	RETURN @Result

END
GO
/****** Object:  StoredProcedure [df].[reservation_all]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get Reservation List
-- =============================================
CREATE PROCEDURE [df].[reservation_all] 
	
	@Resource_username varchar(50)
	
AS
BEGIN
	
	DECLARE @Resource_ID INT

	SET NOCOUNT ON;

	--Check if the person already exist
	EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL
			
	--print('Resource ID:' + CAST(@Resource_ID as varchar(2)))

	print('Start searching')
	--Get the reservations for a specific user (using the udf to check duplicates)
							
		SELECT
			r.id_reservation as reserv_id
			,r.event as reserv_event
			,r.description as reserv_description
			,r.start_date as reserv_start_date
			,r.end_date as reserv_end_date
			,r.id_resource as resource_id
			,s.name as resource_name
			,s.surname as resource_surname
			,s.username as resource_username
			,s.email as resource_email
			,r.id_room as room_id
			,rms.name as room_name
			,rms.sittings as room_sittings
			,rms.id_building as build_id
			,b.name as build_name
		FROM 
		df.Reservations as r
		--INNER JOIN [df].[udf_reservation_search_byUser](@Start_Date,@End_Date,@Resource_ID) as s_udf
		--	ON r.id_reservation = s_udf.ID
		INNER JOIN df.Resources as s
			ON r.id_resource = s.id_resource
		INNER JOIN df.Rooms as rms
			ON r.id_room = rms.id_room
		INNER JOIN df.Buildings as b
			ON rms.id_building = b.id_building
		where
			r.id_resource = @Resource_ID
			
	print('Search completed..')
    
	
END
GO
/****** Object:  StoredProcedure [df].[reservation_all_unfiltered]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Select all reservation without any filters
-- =============================================
CREATE PROCEDURE [df].[reservation_all_unfiltered] 
	

AS
BEGIN
	
	DECLARE @Resource_ID INT

	SET NOCOUNT ON;

	

	print('Start searching')
	--Get the reservations for a specific user (using the udf to check duplicates)
							
		SELECT
			r.id_reservation as reserv_id
			,r.event as reserv_event
			,r.description as reserv_description
			,r.start_date as reserv_start_date
			,r.end_date as reserv_end_date
			,r.id_resource as resource_id
			,s.name as resource_name
			,s.surname as resource_surname
			,s.username as resource_username
			,s.email as resource_email
			,r.id_room as room_id
			,rms.name as room_name
			,rms.sittings as room_sittings
			,rms.id_building as build_id
			,b.name as build_name
		FROM 
		df.Reservations as r
		--INNER JOIN [df].[udf_reservation_search_byUser](@Start_Date,@End_Date,@Resource_ID) as s_udf
		--	ON r.id_reservation = s_udf.ID
		INNER JOIN df.Resources as s
			ON r.id_resource = s.id_resource
		INNER JOIN df.Rooms as rms
			ON r.id_room = rms.id_room
		INNER JOIN df.Buildings as b
			ON rms.id_building = b.id_building

			
	print('Search completed..')
    
	
END
GO
/****** Object:  StoredProcedure [df].[reservation_create]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Insert and Create a new reservation
-- =============================================
CREATE PROCEDURE [df].[reservation_create] 
	-- Add the parameters for the stored procedure here
	@Event varchar(50) = NULL
	,@Description varchar(50) = NULL
	,@Resource_username varchar(50) = NULL
	,@Room_name varchar(50) = NULL
	,@Start_date datetime2 = NULL
	,@End_date datetime2 = NULL
AS
BEGIN
	
	DECLARE @Previous_Reservation INT = 0
	DECLARE @Building_ID INT = -1
	DECLARE @Room_ID INT = -1
	DECLARE @Resource_ID INT = -1

	SET NOCOUNT ON;

	--Check if event and description are populated in input
	IF @Event IS NOT NULL AND @Description IS NOT NULL
		BEGIN
			--Check if the room is populated in input
			IF @Room_name IS NOT NULL
				BEGIN

					--Get the Room ID and Building ID
					exec @Room_ID = df.room_getID @Room_name
					SET @Building_ID = (SELECT id_building from df.Rooms where id_room = @Room_ID)

					--Exec only if the start date and end date are corrected
					IF @Start_date IS NOT NULL AND @End_date IS NOT NULL
					BEGIN
						--Check if there is no other reservation for that room and building in the period
						exec @Previous_Reservation = df.reservation_duplicates @Building_ID, @Room_ID, @Start_date, @End_date

						--If there aren't other previous reservation continue
						IF @Previous_Reservation <= 0
							BEGIN

								--Check if there is the correct username in input
								IF @Resource_username iS NOT NULL
									BEGIN

									--Check if the person already exist
									EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL

									--Create a new reservation
									INSERT INTO df.Reservations(event,description,start_date,end_date,id_resource, id_room)
									VALUES(@Event,@Description,@Start_date,@End_date, @Resource_ID, @Room_ID)

									print('New reservation inserted correctly for the event: ' + @Event)

									--Check reservation inserted
									SELECT
										r.id_reservation as reserv_id
										,r.event as reserv_event
										,r.description as reserv_description
										,r.start_date as reserv_start_date
										,r.end_date as reserv_end_date
										,r.id_resource as resource_id
										,s.name as resource_name
										,s.surname as resource_surname
										,s.username as resource_username
										,s.email as resource_email
										,r.id_room as room_id
										,o.name as room_name
										,o.sittings as room_sittings
										,o.id_building as build_id
										,b.name as build_name
										
									FROM 
										df.Reservations as r
										INNER JOIN df.Resources as s
											ON r.id_resource = s.id_resource
										INNER JOIN df.Rooms as o
											ON r.id_room = o.id_room
										INNER JOIN df.Buildings as b
											ON o.id_building = b.id_building

									WHERE 
										r.id_resource = @Resource_ID 
										AND r.id_room = @Room_ID 
										AND @Start_date = @Start_date


									return 1

									END
								ELSE
									BEGIN
										print('impossibile to find the person for the reservation')
										return -1
									END
							END
						ELSE
							BEGIN
								print('there are other reservations on this date, impossible to create a new one')
								return -1
							END
					END
				END
			ELSE
				BEGIN
					print('please insert a valid room id that you want to use for your reservation')
					return -1
				END
		END
	ELSE
		BEGIN
		print('Invalid parameters, impossibile to create a new appointment with this info')
		return -1
		END
   
END
GO
/****** Object:  StoredProcedure [df].[reservation_delete]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Delete a previous single reservation with id
-- =============================================
CREATE PROCEDURE [df].[reservation_delete]
	-- Add the parameters for the stored procedure here
	@Identifier int


AS
BEGIN
	

	SET NOCOUNT ON;
	
	IF @Identifier IS NOT NULL
		BEGIN
			--Delete the reservation that you found (possibile because foreign key is in CASCADE mode for Update and Delete)
			DELETE FROM df.Reservations where id_reservation = @Identifier
			return 1
		END
	ELSE
		BEGIN
			print('Impossible to find a reservation, please retry')
			return -1
		END

END
GO
/****** Object:  StoredProcedure [df].[reservation_delete_single]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Delete a previous single reservation
-- =============================================
CREATE PROCEDURE [df].[reservation_delete_single]
	-- Add the parameters for the stored procedure here
	@Date datetime2,
	@Username varchar(50)


AS
BEGIN
	
	DECLARE @Identifier INT

	SET NOCOUNT ON;
	
	exec @Identifier = df.reservation_getID @Date, @Username

	IF @Identifier IS NOT NULL
		BEGIN
			--Delete the reservation that you found (possibile because foreign key is in CASCADE mode for Update and Delete)
			DELETE FROM df.Reservations where id_reservation = @Identifier
			return 1
		END
	ELSE
		BEGIN
			print('Impossible to find a reservation, please retry')
			return -1
		END

END
GO
/****** Object:  StoredProcedure [df].[reservation_duplicates]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Search and count how many Reservations by date, building and room, useful to check duplicates
-- =============================================
CREATE PROCEDURE [df].[reservation_duplicates]
(	
	-- Add the parameters for the function here
	@Building int = NULL,
	@Room int = NULL,
	@Start_date datetime2 = NULL, 
	@End_date datetime2 = NULL
)

AS
BEGIN 

	DECLARE @ReservationNumbers INT

	SET @ReservationNumbers = (
		SELECT COUNT(s.id_reservation) as ReservationNumbers 
			--s.id_reservation as ID
		FROM df.Reservations as s
		INNER JOIN df.Rooms as r
		ON s.id_room = r.id_room
		INNER JOIN df.Buildings as b
		ON r.id_building = b.id_building
		WHERE 
			b.id_building = @Building
			AND r.id_room = @Room
			AND (
				(@Start_date BETWEEN start_date AND end_date) 
				OR (@End_date BETWEEN start_date AND end_date)
				OR (
					(start_date BETWEEN @Start_date AND @End_date) 
					AND (end_date BETWEEN @Start_date AND @End_date)
					)
			)
		);

	return @ReservationNumbers
END
GO
/****** Object:  StoredProcedure [df].[reservation_getID]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get ID of a Reservation
-- =============================================
CREATE PROCEDURE [df].[reservation_getID] 
	
	@Date datetime2 NULL
	,@Resource_username varchar(50) NULL

AS
BEGIN
	
	DECLARE @Resource_ID INT
	DECLARE @Identifier INT
	
	SET NOCOUNT ON;

	IF @Resource_username IS NOT NULL
		BEGIN
			
			--Check if the person already exist
			EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL

			IF @Resource_ID > 0
				BEGIN
					
					IF @Date IS NOT NULL
						BEGIN
								
							--Get the reservation (using the udf to check duplicates)
							SET @Identifier = (
							SELECT
								TOP 1 --Warning
								r.id_reservation as ID
							FROM df.Reservations as r
							INNER JOIN [df].[udf_reservation_search_byUser](@Date,@Date,@Resource_ID) as s
							ON r.id_reservation = s.ID
							INNER JOIN df.Rooms as rms
							ON r.id_room = rms.id_room
							INNER JOIN df.Buildings as b
							ON rms.id_building = b.id_building)

							return @Identifier
						END
					ELSE
						BEGIN
							print('Please specify valid date')
							return NULL
						END

				END
			ELSE
				BEGIN
					print('Username not valid..')
					return NULL
				END

		END
	ELSE
		BEGIN
			print('You can''t all the Reservation, please insert a valid username')
			return NULL
		END

    
	
END
GO
/****** Object:  StoredProcedure [df].[reservation_list]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get Reservation List
-- =============================================
CREATE PROCEDURE [df].[reservation_list] 
	
	@Start_Date datetime2
	,@End_Date datetime2
	,@Resource_username varchar(50)
	
AS
BEGIN
	
	DECLARE @Resource_ID INT

	SET NOCOUNT ON;

	--Check if the person already exist
	EXEC @Resource_ID = df.resource_getID NULL, NULL, @Resource_username, NULL
			
	--print('Resource ID:' + CAST(@Resource_ID as varchar(2)))

	print('Start searching')
	--Get the reservations for a specific user (using the udf to check duplicates)
							
		SELECT
			r.id_reservation as reserv_id
			,r.event as reserv_event
			,r.description as reserv_description
			,r.start_date as reserv_start_date
			,r.end_date as reserv_end_date
			,r.id_resource as resource_id
			,s.name as resource_name
			,s.surname as resource_surname
			,s.username as resource_username
			,s.email as resource_email
			,r.id_room as room_id
			,rms.name as room_name
			,rms.sittings as room_sittings
			,rms.id_building as build_id
			,b.name as build_name
		FROM 
		df.Reservations as r
		--INNER JOIN [df].[udf_reservation_search_byUser](@Start_Date,@End_Date,@Resource_ID) as s_udf
		--	ON r.id_reservation = s_udf.ID
		INNER JOIN df.Resources as s
			ON r.id_resource = s.id_resource
		INNER JOIN df.Rooms as rms
			ON r.id_room = rms.id_room
		INNER JOIN df.Buildings as b
			ON rms.id_building = b.id_building
		where
			r.id_resource = @Resource_ID
			AND r.start_date >= @Start_Date
			AND r.end_date <= @End_Date
			
	print('Search completed..')
    
	
END
GO
/****** Object:  StoredProcedure [df].[resource_create]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	CreateResource
-- =============================================
CREATE PROCEDURE [df].[resource_create] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '', 
	@Surname varchar(50) = '',
	@Admin bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Homonims int = 1
	DECLARE @email varchar(50)
	DECLARE @username varchar(50)

	--Check if the person already exist (we are not using the duplicate system for people)
	IF EXISTS (SELECT 1 FROM df.Resources WHERE name = @Name and surname = @Surname)
		BEGIN

			SET @Homonims = (SELECT COUNT(*) + 1 FROM df.Resources WHERE name = @Name and surname = @Surname)
			print('The person already exist, generate a new username')
			
		END
	
	BEGIN
		--Define username and email
		 SET @username = (select LEFT(LOWER(@Surname), 5) + LEFT(LOWER(@Name), 2) + CAST(@Homonims as varchar(1)) as username)
		IF @Homonims > 1
			BEGIN
				SET @email = (select LOWER(@Name) + '.' + LOWER(@Surname) + CAST(@Homonims as varchar(1)) + '@' + 'reti.it')
			END
		ELSE
			BEGIN
				SET @email = (select LOWER(@Name) + '.' + LOWER(@Surname) + '@' + 'reti.it')
			END

		--Insert into the table
		INSERT INTO df.Resources(name,surname,email,status,admin,username)
		values(@Name,@Surname,@email,1,@Admin,@username);

		print('New resource inserted')

		--Check if the person was inserted correctly
		select [id_resource], [name], [surname], [email], [username], [admin], [status], [insert_date], [update_date]
		from df.Resources
		where username = @username

		return 1
	END


END
GO
/****** Object:  StoredProcedure [df].[resource_delete]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Delete resource already exist
-- =============================================
CREATE PROCEDURE [df].[resource_delete] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '', 
	@Surname varchar(50) = '',
	@Username varchar(50) = '',
	@Email varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Result int = 0

    -- Remove by name and surname
	IF @Result != 1 AND ((@Name IS NOT NULL AND @Surname IS NOT NULL) OR (@Name != '' AND @Surname != ''))
		BEGIN
			EXEC @Identity = df.resource_getID @Name, @Surname, NULL, NULL
			
			IF @Identity != -1
				BEGIN
					DELETE from df.Resources where id_resource = @Identity
					print('Resource deleted with:' + @Name +' and ' + @Surname )
					SET @Result = 1
				END
				BEGIN
					SET @Result = -1
				END
		END

	--Remove by username
	IF @Result != 1 AND (@Username IS NOT NULL OR @Username != '')
		BEGIN
			EXEC @Identity = df.resource_getID NULL, NULL, @Username, NULL

			IF @Identity != -1
				BEGIN
					DELETE from df.Resources where id_resource = @Identity
					print('Resource deleted with:' + @Username )
					SET @Result = 1
				END
				BEGIN
					SET @Result = -1
				END
		END

	--Remove by email
	IF @Result != 1 AND (@Email IS NOT NULL OR @Email != '')
		BEGIN
			EXEC @Identity = df.resource_getID NULL, NULL, NULL, @Email
								
			IF @Identity != -1
				BEGIN
					DELETE from df.Resources where id_resource = @Identity
					print('Resource deleted with:' + @Email )
					SET @Result = 1
				END
			ELSE
				BEGIN
					SET @Result = -1
				END
		END

	IF @Name IS NULL AND @Surname IS NULL AND @Username IS NULL AND @Email IS NULL
		BEGIN
			print('Please insert valid informations to search and delete a resource')
			SET @Result = -1
		END


	return @Result

END
GO
/****** Object:  StoredProcedure [df].[resource_detail]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Single Resource Details
-- =============================================
CREATE PROCEDURE [df].[resource_detail] 
	
	--Input parameters
	@Name varchar(50) = ''
	,@Surname varchar(50) = ''
	,@Username varchar(50) = ''
	,@Email varchar(50) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Result int

	-- Check by name and surname
	IF @Name IS NOT NULL AND @Surname IS NOT NULL
		
		EXEC @Identity = df.resource_getID @Name, @Surname, NULL, NULL
			
		IF @Identity != -1
			BEGIN
				SELECT 
					[id_resource] as ID
					,[name] as Name
					,[surname] as Surname
					,[email] as Email
					,[username] as Username
					,[status] as Status
					,[admin] as Admin
					,[insert_date] as Insert_Date
					,[update_date] as Update_Date
				FROM df.Resources
				WHERE
					trim(lower(name)) = trim(lower(@Name))
					AND trim(lower(surname)) = trim(lower(@Surname))

				SET @Result = 1
			END
		ELSE
			BEGIN
			SET @Result = -1
			END
				
	--Check by username
	IF @Username IS NOT NULL

		EXEC @Identity = df.resource_getID NULL, NULL, @Username, NULL
			
		IF @Identity != -1

			BEGIN
				SELECT 
					[id_resource] as ID
					,[name] as Name
					,[surname] as Surname
					,[email] as Email
					,[username] as Username
					,[status] as Status
					,[admin] as Admin
					,[insert_date] as Insert_Date
					,[update_date] as Update_Date
				FROM df.Resources
				WHERE
					id_resource = @Identity

				SET @Result = 1
			END
		ELSE
			BEGIN
			 SET @Result = -1
			END

	--Check by email
	IF @Email IS NOT NULL
		EXEC @Identity = df.resource_getID NULL, NULL, NULL, @Email
			
		IF @Identity != -1
	BEGIN
		SELECT 
			[id_resource] as ID
			,[name] as Name
			,[surname] as Surname
			,[email] as Email
			,[username] as Username
			,[status] as Status
			,[admin] as Admin
			,[insert_date] as Insert_Date
			,[update_date] as Update_Date
		FROM df.Resources
		WHERE
			id_resource = @Identity

		SET @Result = 1
		END
	ELSE
		BEGIN

			SET @Result = -1
		END	

	return @Result
			
END
GO
/****** Object:  StoredProcedure [df].[resource_getID]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get Resource ID
-- =============================================
CREATE PROCEDURE [df].[resource_getID] 
	@Name varchar(50) = '', 
	@Surname varchar(50) = '',
	@Username varchar(50) = '',
	@Email varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identifier INT

    -- Get the ID using name and surname (useless using only name or surname, that's why it's need both)
	IF @Name IS NOT NULL AND @Surname IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Resources WHERE trim(lower(name)) Like trim(lower(@Name)) and trim(lower(surname)) like trim(lower(@Surname)))
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_resource FROM df.Resources WHERE trim(lower(name)) = trim(lower(@Name)) AND trim(lower(surname)) = trim(lower(@Surname)) )
				
				print('Resource with:' + @Name +' and ' + @Surname + ' has ID: ' + CAST(@Identifier as varchar(2)) )
				return @Identifier
			END
		ELSE
			BEGIN	
				print('No resources avaiable with name and surname')
				SET @Identifier = -1
				return @Identifier
			END

				--Get the ID using the username
	IF @Username IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Resources WHERE trim(lower(username)) like trim(lower(@Username)))
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_resource FROM df.Resources WHERE trim(lower(username)) = trim(lower(@Username)) )
				print('Resource with:' + @Username + ' has ID: ' + CAST(@Identifier as varchar(2)))
				return @Identifier
			END
		ELSE
			BEGIN			
				print('No resources avaiable with username')
				SET @Identifier = -1
				return @Identifier
			END

	--Get the ID using the email
	IF @Email IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Resources WHERE trim(lower(email)) like trim(lower(@Email)))
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_resource FROM df.Resources WHERE trim(lower(email)) = trim(lower(@Email)) )
				print('Resource with:' + @Email + ' has ID: ' + CAST(@Identifier as varchar(2)) )
				return @Identifier
			END
		ELSE
			BEGIN
				--If no one was found
				print('No resource available, impossible to find the person that you are looking for...')
				SET @Identifier = -1
				return @Identifier
			END

END
GO
/****** Object:  StoredProcedure [df].[resource_getUsername]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get Resource Username
-- =============================================
CREATE PROCEDURE [df].[resource_getUsername] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = '',
	@Surname varchar(50) = '',
	@Email varchar(50) = ''
	
AS
BEGIN

	SET NOCOUNT ON;

	--1. get id using name, surname, email
	--2. use id to search and get username

	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Result int

	-- Check by name and surname
	IF @Name IS NOT NULL AND @Surname IS NOT NULL
		
		EXEC @Identity = df.resource_getID @Name, @Surname, NULL, NULL
			
		IF @Identity > 0
			BEGIN
				SET @Result = (SELECT TOP 1
					[username]
				FROM df.Resources
				WHERE
					id_resource = @Identity)

			END
		ELSE
			BEGIN
			SET @Result = NULL
			END

	IF @Email IS NOT NULL
		EXEC @Identity = df.resource_getID NULL, NULL, NULL, @Email
			
		IF @Identity > 0
	BEGIN
		SET @Result = (SELECT 
			[username]
		FROM df.Resources
		WHERE
			id_resource = @Identity)

		END
	ELSE
		BEGIN

			SET @Result = NULL
		END	

	return @Result

END
GO
/****** Object:  StoredProcedure [df].[resource_list]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	List of all resources
-- =============================================
CREATE PROCEDURE [df].[resource_list] 
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		[id_resource] as id_resource
		,[name] as name
		,[surname] as surname
		,[email] as email
		,[username] as username
		,[status] as status
		,[admin] as admin
		,[insert_date] as insert_date
		,[update_date] as update_date
	FROM df.Resources
END
GO
/****** Object:  StoredProcedure [df].[room_all]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get the list of all rooms by building
-- =============================================
CREATE PROCEDURE [df].[room_all] 

	
AS
BEGIN
	
	SET NOCOUNT ON;

	--Get the Rooms by Building ID
	SELECT 
		r.id_room as room_id
		,r.name as room_name
		,r.sittings as room_sittings
		,r.id_building as build_id
		,b.name as build_name
	FROM df.Rooms as r
	INNER JOIN df.Buildings as b
	ON r.id_building = b.id_building


END

GO
/****** Object:  StoredProcedure [df].[room_create]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Create a new room
-- =============================================
CREATE PROCEDURE [df].[room_create] 
	
	@Name varchar(50) = ''
	,@Sittings int = 0
	,@Building_Name varchar(50) = ''
	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Name_Check INT
	DECLARE @Building_ID INT
	
	IF @Name IS NOT NULL AND @Sittings != 0
		BEGIN
			
			--Check if the building already exist
			EXEC @Building_ID = df.building_getID @Building_Name

			IF @Building_ID > 0 AND @Building_ID IS NOT NULL
				BEGIN 
					
					--Check if the name already exist
					EXEC @Name_Check = df.check_names @Name, NULL, 'r'

					IF @Name_Check = 0
						BEGIN
						INSERT INTO df.Rooms(name,sittings,id_building)
						VALUES(@Name, @Sittings, @Building_ID)
						print('New room inserted in the building: ' + CAST(@Building_ID as varchar(2)))

						--Check the room inserted
						DECLARE @Room_Id int = null
						exec @Room_Id = df.room_getID @Name

						SELECT 
							r.id_room as room_id
							,r.name as room_name
							,r.sittings as room_sittings
							,r.id_building as build_id
							,b.name as build_name
						
						FROM
							df.Rooms as r
							INNER JOIN df.Buildings as b
							ON r.id_building = b.id_building
						where r.id_room = @Room_Id AND r.id_building = @Building_ID


						return 1

						END
					ELSE
						BEGIN
						print('Another room found, please change the name if you want to create a new one')
						return -1
						END
				END
			ELSE
				BEGIN
					print('Impossibile to find a valid building for the room, please insert a valid building name')
					return -1
				END

		END

END
GO
/****** Object:  StoredProcedure [df].[room_delete]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Delete building already exist
-- =============================================
CREATE PROCEDURE [df].[room_delete] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Identity int
	DECLARE @Room_name varchar(50)
	
	EXEC @Identity = df.room_getID @Name = @Name

    -- Remove by name and surname
	IF @Identity > 0 AND @Identity IS NOT NULL
		BEGIN
			
			--Remove all the rooms associated with the building
			DELETE FROM df.Rooms where id_room = @Identity

			--On cascade all the Reservation associated with the building and the room will be deleted

			print('Room deleted with:' + @Name + ' and ID: ' + cast(@Identity as varchar(2)))
			return 1
		END
	ELSE
		BEGIN
			print('No room available, impossible to remove the room that you are looking for...')
			return -1
		END

	
	print('Impossible to remove the room that you looking for..')

END
GO
/****** Object:  StoredProcedure [df].[room_detail]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get details for a room
-- =============================================
CREATE PROCEDURE [df].[room_detail] 
	-- Add the parameters for the stored procedure here
	
	@RoomName varchar(50) = ''
AS
BEGIN
	
	
	SET NOCOUNT ON;

	--Get the ID for a room based on the name
	DECLARE @Identity INT
	EXEC @Identity = df.room_getID @RoomName

	--Get room detail by ID
	IF @Identity > 0 AND @Identity IS NOT NULL
		BEGIN
			SELECT 
				r.id_room as room_id
				,r.name as room_name
				,r.sittings as room_sittings
				,r.id_building as build_id
				,b.name as build_name
						
			FROM
				df.Rooms as r
				INNER JOIN df.Buildings as b
				ON r.id_building = b.id_building
			where r.id_room = @Identity
		END


	ELSE
		
		BEGIN
		--No room founded
		print('Impossibile to find a room with those parameters, please retry..')
		return -1
		END

END
GO
/****** Object:  StoredProcedure [df].[room_getID]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 06/08/2019
-- Description:	Get Room ID
-- =============================================
CREATE PROCEDURE [df].[room_getID] 
	
	@Name varchar(50) = ''

AS
BEGIN
	
	DECLARE @Identifier INT

	SET NOCOUNT ON;

    IF @Name IS NOT NULL
		IF EXISTS (SELECT 1 FROM df.Rooms WHERE TRIM(LOWER(name)) = TRIM(LOWER(@Name)) )
			BEGIN
				SET @Identifier = (SELECT TOP 1 id_room from df.Rooms where TRIM(LOWER(name)) = TRIM(LOWER(@Name)))
				print('Room with:' + @Name + ' has ID: ' + CAST(@Identifier as varchar(2)))
				return @Identifier
			END
		ELSE
			BEGIN
				print('No Room available, impossible to remove the building that you are looking for...')
				SET @Identifier = -1
				return @Identifier
			END
	
END
GO
/****** Object:  StoredProcedure [df].[room_list]    Script Date: 31/08/2019 15:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Andrea Guzzo
-- Create date: 05/08/2019
-- Description:	Get the list of all rooms by building
-- =============================================
CREATE PROCEDURE [df].[room_list] 

	
	@Building_name varchar(50) = ''
	
AS
BEGIN
	
	DECLARE @Building_ID int
	
	EXEC @Building_ID = df.building_getID @Building_name

	SET NOCOUNT ON;

	IF @Building_ID > 0 AND @Building_ID IS NOT NULL
		BEGIN
			--Get the Rooms by Building ID
			SELECT 
				r.id_room as room_id
				,r.name as room_name
				,r.sittings as room_sittings
				,r.id_building as build_id
				,b.name as build_name
			FROM df.Rooms as r
			INNER JOIN df.Buildings as b
			ON r.id_building = b.id_building
			where r.id_building = @Building_ID
		END
	ELSE
		
		BEGIN
			print('Building not found, impossibile to see all the rooms')
			return null;
			
		END
END

GO
USE [master]
GO
ALTER DATABASE [RBS] SET  READ_WRITE 
GO
