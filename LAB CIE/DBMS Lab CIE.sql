create database IF NOT exists food_database;

use food_database;

create table customer(customer_id int, delivery_address varchar(20), contact int,name varchar(20),primary key (customer_id));
insert into customer values(1,"ABCD",12345,"A");
insert into customer values(2,"HIJK",25789,"B");
insert into customer values(3,"WXYZ",16452,"C");
insert into customer values(4,"PQRS",89735,"D");
insert into customer values(5,"MNOP",48904,"E");

create table restaurant(r_id int,name varchar(20),loc varchar(20),primary key(r_id));
insert into restaurant values(1,"Pizzahut","MG road");
insert into restaurant values(2,"KFC","Bellandur");
insert into restaurant values(3,"MCD","Basvangudi");
insert into restaurant values(4,"Baskin Robin","Malleshwaram");

create table fooditem(name varchar(20),food_id int,cuisine varchar(20),r_id int,price int, primary key(food_id), foreign key (r_id) references restaurant(r_id));
insert into fooditem values("Pizza",1,"Italian",1,400);
insert into fooditem values("Burger",2,"American",2,230);
insert into fooditem values("Pasta",3,"Italian",1,350);
insert into fooditem values("Wings",4,"Mexican",3,200);
insert into fooditem values("Ice-cream",5,"Italian",4,150);
insert into fooditem values("Nuggets",6,"American",3,210);

select * from fooditem;

create table orders(order_id int,customer_id int,order_address varchar(20),r_id int,quantity int, food_id int, primary key(order_id), foreign key(r_id) references restaurant(r_id),foreign key(customer_id) references customer(customer_id),foreign key(food_id) references fooditem(food_id));
insert into orders values(1,3,"XYZ",2,1,4);
insert into orders values(2,1,"PQR",3,2,2);
insert into orders values(3,2,"STU",4,1,5);
insert into orders values(4,3,"XYZ",2,1,6);
insert into orders values(5,4,"LMN",1,3,1);
insert into orders values(6,3,"ABC",1,1,3);

create table order_status(order_id int, status varchar(20),update_time time,primary key(order_id, update_time),foreign key(order_id) references orders(order_id) on delete cascade);
insert into order_status values(1,"delivered",'08:30:45');
insert into order_status values(2,"cancelled",'17:13:39');
insert into order_status values(2,"initiated",'14:52:12');
insert into order_status values(1,"initiated",'12:29:36');
insert into order_status values(4,"initiated",'11:21:04');
insert into order_status values(4,"delivered",'00:13:40');
insert into order_status values(3,"preparing",'19:30:19');
insert into order_status values(3,"delivered",'20:29:30');
insert into order_status values(6,"initiated",'12:29:36');

create table payment(payment_id int,order_id int,amount int, primary key(payment_id),foreign key(order_id) references orders(order_id) on delete cascade);
insert into payment values(1,1,400);
insert into payment values(2,4,200);
insert into payment values(3,6,300);
insert into payment values(4,2,350);
insert into payment values(5,3,346);
insert into payment values(6,5,150);


select * from orders where customer_id=3;

select p.payment_id,p.order_id,p.amount from payment p join orders o on p.order_id=o.order_id;

delete o from orders o join order_status os on o.order_id = os.order_id where os.status = 'cancelled';

update fooditem set price=200 where food_id=2;