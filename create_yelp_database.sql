-- using mysql 5.7.11+
-- before logging into your database ...
-- mysql --username=username --password=user_password --local-infile=1
-- or if remotely to something like if youre using RDS
-- mysql --username=username -h db_hostname --port db_port --password=user_password --local-infile=1

-- Step 1 create database
drop database if exists yelp_db;
create database yelp_db;
use yelp_db;

-- Step 2 create businesses table
drop table if exists `businesses`;
create table `businesses` (
	`neighborhood` varchar(140) default null,
	`business_id` varchar(22) not null,
	`hours` LONGTEXT default null,
	`is_open` tinyint(1) not null,
	`address` varchar(140) not null,
	`attributes` LONGTEXT default null,
	`categories` LONGTEXT default null,
	`city` varchar(140) default null,
	`review_count` int(10) default 0 not null,
	`name` varchar(140) not null,
	`longitude` varchar(12) not null,
	`state` varchar(2) default null,
	`stars` float(2,1) default 0.0 not null,
	`latitude` varchar(12) not null,
	`postal_code` varchar(10) not null,
	`type` varchar(8) default "business" not null,
	primary key (business_id)
);

-- alter table businesses add bz_index index (business_id);

-- Step 3 add data to businesses table
load data local infile 'yelp_academic_dataset_business.csv' into table businesses columns terminated by '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- Step 4 create checkins table
drop table if exists `checkins`;
create table `checkins` (
	`time` LONGTEXT default null,
	`type` varchar(7) default "checkin" not null,
	`business_id` varchar(22) not null,
	foreign key (business_id) references businesses(business_id)
);

-- alter table checkins add bz_index index (business_id);

-- Step 5 add data to checkins table
load data local infile 'yelp_academic_dataset_checkin.csv' into table checkins columns terminated by '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- Step 6 create table users
drop table if exists `users`;
create table `users` (
	`yelping_since` varchar(10) not null,
	`useful` int(10) not null,
	`compliment_photos` int(10) default 0 not null,
	`compliment_list` int(10) default 0 not null,
	`compliment_funny` int(10) default 0 not null,
	`compliment_plain` int(10) default 0 not null,
	`review_count` int(10) default 0 not null,
	`elite` LONGTEXT default null,
	`fans` int(10) default 0 not null,
	`type` varchar(4) default "user" not null,
	`compliment_note` int(10) default 0 not null,
	`funny` int(10) default 0 not null,
	`compliment_writer` int(10) default 0 not null,
	`compliment_cute` int(10) default 0 not null,
	`average_stars` float(3,2) default 0.00 not null,
	`user_id` varchar(22) not null,
	`compliment_more` int(10) default 0 not null,
	`friends` LONGTEXT default null,
	`compliment_hot` int(10) default 0 not null,
	`cool` int(10) default 0 not null,
	`name` varchar(140) not null,
	`compliment_profile` int(10) default 0 not null,
	`compliment_cool` int(10) default 0 not null,
	primary key (user_id)
);

-- alter table users add uz_index index (user_id);

-- Step 7 add data to users table
load data local infile 'yelp_academic_dataset_user.csv' into table users columns terminated by '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

-- Step 8 create table tips
drop table if exists `tips`;
create table `tips` (
	`user_id` varchar(22) not null,
	`text` LONGTEXT not null,
	`business_id` varchar(22) not null,
	`likes` int(10) default 0 not null,
	`date` varchar(10) not null,
	`type` varchar(3) default "tip" not null,
	`tip_id` int NOT NULL AUTO_INCREMENT,
	primary key (tip_id),
	-- foreign key (user_id) references users(user_id),
	foreign key (business_id) references businesses(business_id)
);

-- alter table tips add bz_index index (business_id), add uz_index index (user_id);

-- Step 9 add data to tips table
load data local infile 'yelp_academic_dataset_tip.csv' into table tips columns terminated by '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
