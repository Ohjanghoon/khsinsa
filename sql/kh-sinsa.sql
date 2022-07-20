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
    inquire_no varchar2(100) not null,
    user_id varchar2(100) not null,
    inquire_answer_ref varchar2(100),
    inquire_title varchar2(200),
    inquire_content varchar2(4000),
    inqure_date date not null,
    inquire_category varchar2(30) not null,

    constraint pk_inquire_no primary key(inquire_no),
    constraint fk_user_id_04 foreign key (user_id) references kh_user(user_id),
    constraint fk_inquire_answer_ref foreign key (inquire_answer_ref) references inquire (inquire_no) on delete cascade
);

-- 1:1 문의 첨부파일 -- 
create table inquire_attachment(
        inq_attachment_no number ,
        inquire_no varchar2(100), 
        inq_original_filename varchar2(255),
        inq_rename_filename varchar2(255),
        constraint pk_inq_attachment_no primary key(inq_attachment_no),
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
    notice_no varchar2(100),
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

-- 1:1문의, 게시글, 리뷰 작성 (장훈 0718)
desc inquire;
desc inquire_attachment;
select * from inquire;
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'ohjang12', null, '문의합니다!', '문희는 포도가 머꼬찌푼데!', default, '상품하자'); 
insert into inquire values('S10' || seq_inquire_inquire_no.nextval, 'admin123', 'S103', '조용하세요!', '조용하시라구요!', default, '상품하자'); 
commit;

-- 정보공유 게시판 테스트 게시글 3개 추가
select * from community;
desc community;
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '커뮤니티 테스트 입니다.', '살려주세요..', default, default, default);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '커뮤니티 테스트 입니다.', '죄송합니다 뚝배기만은..', default, default, default);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '커뮤니티 테스트 입니다.', '아니에요 깨주세요 뚝배기..', default, default, default);
commit;

-- 상품 7/19--
insert into product values ('A10'||seq_product_pro_no.nextval,'상의','체커보드 모노그램 데님 반팔셔츠 NY (L.Blue)',159000,'L',default,'MLB는 140년 전통의 American Sports Lifestyle을 상징하는 Major League Baseball의 클래식 헤리티지를 현대적으로 재해석하여 모던하고 스포티한 스타일을 완성하고자 합니다.');
insert into product values ('A10'||seq_product_pro_no.nextval,'상의', '베이직 테리 오버핏 베이스볼 셔츠 LA (L.Green)',119000,'L',default,'MLB는 140년 전통의 American Sports Lifestyle을 상징하는 Major League Baseball의 클래식 헤리티지를 현대적으로 재해석하여 모던하고 스포티한 스타일을 완성하고자 합니다.');
insert into product values ('A10'||seq_product_pro_no.nextval,'상의', 'OS LOGO RUGBY SHORT_BLACK/OFF WHITE',68000,'L',default,'80-90년대의 빈티지 럭비 티셔츠 제품에 적용 되어진 패턴을 적용하여 팔과 몸통 라인을 자연스럽게 연결, 착용시 편안함을 줄수 있는 패턴을 적용');
insert into product values ('A10'||seq_product_pro_no.nextval,'상의', 'Chilling Full Open T-Shirts [Mint]',68000,'L',default,'부드럽고 찰랑거리는 폴리/스판 혼방원단으로 제작된 칠링 풀 오픈 티셔츠 제품입니다.');
insert into product values ('A10'||seq_product_pro_no.nextval,'상의', '쿨메쉬 하프 니트 (IVORY)',89000,'L',default,'트랜디한 디자인에 통기성이 좋은 메쉬 조직으로 디자인되었습니다. 리얼 자개단추 사용으로 퀄리티를 높였으며, 여유있는 실루엣으로 편안한 착용감을 제공합니다.');
insert into product values ('A20'||seq_product_pro_no.nextval,'하의','WIDE SHORT PANTS / TAN',197000,'L',default,'리베레코리아의 22 핫 서머 컬렉션은 PLANLESS AND ENJOYMORE으로 계획 필요 없이 그냥 더 즐기자는 슬로건을 바탕으로 전개하였습니다. 리베레코리아의 자유로운 감성과 특유의 무드를 담아 캐주얼, 스트릿, 아웃도어 등 폭넓은 스타일링이 가능한 활용도 높은 아이템들을 선보입니다.');
insert into product values ('A20'||seq_product_pro_no.nextval,'하의','WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK',97000,'L',default,'이번 시즌 매스노운은 최근 현대 사회에 닥쳐온 무기력증과 우울감이라는 사회적 문제를 가먼츠로 표현하고자 정적인 무채색을 기반으로 트렌디한 디자인, 오버핏 실루엣에 매스노운 특유의 컨템포러리 스트릿 감성을 더했습니다.');
insert into product values ('A20'||seq_product_pro_no.nextval,'하의','와이드 테이퍼드 치노 팬츠 (라이트 그레이)',148000,'L',default,'클래식한 디자인의 치노 팬츠에 깊은 턱을 추가해대적인 실루엣으로 재해석한 아이템입니다. 살짝 큰 실루엣에 테이퍼드 핏을 가미하여 전체적인 밸런스 조절에 초점을 맞추고, 일반적인 치노 팬츠 보다 얇고 밀도감이 좋은 고급스러운 터치감의 패브릭을 사용해, 캐주얼과 컨템포러리 무드에 모두 어울릴 수 있도록 기획했습니다.');
insert into product values ('A20'||seq_product_pro_no.nextval,'하의','엘리건트 트라우저스 (BEIGE)',67000,'L',default,'고급스럽고 감각적인 진 팬츠의 트렌드를 선도하며 다양한 디테일을 특징으로 프리미엄진의 또 다른 스타일을 창조해낸 STRIKE.');
insert into product values ('A20'||seq_product_pro_no.nextval,'하의','에센셜 투턱 와이드 슬랙스 [딥베이지]',54300,'L',default,'우븐 소재의 투턱 와이드 슬랙스. 국내방 폴리 레이온 소재로 장시간 착용에도 편안한 피팅감. 유연하고 부드러운 원단 텍스쳐. 이중 핀턱 디테일의 발등을 덮는 와이드핏. 사선 방향의 옆면 포켓. 뒷면 웰트포켓. 컬렉션의 다른 아이템과 매치하여 완성된 스타일을 연출해보세요.');

