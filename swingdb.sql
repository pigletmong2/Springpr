create sequence seq_board;

create table tbl_board(
bno number(10,0),
title varchar2(200) not null,
content varchar2(2000) not null,
writer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate);

alter table tbl_board add constraint pk_board
primary key(bno);

insert into tbl_board(bno,title,content,writer) values(seq_board.nextval,'테스트 제목','테스트내용','user00');
select*from tbl_board;
select count(*) from tbl_board;
commit;
select * from tbl_board;

select * from tbl_board order by bno desc;

select /*+INDEX_DESC (tbl_board pk_board) */* from tbl_board;

select /*+ FULL(tbl_board) */ * from tbl_board order by bno desc;

select /*+ INDEX_ASC(tbl_board pk_board) */ * from tbl_board where bno>0;

select /*+ INDEX_DESC(tbl_board pk_board) */ rownum rn,bno,title,content
from
tbl_board
where rownum<=10;

--아무 결과 안나옴
select /*+index_desc(tbl_board pk_board) */ rownum rn,bno,title,content
from
tbl_board
where rownum>10 and rownum<=20;

--rownum은 반드시 1이 포함되도록 해야 한다.
select /*+index_desc(tbl_board pk_board)*/ rownum rn,bno,title,content
from
tbl_board
where rownum<=20;

select rn,bno,title,content
from
(select /*+index_desc(tbl_board pk_board)*/ rownum rn,bno,title,content
from
tbl_board
where rownum<=20 and title like '%테스트%')
where rn>0;

select rn,bno,title,content
from
(select /*+index_desc(tbl_board pk_board)*/ rownum rn,bno,title,content
from
tbl_board
where 
title like '%테스트%' or content like '%테스트%'
and rownum<=20)
where rn>10;
-- and연산자가 or연산자보다 우선 순위가 높기 때문에 'rownum'이 20보다 작거나 같으면서(and)
-- 내용에 '테스트'가 들어있거나, 제목에 '테스트' 문자열을 포함하는 게시물을 검색함
-- 따라서 10개 데이터가 아닌 더 많은 양의 데이터를 출력

--정상적으로 처리하기 위해서는 ()를 이용해서 or조건을 처리해야만 한다.
select rn,bno,title,content from
(select /*+index_desc(tbl_board pk_board)*/
rownum rn,bno,title,content from
tbl_board
where
(title like '%테스트%' or content like '%테스트%')
and rownum<=20
)
where rn>10;


