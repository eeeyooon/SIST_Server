
-- C:\class\server\JSPTest\todo.sql

create table tblTodo (
    seq number primary key,                                 --번호(PK)
    todo varchar2(300) not null,                            --할일
    regdate date default sysdate,                           --날짜
    priority char(1) default 'B' not null,
    complete char(1) default 'n' not null                   --완료 유무(y-완료, n-미완료)
);

create sequence seqTodo;



drop table tblTodo;
select * from tblTodo;