-- 상품명 150 변경 --
desc product_attachment;
commit;
select * from product_attachment;
select * from product;

-- attachment 추가 --
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1033', '체커보드 모노그램 데님 반팔셔츠 NY (L.Blue).jpeg', '체커보드 모노그램 데님 반팔셔츠 NY (L.Blue).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1033', '체커보드 모노그램 데님 반팔셔츠 NY (L.Blue)1.jpeg', '체커보드 모노그램 데님 반팔셔츠 NY (L.Blue)1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1034', '베이직 테리 오버핏 베이스볼 셔츠 LA (L.Green).jpeg', '베이직 테리 오버핏 베이스볼 셔츠 LA (L.Green).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1034', '베이직 테리 오버핏 베이스볼 셔츠 LA (L.Green)1.jpeg', '베이직 테리 오버핏 베이스볼 셔츠 LA (L.Green)1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1023', 'OS LOGO RUGBY SHORT_BLACK/OFF WHITE.jpeg', 'OS LOGO RUGBY SHORT_BLACK/OFF WHITE.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1023', 'OS LOGO RUGBY SHORT_BLACK/OFF WHITE1.jpeg', 'OS LOGO RUGBY SHORT_BLACK/OFF WHITE1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1024', 'Chilling Full Open T-Shirts [Mint].jpeg', 'Chilling Full Open T-Shirts [Mint].jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1024', 'Chilling Full Open T-Shirts [Mint]1.jpeg', 'Chilling Full Open T-Shirts [Mint]1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1025', '쿨메쉬 하프 니트 (IVORY).jpeg', '쿨메쉬 하프 니트 (IVORY).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1025', '쿨메쉬 하프 니트 (IVORY)1.jpeg', '쿨메쉬 하프 니트 (IVORY)1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1025', '쿨메쉬 하프 니트 (IVORY)2.jpeg', '쿨메쉬 하프 니트 (IVORY)2.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1025', '쿨메쉬 하프 니트 (IVORY)3.jpeg', '쿨메쉬 하프 니트 (IVORY)3.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2026', 'WIDE SHORT PANTS / TAN.jpeg', 'WIDE SHORT PANTS / TAN.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2026', 'WIDE SHORT PANTS / TAN1.jpeg', 'WIDE SHORT PANTS / TAN1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2027', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK.jpeg', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2027', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK1.jpeg', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2027', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK2.jpeg', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK2.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2027', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK3.jpeg', 'WOOL BLENDED WIDE TUCK SHORT PANTS MSTSP006-BK3.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2037', '와이드 테이퍼드 치노 팬츠 (라이트 그레이).jpeg', '와이드 테이퍼드 치노 팬츠 (라이트 그레이).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2037', '와이드 테이퍼드 치노 팬츠 (라이트 그레이)1.jpeg', '와이드 테이퍼드 치노 팬츠 (라이트 그레이)1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2037', '와이드 테이퍼드 치노 팬츠 (라이트 그레이)2.jpeg', '와이드 테이퍼드 치노 팬츠 (라이트 그레이)2.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2037', '와이드 테이퍼드 치노 팬츠 (라이트 그레이)3.jpeg', '와이드 테이퍼드 치노 팬츠 (라이트 그레이)3.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2029', '엘리건트 트라우저스 (BEIGE).jpeg', '엘리건트 트라우저스 (BEIGE).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2029', '엘리건트 트라우저스 (BEIGE)1.jpeg', '엘리건트 트라우저스 (BEIGE)1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2036', '에센셜 투턱 와이드 슬랙스 [딥베이지].jpeg', '에센셜 투턱 와이드 슬랙스 [딥베이지].jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2036', '에센셜 투턱 와이드 슬랙스 [딥베이지]1.jpeg', '에센셜 투턱 와이드 슬랙스 [딥베이지]1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1023', 'OS LOGO RUGBY SHORT-BLACK-OFF WHITE.jpeg', 'OS LOGO RUGBY SHORT-BLACK-OFF WHITE.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1023', 'OS LOGO RUGBY SHORT-BLACK-OFF WHITE1.jpeg', 'OS LOGO RUGBY SHORT-BLACK-OFF WHITE1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2036', '에센셜 투턱 와이드 슬랙스(딥베이지).jpeg', '에센셜 투턱 와이드 슬랙스(딥베이지).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2036', '에센셜 투턱 와이드 슬랙스(딥베이지)1.jpeg', '에센셜 투턱 와이드 슬랙스(딥베이지)1.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2026', 'WIDE SHORT PANTS-TAN.jpeg', 'WIDE SHORT PANTS-TAN.jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A2026', 'WIDE SHORT PANTS-TAN1.jpeg', 'WIDE SHORT PANTS-TAN1.jpeg');


