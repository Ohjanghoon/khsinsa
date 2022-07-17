create user khsinsa
identified by chan123456789A
default tablespace users;

alter user khsinsa quota unlimited on data;

grant connect, resource, create view  to khsinsa;

----------------------------계정생성 및 권한수정 완료 7/12 -----------------------------------

-- kh user 테이블 --
create table kh_user (
    user_id varchar2(100),
    enroll_date date default current_date,
    user_name varchar2(30) not null,
    user_pwd varchar2(500) not null,
    user_phone varchar2(11) not null,
    user_birthday date not null,
    user_email varchar2(100) not null,
    user_address varchar2(100) not null,
    user_del varchar2(1) default 'N',
    user_role varchar2(1) default 'U',

    constraint pk_user_id primary key (user_id),
    constraint ck_user_role check(user_role in ('U', 'A')),
    constraint ck_user_del check(user_del in ('Y', 'N')),
    constraint uq_user_email unique(user_email)
);

-- 커뮤니티 게시판 --
create table community (
    comm_no varchar2(100),
    user_id    varchar2(100)    not null,
    comm_title    varchar2(70)    not null,
    comm_content    varchar2(4000)    not null,
    comm_date date default current_date,
    comm_recommend    number default 0,
    comm_readCount     number    default 0,
    
    constraint pk_comm_no primary key(comm_no),
    constraint fk_user_id_01 foreign key(user_id) references kh_user(user_id)
);

-- 커뮤니티 댓글 --
create table comm_comment(
    comm_comment_no varchar2(100),
    comm_no varchar2(100) not null,
    user_id varchar2(100) not null,
    comm_comment_content varchar2(4000) not null,
    comm_comment_date date default current_date,
    comm_comment_level number default 1,
    comm_comment_ref varchar2(100),  
    
    constraint pk_comm_comment_no primary key(comm_comment_no),
    constraint fk_comm_no_01 foreign key(comm_no) references  community(comm_no) on delete cascade,
    constraint fk_user_id_02 foreign key(user_id) references  kh_user(user_id),
    constraint fk_comm_comment_ref foreign key(comm_comment_ref) references comm_comment (comm_comment_no) on delete cascade
);

-- 커뮤니티게시판 카테고리 -- 
create table comm_category(
    comm_no varchar2(100) not null,
    comm_category_name varchar2(50),
   
    constraint fk_comm_no_02 foreign key(comm_no) references community(comm_no)
);

-- 커뮤니티 첨부파일 --
create table comm_attachment(
    comm_attachment_no varchar2(100),
    comm_no varchar2(100) not null,
    comm_original_filename varchar2(255) not null,
    comm_rename_filename varchar2(255) not null,
    
    constraint pk_comm_attachment_no primary key(comm_attachment_no),
    constraint fk_comm_no_03 foreign key(comm_no) references community (comm_no) on delete cascade
);

-- 1:1 문의 --
create table inquire(
    inquire_no number not null,
    user_id varchar2(100) not null,
    inquire_answer_ref number,
    inquire_title varchar2(200),
    inquire_content varchar2(4000),
    inqure_date date not null,
    inquire_category varchar2(30) not null,

    constraint pk_inquire_no primary key(inquire_no),
    constraint fk_user_id_04 foreign key (user_id) references kh_user(user_id),
    constraint fk_inquire_answer_ref foreign key (inquire_answer_ref) references inquire (inquire_no) on delete cascade
);

-- 1:1 문의 첨부파일 -- 
create table inquire_attatchment(
        inq_attatchment_no number ,
        inquire_no number, 
        inq_original_filename varchar2(255),
        pro_rename_filename varchar2(255),
        constraint pk_inq_attatchment_no primary key(inq_attatchment_no),
        constraint fk_inquire_no_01 foreign key(inquire_no) references inquire (inquire_no) on delete cascade
);

-- 상품 --
create table product(
        pro_no varchar2(100) ,
        pro_type varchar2(30),
        pro_name varchar2(50) not null,
        pro_price number not null,
        pro_size varchar2(2) not null,
        reg_date date default current_date,
        pro_content varchar2(4000) not null,
        constraint pk_pro_no primary key(pro_no)
);

-- 상품 리뷰 --
create table review(
        review_no varchar2(100),
        pro_no varchar2(100) not null,
        order_no number not null,
        review_writer varchar2(15) not null,
        review_content varchar2(2000) not null,
        review_original_filename varchar2(255) not null,
        review_renamed_filename varchar2(255) not null,
        review_date date default current_date,
        review_recommend number default 0,
        constraint pk_review_no primary key (review_no),
        constraint fk_order_no_01 foreign key (order_no) references kh_order(order_no) on delete cascade,
        constraint fk_pro_no_01 foreign key(pro_no) references product(pro_no) on delete cascade
 );
 
 -- 상품 카테고리 -- 
 create table category(
        category_no varchar2(100),
        pro_no varchar2(100) not null,
        category_name varchar2(50) not null,

        constraint pk_category_no primary key (category_no),
        constraint fk_pro_no_02 foreign key (pro_no) references product(pro_no)
);

-- 상품 첨부파일 -- 
create table product_attachment(
        pro_attachment_no number,
        pro_no varchar2(100) not null,
        pro_original_filename varchar2(255) not null,
        pro_rename_filename varchar2(255) not null,
        constraint pk_pro_attachment_no primary key (pro_attachment_no),
        constraint fk_pro_no_03 foreign key (pro_no) references product(pro_no)
);

