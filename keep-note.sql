CREATE TABLE user (
    user_id int NOT NULL AUTO_INCREMENT,
    user_name varchar(20),
    user_added_date date,
    user_password varchar(20),
    user_mobile varchar(18),
    PRIMARY KEY (user_id)
    );
    
CREATE TABLE note (
    note_id int NOT NULL AUTO_INCREMENT,
    note_title varchar(90),
    note_content varchar(500),
    note_status varchar(20),
    note_creation_date date,
    PRIMARY KEY (note_id)
    );
    
CREATE TABLE category (
category_id int NOT NULL AUTO_INCREMENT,
category_name varchar(90),
category_descr varchar(90),
category_creation_date date,
category_creator varchar(90),
PRIMARY KEY (category_id)
);

CREATE TABLE reminder (
    reminder_id int NOT NULL AUTO_INCREMENT,
    reminder_name varchar(90),
    reminder_descr varchar(90),
    reminder_type varchar(90),
    reminder_creation_date date,
    reminder_creator varchar(90),
    PRIMARY KEY (reminder_id)
    );
    
CREATE TABLE notecategory (
   notecategory_id int NOT NULL AUTO_INCREMENT,
   note_id int,
   category_id int,
   PRIMARY KEY (notecategory_id)
);

CREATE TABLE notereminder (
    notereminder_id int NOT NULL AUTO_INCREMENT,
    note_id int,
    reminder_id int,
    PRIMARY KEY (notereminder_id)
);

CREATE TABLE usernote (
    usernote_id int NOT NULL AUTO_INCREMENT,
    user_id int,
    note_id int,
    PRIMARY KEY (usernote_id)
);


INSERT INTO user(`user_id`, `user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES (1, 'amol', '11-12-2019', '12345678', 'user_mobile')
INSERT INTO user(`user_id`, `user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES (1, 'amol', '2019-11-19', '12345678', '9923188034');
INSERT INTO user(`user_id`, `user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES (1, 'megha', '2019-11-19', '12345678', '9923188034');
INSERT INTO user(`user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES ('abhilash', '2019-11-19', 'password', '8547126845');	
INSERT INTO user(`user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES ('ajit', '2019-11-19', 'admin', '7784584125');	
INSERT INTO user(`user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES ('sushma', '2019-11-19', 'admin', '6652315487');

INSERT INTO category(`category_id`, `category_name`, `category_descr`, `category_creation_date`, `category_creator`)
 VALUES (1,'Category-1','First Category Test','2019-11-19','amol')
INSERT INTO category( `category_name`, `category_descr`, `category_creation_date`, `category_creator`)
VALUES ('Category-1','First Category Test','2019-11-19','ajit')

INSERT INTO reminder(`reminder_id`, `reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`)
 VALUES (1,'Reminder 1','Reminder 1 Test','Type - 1','2019-11-19','amol');
INSERT INTO reminder(`reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`)
 VALUES ('Reminder 2','Reminder 2 Test','Type - 2','2019-11-19','ajit');
 
INSERT INTO note(`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`)
 VALUES (1,'test1','Testing note content','complete','2019-11-19');
INSERT INTO note( `note_title`, `note_content`, `note_status`, `note_creation_date`)
 VALUES ('test2','Testing note content2','complete','2019-11-20');
 
INSERT INTO usernote(`usernote_id`, `user_id`, `note_id`)
 VALUES (1,1,1);
INSERT INTO usernote(`user_id`, `note_id`)
 VALUES (2,2);
 
INSERT INTO notereminder(`notereminder_id`, `note_id`, `reminder_id`) 
VALUES (1,1,1);
INSERT INTO notereminder(`note_id`, `reminder_id`) 
VALUES (2,2);

INSERT INTO notecategory(`notecategory_id`, `note_id`, `category_id`) 
VALUES (1,1,1);
INSERT INTO notecategory(`note_id`, `category_id`) 
VALUES (2,2);

select * from user where user_id= 1 and user_password='12345678';

select * from note where note_creation_date='2019-11-19';

select * from category where category_creation_date = '2019-11-18';

select note_id from usernote where note_id=2;

update note set note_content='updated content' where note_id='3';

select * from note inner join usernote on usernote.note_id = note.note_id
where usernote.user_id=3

SELECT * FROM keepnote.note 
inner join notecategory on note.note_id = notecategory.note_id
inner join category on notecategory.category_id = category.category_id
where category.category_name='Category-1';

SELECT * FROM reminder
inner join notereminder on reminder.reminder_id = notereminder.reminder_id
where notereminder.note_id=1;

SELECT * FROM reminder
where reminder_id=1;

INSERT INTO user(`user_name`, `user_added_date`, `user_password`, `user_mobile`) 
VALUES ('kiran','2019-11-21','12345678','6652145875');
INSERT INTO note( `note_title`, `note_content`, `note_status`, `note_creation_date`)
VALUES ('test3','Testing note content3','pending','2019-11-21');
INSERT INTO note( `note_title`, `note_content`, `note_status`, `note_creation_date`)
VALUES ('test3','Testing note content3','pending','2019-11-21');

INSERT INTO category( `category_name`, `category_descr`, `category_creation_date`, `category_creator`)
VALUES ('Category-3','First Category Test','2019-11-21','megha');
INSERT INTO notecategory(`note_id`, `category_id`) 
VALUES (4,3);

INSERT INTO reminder(`reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`)
 VALUES ('Reminder 3','Reminder 3 Test','Type - 3','2019-11-19','rashmin');
 INSERT INTO notereminder(`note_id`, `reminder_id`) 
VALUES (4,3);

 delete from usernote where usernote_id = 2;
 delete from notecategory where notecategory_id=2
 delete from notereminder where notereminder_id=2;
 delete from note where note_id=2;
 
DELIMITER $$
CREATE TRIGGER `note_delete` 
AFTER DELETE ON note FOR EACH ROW
BEGIN
delete from usernote where note_id = old.note_id;
delete from notereminder where note_id=old.note_id;
delete from notecategory where note_id=old.note_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `user_delete` 
AFTER DELETE ON user FOR EACH ROW
BEGIN
DECLARE noteId INT DEFAULT 0;
SELECT note_id into noteId from usernote where user_id = old.user_id;
delete from note where note_id = noteId;
END$$
DELIMITER ;