commit;
delete from product_attachment where pro_attachment_no=28;

insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1024', 'Chilling Full Open T-Shirts(Mint).jpeg', 'Chilling Full Open T-Shirts(Mint).jpeg');
insert into product_attachment values (seq_product_attachment_pro_attachment_no.nextval, 'A1024', 'Chilling Full Open T-Shirts(Mint)1.jpeg', 'Chilling Full Open T-Shirts(Mint)1.jpeg');

-- 리뷰 생성 --
insert into review values ('R10'||seq_review_review_no.nextval, 'A1023',101,'ohjang12', '넘나 멋져요.','반팔리뷰.jpg','반팔리뷰.jpg',default,default);

-- 주문 생성-
insert into kh_order values (010||seq_kh_order_order_no.nextval,'ohjang12','A1023','서울 강남구 가로수길 12', '01085674105','ojh9502@gmail.com',default,'빨리 주세요',68000,'배송완료',default);

select * from review;
select * from kh_order;

commit;

-- 커뮤니티 게시판 게시글 작성 추가 (장훈 0720)
select * from community;
insert into community values('C10' || seq_community_comm_no.nextval,  'tmddnjs12', '오늘의 꾸안꾸룩', '꾸?', default, default, default);
insert into community values('C50' || seq_community_comm_no.nextval,  'tmddnjs12', '유퀴즈 패션 토크토크', '유퀴즈 패션 토크토크', default, default, default);
insert into community values('C50' || seq_community_comm_no.nextval,  'tmddnjs12', '유퀴즈 패션 토크토크.', '유퀴즈 패션 토크토크', default, default, default);
insert into community values('C10' || seq_community_comm_no.nextval,  'tmddnjs12', '오늘의 꾸안꾸룩꾸룩', '꾸룩?', default, default, default);
insert into community values('C10' || seq_community_comm_no.nextval,  'tmddnjs12', '오늘의 꾸안꾸룩꾸루룩', '꾸루룩?', default, default, default);
insert into community values('C40' || seq_community_comm_no.nextval,  'tmddnjs12', '자유롭다', '졸리다', default, default, default);
insert into community values('C40' || seq_community_comm_no.nextval,  'tmddnjs12', '후리후리하다', '슬리피하다', default, default, default);
insert into community values('C10' || seq_community_comm_no.nextval,  'tmddnjs12', '오늘의 꾸안꾸룩꾸', '꾸룩꾸?', default, default, default);
insert into community values('C50' || seq_community_comm_no.nextval,  'tmddnjs12', '우영우 1화 패션 뭔가요?', '우영우 1화에서 초반에 운전할 때 상의 뭔가요?', default, default, default);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, default, default);
insert into community values('C10' || seq_community_comm_no.nextval,  'tmddnjs12', '오늘의 등원룩', '오늘의 5번째 학원 가는 날 코디에요', default, 21, 22);
insert into community values('C10' || seq_community_comm_no.nextval,  'tmddnjs12', '오늘의 등원룩', '오늘의 6번째 학원 가는 날 코디에요', default, 5, 12);
commit;

-- 커뮤니티 게시판 게시글 작성 추가 (장훈 0720)
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 5, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 7, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 221);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 0, 227);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 0, 212);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 0, 12);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 5, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 7, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 221);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 0, 227);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 0, 212);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 0, 12);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
insert into community values('C30' || seq_community_comm_no.nextval,  'tmddnjs12', '8월 강남 패션쇼 정보', '강남 KH 정보교육원에서 패션쇼 열린다고 하네요~', default, 3, 22);
commit;

-- 
alter table kh_order modify order_status varchar(100) default '주문 대기';
commit;
insert into kh_order values (10||seq_kh_order_order_no.nextval,?,?,?,?,?,default,?,?,default,?);

select * from kh_order;