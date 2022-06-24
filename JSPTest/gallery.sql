--C:\class\server\JSPTest\gallery.sql

create table tblGallery (
    
            seq number primary key,                     --번호(PK)
            filename varchar2(100) not null,       --이미지 파일명(하드 디스크에 저장된 이름)
            subject varchar2(100) not null,         --제목(이미지 설명)
            regdate date default sysdate              --작성시각
            
);

create sequence seqGallery;


--질의