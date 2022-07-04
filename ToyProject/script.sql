
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

drop sequence seqBoard;

create sequence seqBoard;

select * from tblBoard order by seq desc;


--뷰 생성
create or replace view vwBoard
as
select seq, subject, content, id, (select name from tblUser where id = tblBoard.id) as name, regdate, readcount,
    (select count(*) from tblComment where pseq = tblBoard.seq) as commentcount,
    depth, (sysdate - regdate) as isnew, filename
    from tblBoard order by seq desc;



select * from vwBoard;


drop table tblComment;

--댓글 테이블
create table tblComment (

    seq number primary key,                                                         --댓글번호(PK)
    content varchar2(1000) not null,                                          --내용
    id varchar2(30) not null references tblUser(id),                --아이디(FK)
    regdate date default sysdate not null,                                   --날짜
    pseq number not null references tblBoard(seq)                  --부모글번호(FK)
    
);


create sequence seqComment;

drop sequence seqComment;



select * from tblComment;


--페이징
select * from (select a.*, rownum as rnum from vwBoard a) where rnum between 1 and 10;
select * from (select a.*, rownum as rnum from vwBoard a) where rnum between 11 and 20;
select * from (select a.*, rownum as rnum from vwBoard a) where rnum between 21 and 30;


drop table tblComment;
drop table tblBoard;




--게시판
create table tblBoard (
    seq number primary key,
    subject varchar2(300) not null,
    content varchar2(4000) not null,
    id varchar2(30) not null references tblUser(id),            --아이디(FK)
    regdate date default sysdate not null,                              --작성 시각     
    readcount number default 0 not null,                                 --조회수
    thread number not null,                                                         --답변형 게시판
    depth number not null                                                             --답변형 게시판
);

select nvl(max(thread), 0) as thread from tblBoard;


select * from tblBoard order by seq;




-- 새로운 게시판
create table tblBoard (
    seq number primary key,
    subject varchar2(300) not null,
    content varchar2(4000) not null,
    id varchar2(30) not null references tblUser(id),            --아이디(FK)
    regdate date default sysdate not null,                              --작성 시각     
    readcount number default 0 not null,                               --조회수
    thread number not null,                                                       --답변형 게시판
    depth number not null,                                                        --답변형 게시판
    filename varchar2(100) null,                                              --첨부파일
    orgfilename varchar2(100) null                                         --첨부파일(다운로드)
);


-- 해시 태그 테이블
create table tblHashTag (
    
    seq number primary key,                           --번호(PK)
    tag varchar2(100) unique not null           --해시 태그(UQ)

);


create sequence seqHashTag;


--게시판  < (연결) > 해시 태그


create table tblTagging (
    seq number primary key,                                                 --번호(PK)
    bseq number not null references tblBoard(seq),         --  게시물 (FK(
    hseq number not null references tblHashTag(seq)    --해시태그(FK)
);

create sequence seqTagging;





select * from tblBoard order by seq desc;

delete from tblBoard where seq = 324;

select * from tblHashTag;

select * from tblTagging;

delete from tblTagging where seq = 7;

--board <-> hash 테이블은  n:n 관계임    게시판(>|)- (o|<)해시
--1번글 > 맛집, 요리, 즐거움
--2번글 > 중국집, 짜장면, 맛집


--321번 게시글에 해당하는 태그들만 가져옴.
select tag  from tblHashTag h inner join tblTagging t on h.seq = t.hseq where bseq = 324;


--tag 검색하면 tag가 달린 게시글 전부 조회
select b.* from vwBoard b
    inner join tblTagging t
        on b.seq = t.bseq
            inner join tblHashTag h
                on h.seq = t.hseq
                    where h.tag = 'JSON';
        
        
create table 테이블 (
        번호
        아이디   hong    test
        좋아요   0             0
        싫어요  1              1
)

create table tblGoodBad (
    seq number primary key,                                                 --번호(PK)
    id varchar2(30) not null references tblUser(id),        --아이디(FK)
    bseq number not null references tblBoard(seq),        --글번호(FK)
    good number default 0 not null,                                     --좋아요
    bad number default 0 not null                                         --싫어요
    

);        

create sequence seqGoodBad;


select * from tblGoodBad order by seq asc;        
        
delete from tblGoodBad where seq = 10;

commit;

--한 사용자가 한 작성 글에 누른 좋아요, 싫어요 확인
select 
    tblBoard.*, 
    (select name from tblUser where id = tblBoard.id) as name, 
    nvl((select sum(good) from tblGoodBad where bseq = tblBoard.seq), 0) as good, 
    nvl((select sum(bad) from tblGoodBad where bseq = tblBoard.seq), 0) as bad, 
    (select
            case
                    when good = 1 then 1
                    when bad = 1 then 2
                    else 3
            end
            from tblGoodBad where bseq = tblBoard.seq and id = 'hong') as goodbad 
from tblBoard where seq = 321;




select * from tblTagging;               

select * from tblBoard;             --회원별 글쓴 횟수
select * from tblComment;      --회원별 댓글 횟수
select * from tblHashTag;       --태그별 카운트
select * from tblGoodBad;       --X


-- 회원별 글쓴 횟수
select u.id, (select name from tblUser where id = u.id) as name, (select count(*) from tblBoard where id = u.id) as cnt
    from tblBoard b right outer
        join tblUser u
            on u.id = b.id  
                group by u.id;


--회원별 댓글 횟수
select u.id, (select name from tblUser where id = u.id) as name, (select count(*) from tblComment where id = u.id) as cnt
    from tblComment c right outer
        join tblUser u
            on u.id = c.id  
                group by u.id;


--태그별 카운트 순위
select h.tag, (select count(*) from tblTagging where hseq = h.seq) as cnt
        from tblHashTag h 
                left outer join tblTagging t on h.seq = t.hseq 
                        group by h.tag, h.seq;



--맛집 지도(맛집 즐겨찾기)

create table tblFood (

        seq number primary key,                                                             --번호(PK)
        name varchar2(100) not null,                                                     --상호명
        lat number not null,                                                                        --위도(Latitude)
        lng number not null,                                                                    --경도(Longitude)
        star number(3) not null,                                                              --별점(1~5)
        category number not null references tblCategory(seq)        --업종    
        
);

alter table tblFood 
    modify (star number(3));

desc tblFood;


select * from tblFood;

create sequence seqFood;

create table tblCategory (

        seq number primary key,
        name varchar2(100) not null,
        marker varchar2(100) not null,
        icon varchar2(100) not null

);

select * from tblCategory;

insert into tblCategory values (1, '한식', 'm1', 'fa-solid fa-bowl-food');
insert into tblCategory values (2, '양식', 'm2', 'fa-solid fa-plate-utensils');
insert into tblCategory values (3, '카페', 'm3', 'fa-solid fa-cupcake');


commit;

delete from tblFood where seq = 2;

select tblFood.*, (select marker from tblCategory where seq = tblFood.category) as marker, (select icon from tblCategory where seq = tblFood.category) as icon from tblFood order by name asc;
