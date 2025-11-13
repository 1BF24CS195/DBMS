create database IF NOT exists supplier_database;

use supplier_database;

create table suppliers(sid int,sname varchar(20), city varchar(20), primary key(sid));
insert into suppliers value(10001,"Acme Widget","Banglore");
insert into suppliers value(10002,"Johns","Kolkata");
insert into suppliers value(10003,"Vimal","Mumbai");
insert into suppliers value(10004,"Reliance","Delhi");

create table parts(pid int,pname varchar(20), color varchar(20), primary key(pid));
insert into parts value(20001,"Book","Red");
insert into parts value(20002,"Pen","Red");
insert into parts value(20003,"Pencil","Green");
insert into parts value(20004,"Mobile","Green");
insert into parts value(20005,"Charger","Black");

create table catalog(sid int,pid int,cost int,foreign key (sid) references suppliers(sid),foreign key (pid) references parts(pid));
insert into catalog value(10001,20001,10);
insert into catalog value(10001,20002,10);
insert into catalog value(10001,20003,30);
insert into catalog value(10001,20004,10);
insert into catalog value(10001,20005,10);
insert into catalog value(10002,20001,10);
insert into catalog value(10002,20002,20);
insert into catalog value(10003,20003,30);
insert into catalog value(10004,20003,40);

select distinct p.pname from parts p join catalog c on c.pid=p.pid;

select s.sname from suppliers s join catalog c on s.sid=c.sid 
group by s.sname having count(distinct c.pid) = (select count(*) from parts);

select s.sname from suppliers s join catalog c on s.sid=c.sid join parts p 
on p.pid=c.pid where color='Red'group by s.sname having 
count(distinct p.pid) = (select count(*) from parts where color='Red');

select p.pname from parts p join catalog c on p.pid=c.pid join suppliers s 
on s.sid=c.sid where s.sname='Acme Widget' and p.pid not in(select c2.pid 
from catalog c2 join suppliers s2 on s2.sid=c2.sid where s2.sname!='Acme Widget');

select distinct c.sid from catalog c where c.cost>(select avg(c2.cost) 
from catalog c2 where c2.pid=c.pid);

select p.pid,s.sname from catalog c join suppliers s on s.sid=c.sid 
join parts p on p.pid=c.pid where c.cost=(select max(c2.cost) from catalog c2
where c2.pid=c.pid);
