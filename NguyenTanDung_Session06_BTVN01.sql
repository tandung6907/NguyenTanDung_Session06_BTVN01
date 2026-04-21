use homework_ss6;

create table cities(
	city_id			int primary key,
    city_name		varchar(255) not null
);

create table bookings_2(
	booking_id		int primary key,
    city_id			int not null,
    total_price		decimal(19,4) not null,
    `status`		varchar(255) not null,
    
    constraint fk_tx_city
    foreign key (city_id) references cities(city_id)

	constraint chk_tx_price
	check (total_price > 0)
); 

insert into cities (city_id, city_name) 
values
	(1, 'Ha Noi'),
	(2, 'Ho Chi Minh'),
	(3, 'Da Nang'),
	(4, 'Hai Phong'),
	(5, 'Can Tho');
    
insert into bookings_2 (booking_id, city_id, total_price, `status`) 
values
	-- Ha Noi (city_id = 1)
	(1, 1, 1236.5000, 'completed'),
	(2, 1, 20036.0000, 'completed'),
	(3, 1, 15036.7500, 'uncompleted'),
	(4, 1, 30036.0000, 'completed'),

	-- Ho Chi Minh (city_id = 2)
	(5, 2, 50036.0000, 'completed'),
	(6, 2, 25036.2500, 'completed'),
	(7, 2, 10036.0000, 'uncompleted'),

	-- Da Nang (city_id = 3)
	(8, 3, 18036.000036, 'completed'),
	(9, 3, 22036.500036, 'completed'),
	(10, 3, 9036.000036, 'uncompleted'),
	(11, 3, 14036.0000, 'completed'),
	(12, 3, 7536.7500, 'completed'),

	-- Hai Phong (city_id = 4)
	(13, 4, 16036.0000, 'completed'),
	(14, 4, 8036.0000, 'uncompleted'),
	(15, 4, 21036.0000, 'completed'),

	-- Can Tho (city_id = 5)
	(16, 5, 13036.0000, 'completed'),
	(17, 5, 9536.5000, 'completed'),
	(18, 5, 6036.0000, 'uncompleted'),
	(19, 5, 17536.2500, 'completed'),
	(20, 5, 22036.0000, 'completed');

select * from cities c
join bookings_2 b on c.city_id = b.city_id;

select 
	c.city_name,
    sum(b.total_price)		as 'Revenue'
from bookings_2 b
join cities c on c.city_id = b.city_id
where `status` = 'completed' and (select sum(total_price) from bookings_2) > 30
group by city_name; 
-- hàm tổng hợp không được đứng trong where 
-- cách xử lý: có thể dùng truy vấn lồng để trả ra được giá tổng để so sánh với 30 tại trạng thái completed
