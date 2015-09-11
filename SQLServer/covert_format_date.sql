select convert(char, getdate(), 100) "mes dia año hh:mmAM (or PM)"
select convert(char, getdate(), 101) "mes/dia/año"
select convert(char, getdate(), 102) "año.mes.dia"
select convert(char, getdate(), 103) "dia/mes/año"
select convert(char, getdate(), 104) "dia.mes.año"
select convert(char, getdate(), 105) "dia-mes-año"
select convert(char, getdate(), 106) "dia mes año"
select convert(char, getdate(), 107) "mes dia, año"
select convert(char, getdate(), 108) "hh:mm:ss"
select convert(char, getdate(), 109) "mes dia año hh:mm:ss:mmmAM (or PM)"
select convert(char, getdate(), 110) "mes-dia-año"
select convert(char, getdate(), 111) "año/mes/dia"
select convert(char, getdate(), 112) "añomesdia"
select convert(char, getdate(), 113) "dia mes año hh:mm:ss:mmm"
select convert(char, getdate(), 114) "hh:mm:ss:mmm(24h)"
select convert(char, getdate(), 120) "año-mes-dia hh:mm:ss(24h)"
select convert(char, getdate(), 121) "año-mes-dia hh:mm:ss.mmm"
--
declare @fecha varchar(29)
set @fecha = '20110103232219'
select convert(datetime, substring(@fecha,1,8)+' '+substring(@fecha,9,2)+':'+substring(@fecha,11,2)+':'+substring(@fecha,13,2)) as "año-mes-dia hh:mm:ss(24h)"
--
declare @fecha varchar(30)
set @fecha = '20110103232219'
select convert(datetime, substring(@fecha, 1,8)) as "año-mes-dia hh:mm:ss(24h)"
--
declare @fecha varchar(15)
set @fecha = '23.01.2010'
select convert(datetime, replace(@fecha, '.', '/'), 103) as "año-mes-dia hh:mm:ss(24h)"
------------------------------------------------------------------------------------------------------------------------------------
select convert(char(10), current_timestamp, 23) "aaaa-mm-dd"
select convert(char(10), current_timestamp, 101) "mm/dd/aaaa"
select convert(char(10), current_timestamp, 102) "aaaa.mm.dd"
select convert(char(10), current_timestamp, 103) "dd/mm/aaaa"
select convert(char(10), current_timestamp, 104) "dd.mm.aaaa"
select convert(char(10), current_timestamp, 105) "dd-mm-aaaa"
select convert(char(10), current_timestamp, 110) "mm-dd-aaaa"
select convert(char(10), current_timestamp, 111) "aaaa/mm/dd"
select convert(char(8), current_timestamp, 112) "aaaammdd"

select convert(char(19), current_timestamp, 20) "aaaa-mm-dd hh:mm:ss (h 1-24)"
select convert(char(23), current_timestamp, 21) "aaaa-mm-dd hh:mm:ss.mss (h 1-24)"
select convert(char(23), current_timestamp, 25) "aaaa-mm-dd hh:mm:ss.mss (h 1-24)"
select convert(char(19), current_timestamp, 120) "aaaa-mm-dd hh:mm:ss (h 1-24)"
select convert(char(23), current_timestamp, 121) "aaaa-mm-dd hh:mm:ss.mss (h 1-24)"
select convert(char(23), current_timestamp, 126) "aaaa-mm-dd?hh:mm:ss.mss (h 1-24)"

select convert(char(8), current_timestamp, 1) "mm/dd/aa"
select convert(char(8), current_timestamp, 2) "aa.mm.dd"
select convert(char(8), current_timestamp, 3) "dd/mm/aa"
select convert(char(8), current_timestamp, 4) "dd.mm.aa"
select convert(char(8), current_timestamp, 5) "dd-mm-aa"
select convert(char(8), current_timestamp, 10) "mm-dd-aa"
select convert(char(8), current_timestamp, 11) "aa/mm/dd"
select convert(char(6), current_timestamp, 12) "aammdd"
select convert(char(20), current_timestamp, 22) "mm/dd/aa h:mm:ss (h 1-12)"

select convert(char(19), current_timestamp, 0) "mes dd aaaa h:mmpm (h 1-12)"
select convert(char(9), current_timestamp, 6) "dd mes aa"
select convert(char(10), current_timestamp, 7) "mes dd, aa"
select convert(char(26), current_timestamp, 9) "mes dd aaaa h:mm:ss:mss (h 1-12)"
select convert(char(24), current_timestamp, 13) "dd mes aaaa hh:mm:ss:mss (h 1-24)"
select convert(char(26), current_timestamp, 109) "mes dd aaaa h:mm:ss:mss (h 1-12)"
select convert(char(19), current_timestamp, 100) "mes dd aaaa h:mm (h 1-12)"
select convert(char(11), current_timestamp, 106) "dd mes aaaa"
select convert(char(12), current_timestamp, 107) "mes dd,aaaa"
select convert(char(24), current_timestamp, 113) "dd mes aaaa hh:mm:ss:mss (h 1-24)"

select convert(char(8), current_timestamp, 8 ) "hh:mm:ss (h 1-24)"
select convert(char(12), current_timestamp, 14) "hh:mm:ss:mss (h 1-24)"
select convert(char(8), current_timestamp, 24) "hh:mm:ss (h 1-24)"
select convert(char(8), current_timestamp, 108) "hh:mm:ss (h 1-24)"
select convert(char(12), current_timestamp, 114) "hh:mm:ss:mss (h 1-24)"