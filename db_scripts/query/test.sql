exec df.resource_create 'Andrea', 'Guzzo', 1
exec df.resource_create 'Salvatore', 'Albore', 0
exec df.resource_create 'Edoardo', 'Tiboldo', 0

exec df.resource_list

exec df.resource_delete NULL, NULL, 'guzzoan1', NULL
exec df.resource_delete NULL, NULL, NULL, 'andrea.guzzo@reti.it'

exec df.resource_Detail @Name = 'Andrea', @Surname = 'Guzzo'
exec df.resource_detail NULL, NULL, NULL, 'edoardo.tiboldo@reti.it'
exec df.resource_detail NULL, NULL, 'alborsa1', NULL

exec df.building_create @Name = 'Edificio 1', @Address = 'Via Giuseppe Mazzini, 11, 21052 Busto Arsizio VA'
exec df.building_create @Name = 'Villa', @Address = 'Via Dante Alighieri, 6, 21052 Busto Arsizio VA'
exec df.building_create @Name = 'Edificio 3', @Address = 'Via Fratelli Cairoli, 4, 21052 Busto Arsizio VA'

exec [df].[building_delete] @Name = 'Edificio 1'
exec [df].[building_detail]  @Name = 'Edificio 1'

exec df.building_list


exec df.room_create 'R101', 50, 'Edificio 1'
exec df.room_detail ''

DECLARE @t int
exec @t = df.room_getID 'R101' 
print(@t)

DECLARE @t int
exec @t = df.check_names 'Andrea', 'Guzzo', 's'
print(@t)

select *
from df.Resources

select *
from df.Buildings

select r.*, b.name
from df.Rooms as r
inner join df.Buildings as b
on r.id_building = b.id_building

select * from df.udf_reservation_search('06/08/2019','06/08/2019')



exec df.reservation_create 'Percorso Circolare', 'Seconda lezione del percorso circolare', 'guzzoan1', 'R101', '10/08/2019 09:00:00', '10/08/2019 18:00:00'

select *
from df.reservations


exec df.reservation_list '06/08/2019 09:00:00', '06/08/2019 18:00:00', 'guzzoan1'

begin tran
delete from df.Resources where username = 'guzzoan1'
select * from df.Resources

rollback tran

select *
from df.Buildings

begin tran	

alter table df.Rooms nocheck constraint all
alter table df.Reservations nocheck constraint all

--Remove all the rooms associated with the building
DELETE FROM df.Rooms where id_building = 2

--Remove the building
DELETE from df.Buildings where id_building = 2
print('Resource deleted with ID:' + cast(2 as varchar(2)))


alter table df.Rooms check constraint all
alter table df.Reservations check constraint all

rollback tran

begin tran
UPDATE df.Rooms
SET id_building = NULL
where id_building = 2
rollback tran


begin tran

select *
from df.Reservations

--Remove all the rooms associated with the building
DELETE FROM df.Rooms where id_building = 2

--Remove the building
DELETE from df.Buildings where id_building = 2
print('Resource deleted with ID:' + cast(2 as varchar(2)))

select *
from df.Reservations

select *
from df.Resources

rollback tran


begin tran

select *
from df.Resources

DELETE FROM df.Reservations where id_reservation = 1

select *
from df.Resources

select *
from df.Rooms
rollback tran