-- 관심상품 --
create table favorite(
        pro_no varchar2(100) not null,
        user_id varchar2(100) not null,
        constraint fk_pro_no_06 foreign key(pro_no) references product(pro_no),
        constraint fk_tb_user_01 foreign key(user_id) references kh_user(user_id)
);

-- 주문 --
create table kh_order(
        order_no number,
        user_id varchar2(100) not null,
        pro_no varchar2(100) not null,
        order_address varchar2(50) not null,
        order_phone varchar2(11) not null,
        order_email varchar2(100) not null,
        order_date date default current_date,
        order_req varchar2(100) not null,
        order_price number not null,
        order_status varchar2(100) not null, 
        order_amount number default 1,
        constraint pk_order_no  primary key(order_no),
        constraint fk_user_id_03 foreign key(user_id) references kh_user(user_id),
        constraint fk_pro_no_04 foreign key(pro_no) references  product(pro_no) on delete set null
);

-- 주문상품 관리 --
create table product_io(
    order_no number not null,
    pro_no varchar2(100) not null,
    constraint pk_product_io primary key(order_no, pro_no)
);

-- 장바구니 --
create table cart(
    user_id varchar2(100),
    pro_no varchar2(100),
    cart_buy_stock number default 1,
    cart_size varchar2(2) not null,
    
    constraint fk_user_id_05  foreign key (user_id) references kh_user(user_id),
    constraint fk_pro_no_05  foreign key (pro_no) references product(pro_no)
);

-- 신고 --
create table report(
        report_no varchar2(100) not null,
        report_content varchar2(4000) not null,
        report_date date default current_date 
);

-- 공지사항 --
create table notice(
    notice_no number,
    notice_title varchar2(70) not null,
    notice_content varchar2(4000) not null,
    notice_writer varchar2(100) not null,
    notice_date date default current_date,
    notice_read_count number  default 0,
    
    constraint pk_notice_no primary key (notice_no)  
);

-- 접속통계 --
create table connection_stats (
    session_id varchar2(1000),
    session_date date DEFAULT current_date,
    constraint pk_session_id primary key (session_id)
);

-- 시퀀스테이블 생성 7/17--
create sequence seq_community_comm_no;
create sequence seq_comm_comment_comm_comment_no;
create sequence seq_comm_attachment_comm_attachment_no;
create sequence seq_inquire_inquire_no;
create sequence seq_inquire_attatchment_inq_attatchment_no;
create sequence seq_product_pro_no;
create sequence seq_review_review_no;
create sequence seq_product_attachment_pro_attachment_no;
create sequence seq_kh_order_order_no;
create sequence seq_report_report_no;
create sequence seq_notice_notice_no;

-- 주문 상품관리 fk 추가 --
alter table product_io add constraint fk_order_no_02 foreign key(order_no) references kh_order(order_no);
alter table product_io add constraint fk_pro_no_07 foreign key(pro_no) references product(pro_no);

select * from kh_user;


-- 상품 테이블 추가 -- 
-- 상의 -- 
insert into product values ('A10'||seq_product_pro_no.nextval,'상의','마하그리드 반팔티 보라색',56000,'L',default,'마하그리드 반팔티 보라색 56000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','마하그리드 반팔티 크림색',56000,'L',default,'마하그리드 반팔티 크림색 56000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','마하그리드 반팔티 하얀색',56000,'L',default,'마하그리드 반팔티 하얀색 56000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','나이키 로고티셔츠 검은색',38000,'L',default,'나이키 로고티셔츠 검은색 38000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','나이키 로고티셔츠 하얀색',38000,'L',default,'나이키 로고티셔츠 검은색 38000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','아디다스 트랙탑 네이비',99000,'L',default,'아디다스 트랙탑 네이비 99000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','커버낫 카라집업 네이비',71200,'L',default,'커버낫 카라집업 네이비 71200');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','커버낫 카라집업 오트밀',71200,'L',default,'커버낫 카라집업 네이비 71200');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','컨버스 코믹후디 블랙',69000,'L',default,'컨버스 코믹후디 블랙 69000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','컨버스 코믹후디 화이트',69000,'L',default,'컨버스 코믹후디 화이트 69000');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','브라운브레스 니트 블루',62300,'L',default,'브라운브레스 니트 블루 62300');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','브라운브레스 니트 머스타드',62300,'L',default,'브라운브레스 니트 머스타드 62300');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10'||seq_product_pro_no.nextval,'상의','드로우핏 반팔 오버셔츠 네이비',49500,'L',default,'드로우핏 반팔 오버셔츠 네이비 49500');
insert into khsinsa.product (pro_no,pro_type,pro_name,pro_price,pro_size,reg_date,pro_content) values ('A10' || seq_product_pro_no.nextval,'상의','드로우핏 반팔 오버셔츠 블랙',49500,'L',default,'드로우핏 반팔 오버셔츠 블랙 49500');

commit;
select * from product;
select * from product where pro_no between 1 and 2;
select * from user_sequences;
select * from ( select row_number() over(order by pro_no desc) rnum, p.* from product p) p where rnum between ? and ?;

-- 초기 회원 데이터 삭제 (장훈 0717-1940)
delete from kh_user where user_id = 'admin';
delete from kh_user where user_id = 'user';
select * from kh_user;
update kh_user set user_role = 'A' where user_id = 'admin123';