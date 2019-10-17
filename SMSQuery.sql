
drop table sms_answer;
drop table sms_question;
drop table sms_essay;
drop table sms_field;
drop table sms_mentor_field;
drop table sms_follow;
drop table sms_meeting_cnt;
drop table sms_user_info;
drop table sms_meeting;
drop table sms_mentor;


drop sequence sms_mentor_seq;
drop sequence sms_meeting_seq;
drop sequence sms_essay_seq;
drop sequence sms_question_seq;
drop sequence sms_answer_seq;



CREATE TABLE sms_user_info (
   user_id   varchar2(50) primary key,--유저아이디
   user_name   varchar2(50),
   user_pass   varchar2(50),
   user_email   varchar2(50),
   user_image   varchar2(1000),
   user_phone   Varchar2(50)
);

create table sms_mentor(
    mentor_num number primary key,
    mentor_name VARCHAR2(50),
    mentor_co varchar2(100),
    mentor_dept varchar2(50),
    mentor_level varchar2(50),
    mentor_career varchar2(1000),
    mentor_info varchar2(1000),
    mentor_sub varchar2(100),
    mentor_image varchar2(1000),
    user_id varchar2(50)
);

create sequence sms_mentor_seq
start with 1
increment by 1
nocache
nocycle;


create table sms_follow(
mentor_num number,
user_id varchar2(50),
constraint follow_pk1 foreign key(mentor_num) references sms_mentor (mentor_num) on delete cascade,
constraint follow_pk2 foreign key(user_id) references sms_user_info (user_id) on delete cascade
);

create table sms_essay(
essay_num number primary key,
mentor_num number,
essay_subject clob,
essay_summary clob,
essay_content clob,
essay_date DATE,
essay_hit number,
essay_img varchar2(1000),
constraint sms_essay_fk foreign key (mentor_num) references sms_mentor(mentor_num)on delete cascade
);

create sequence sms_essay_seq
start with 1
increment by 1
nocache
nocycle;

CREATE TABLE sms_meeting (
   meeting_num   NUMBER   primary key,
   mentor_num   NUMBER,
   meeting_recruitment   number,
   meeting_price   number,
   meeting_title   varchar2(60),
   meeting_comment   clob,
   meeting_date   Varchar2(100),
   meeting_introduction   varchar2(500),
   meeting_place   varchar2(100),
   meeting_address   varchar2(100),
   meeting_img_name   varchar2(200),
   constraint sms_meeting_fk foreign key (mentor_num) references sms_mentor(mentor_num)on delete cascade
);

CREATE SEQUENCE  sms_meeting_seq
    MINVALUE 1
    MAXVALUE 999999
    INCREMENT BY 1
    START WITH 1
    CACHE 20
    NOORDER
    NOCYCLE ;

CREATE TABLE sms_meeting_cnt (
	meeting_num	NUMBER,
    constraint cnt_pk1 foreign key(meeting_num) references sms_meeting (meeting_num) on delete cascade,
	user_id 	varchar2(50),
    constraint cnt_pk2 foreign key(user_id) references sms_user_info (user_id) on delete cascade
);

create table sms_field(
field_num NUMBER primary key,
field_name VARCHAR2(50)
);

insert into sms_field values(1, '직무');
insert into sms_field values(2, '진로');
insert into sms_field values(3, '스펙');
insert into sms_field values(4, '외국어');
insert into sms_field values(5, '면접/자소서');
insert into sms_field values(6, '회사생활');
insert into sms_field values(7, '창업');
insert into sms_field values(8, '이직');
insert into sms_field values(9, '기타');


create table sms_mentor_field(
mentor_num NUMBER,
constraint mentor_field_pk1 foreign key(mentor_num) references sms_mentor (mentor_num) on delete cascade,
field_num NUMBER,
constraint mentor_field_pk2 foreign key(field_num) references sms_field (field_num)on delete cascade
);

create table sms_question (
question_num number primary key,
mentor_num number references sms_mentor(mentor_num) on delete cascade,
user_id varchar2(50) references sms_user_info(user_id) on delete cascade,
user_name varchar2(50),
question_title varchar2(300),
question_content varchar2(4000),
question_date DATE
);

create sequence sms_question_seq
start with 1
increment by 1
nocache
nocycle;


create table sms_answer(
answer_num number,
question_num number references sms_question(question_num) on delete cascade,
user_name varchar2(50),
user_image varchar2(255),
answer_content varchar2(4000),
answer_date DATE
);

create sequence sms_answer_seq
start with 1
increment by 1
nocache
nocycle;

commit;

select * from sms_mentor;