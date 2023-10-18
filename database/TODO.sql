create database TODO;

show databases;

use TODO;

show tables;

create table todoapp_todo(
	id int auto_increment primary key,
	userid varchar(100),
	title varchar(100),
	done tinyint(1),
	regdate datetime,
	moddate datetime
);

INSERT INTO todoapp_todo(userid, title, done, regdate, moddate) Values ('grace', '월요일 수업 듣기', true, now(), now());
INSERT INTO todoapp_todo(userid, title, done, regdate, moddate) Values ('hi', '맛점하기', true, now(), now());

commit;


DESC todoapp_todo; -- todoapp_todo 👍🏻제일 권장

SELECT * FROM todoapp_todo; -- todoapp_todo

CREATE database Jacobs;

