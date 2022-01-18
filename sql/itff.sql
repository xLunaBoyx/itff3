select * from movie;
desc movie;
insert into movie
values(1, '테스트', '영화', 'movie', sysdate, sysdate, '감독', '뭔데이건', '장르', '러닝타임', '15세', '이미지주소');

insert into movie
values(2, '테스트2', '영화2', 'movie2', sysdate, sysdate, '감독2', '뭐냐고', '장르2', '러닝타임2', '19세', '이미지주소2');


alter table movie
rename column title_kor to kor ;

create table movie(
        movie_id varchar2(100) default 'movie-'||lpad(seq_movie_no.nextval, 3, '0'),
        description varchar2(2500) not  null,
        title_kor varchar2(250)  not null,
        title_eng varchar2(250) not null,
        opening_date date,
        director varchar2(50),
        cast varchar2(500),
        genre varchar2(50),
        running_time varchar2(20),
        age_limit varchar2(20),
        image_url varchar2(300),
        constraint pk_movie_id primary key(movie_id)
);

create sequence seq_movie_no;



create table member(
        id varchar2(30),
        password varchar2(100),
        name varchar2(30),
        phone varchar2(11),
        gender char(1),
        email varchar2(50),
        birthday date,
        address varchar2(300),
        nickname varchar2(50),
        reg_date date,
        point number,
        enabled number default 1 not null,
        constraint pk_member_id primary key(id)
);

insert into member
values('admin', '1234', 'ITFF', '01012345678', 'M', 'admin@itff.com', '2000-01-01', '서울시 강남구', '관리자', sysdate, 10000);
insert into member
values('abcde', '1234', '알파벳', '01012345678', 'F', 'abcde@itff.com', '2010-10-10', '제주시 서귀포구', 'ABC', sysdate, 5000);
insert into member
values('qwerty', '1234', '쿼티', '01012345678', 'M', 'qwerty@itff.com', '1990-05-20', '서울시 금천구', '꾸어띠', sysdate, 3000);


-- 권한 테이블
-- member(1) - authorities(N) 관계 : 한 회원은 여러개의 권한을 가질 수 있다.
create table authorities(
    member_id varchar2(20),
    authority varchar2(20),
    constraint pk_authorities primary key(member_id, authority),
    constraint fk_authorities_member_id foreign key(member_id) references member(id)
);

insert into authorities values('admin', 'ROLE_USER');
insert into authorities values('admin', 'ROLE_ADMIN');
insert into authorities values('abcde', 'ROLE_USER');
insert into authorities values('qwerty', 'ROLE_USER');

select * from member;
select * from authorities;

update member
set password = '$2a$10$MB4MUotYW8SqixGCAKXemubGvkJR5MLwSntfyYm7fLDrvKJmuhy9.'
where id = 'qwerty';



 -- remember-me 기능을 위한 테이블 생성(테이블명과 컬럼명 그대로 사용할  것)
create table persistent_logins (
    username varchar(64) not null,    -- 아이디
    series varchar(64) primary key,    -- 고유 식별자
    token varchar(64) not null,    -- username, password, expire time 값을 hashing처리(단방향 암호화)한 값
    last_used timestamp not null   -- 마지막 접속시간
);
select * from point_history;
select count(*) from review_board where member_id = 'leecy';
select * from ticket_sharing_board;
select * from review_board;
select * from persistent_logins;
select * from movie;
select * from attachment;
select * from question_board;
update movie set title_eng = 'The thirteenth floor' where title_kor = '13층';
select * 
from movie_schedule a left join movie b on a.movie_id = b.movie_id where start_date = '2022-01-09' order by start_date, start_time;
select * from goods_order;
select * from movie;
select * from goods_cart;
select * from save_notify;
select * from member;
select * from authorities;
delete from authorities where member_id = 'yeonsu5087';
delete from member where id='yeonsu5087';
select * from question_board;
delete from question_board where question_no = 45;
select * from ticket_sharing_board;