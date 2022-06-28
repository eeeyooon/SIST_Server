
--Toyproject/script.sql

drop table tblUser;

select * from tblUser;

--회원 테이블
create table tblUser (
    id varchar2(30) primary key,
    pw varchar2(30) not null,
    name varchar2(30) not null,
    lv char(1) not null,                            --등급(1. 일반회원, 2. 관리자)
    pic varchar2(100) default 'pic.png' not null,
    regdate date default sysdate not null,
    active char(1) default 'y' not null                             --탈퇴 유무 (y:활동중, n:탈퇴)

);


insert into tblUser(id, pw, name, lv, pic, regdate) values ('hong', '1111', '홍길동', '1', default, default);

insert into tblUser(id, pw, name, lv, pic, regdate) values ('admin', '1111', '관리자', '2', default, default);


alter table tblUser 
        add (active char(1) default 'y' not null);

drop table tblBoard;

--게시판
create table tblBoard (
    seq number primary key,
    subject varchar2(300) not null,
    content varchar2(4000) not null,
    id varchar2(30) not null references tblUser(id),            --아이디(FK)
    regdate date default sysdate not null,                              --작성 시각     
    readcount number default 0 not null                                 --조회수
);

