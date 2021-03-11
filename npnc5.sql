CREATE database npnc DEFAULT CHARACTER SET utf8 COLLATE UTF8_GENERAL_CI;
USE npnc;
CREATE TABLE member( -- 회원정보  테이블 
	id VARCHAR(100) PRIMARY KEY,
	pw VARCHAR(100) NOT NULL,
	NAME VARCHAR(100) NOT NULL, 
	idnum VARCHAR(13) NOT NULL UNIQUE, -- 주민등록번호 
	email VARCHAR(100),
	address VARCHAR(100),
	phonenum VARCHAR(15) NOT NULL,
	usergrade int not NULL DEFAULT 4
);
CREATE TABLE category(
   idx INT PRIMARY KEY AUTO_INCREMENT, -- 카테고리 idx 
   maincategory VARCHAR(100) NOT NULL, -- 대분류 
   NAME VARCHAR(100) NOT NULL, -- 카테고리 이름 
   readgrade INT NOT NULL DEFAULT 4, -- 읽기등급 
   writegrade INT NOT NULL DEFAULT 4 -- 쓰기등급 
);

CREATE TABLE board( -- 게시판 테이블 
   idx INT PRIMARY KEY AUTO_INCREMENT, -- 글번호 
   title VARCHAR(100) NOT NULL,
   id VARCHAR(100) NOT NULL, -- 작성자 
   content TEXT,
   regDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성시간 
   hit INT DEFAULT 0, -- 조회수 
   FILE VARCHAR(100),
   category INT NOT NULL,
   FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE,
   FOREIGN KEY(category) REFERENCES category(idx) ON DELETE CASCADE
);
CREATE TABLE reply( -- 댓글 테이블 
	ridx INT PRIMARY KEY AUTO_INCREMENT, -- 댓글 번호 
	bidx INT NOT NULL, -- 게시글 번호 
	id VARCHAR(100) NOT NULL, -- 댓글 작성자 
	content TEXT,
	regDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성시간 
	foreign key(id) references member(id) on delete CASCADE,
	FOREIGN KEY(bidx) REFERENCES board(idx) ON DELETE CASCADE
);

CREATE TABLE gob( -- 게시글 좋아요 or 싫어요 테이블 
	idx INT, -- 게시글 번호 
	id VARCHAR(100), -- 좋아요 누른 사용자 
	gob BOOLEAN, -- 좋아요 ture 싫어요 false
	PRIMARY KEY(idx,id),
	FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE,
	FOREIGN KEY(idx) REFERENCES board(idx) ON DELETE CASCADE
);

CREATE TABLE rgob( -- 댓글 좋아요 or 싫어요 테이블 
	ridx INT, -- 답글번호 
	id VARCHAR(100), -- 좋아요 누른 사용자 
	gob BOOLEAN, -- 좋아요 ture 싫어요 false
	PRIMARY KEY(ridx,id),
	FOREIGN key(id) REFERENCES member(id) on DELETE CASCADE, -- member의 id행이 삭제되면 id가 같은 행을 삭제 
	FOREIGN KEY(ridx) REFERENCES reply(ridx) ON DELETE CASCADE -- reply의 ridx행이 삭제되면 ridx가 같은 행을 삭제 
);



INSERT into category VALUES(NULL,'[직거래]수도권','강남.서초.강동.송파',0,0);
INSERT into category VALUES(NULL,'[직거래]수도권','금천.구로.강서.양천',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]수도권','마포.은평.서대문구',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]수도권','중구.종로.동대문구',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]수도권','성북.성동.광진.용산',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]수도권','중랑.강북.노원.도봉',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]수도권','동작.관악.영등포구',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','부산광역시',1,1);
INSERT into category VALUES(NULL,'[직거래]지방권','대구광역시',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','울산광역시',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','대전광역시',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','광주광역시',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','경상도지역',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','전라도지역',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','충청도지역',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','제주지역',DEFAULT,DEFAULT);
INSERT into category VALUES(NULL,'[직거래]지방권','강원도지역',DEFAULT,DEFAULT);
INSERT into member VALUES('joo333','3333','김연주','3333333333333',NULL,NULL,'01033333333',0);
INSERT into member VALUES('test111','1111','테스트일','1111111111111',NULL,NULL,'01011111111',1);
INSERT into member VALUES('test222','2222','테스트이','2222222222222',NULL,NULL,'01022222222',DEFAULT);

-- member테이블에 grade컬럼, category테이블에 readgrade,writegrade와 join해서 사용 
CREATE TABLE grade(
	grade INT PRIMARY KEY,
	name VARCHAR(50)
);
INSERT INTO grade VALUES(0,'관리자');
INSERT INTO grade VALUES(1,'우수회원');
INSERT INTO grade VALUES(2,'정회원');
INSERT INTO grade VALUES(3,'준회원');
INSERT INTO grade VALUES(4,'신입회원');
INSERT INTO grade VALUES(100,'계정정지');





INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','내용입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','내용2입니다',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[강북구] 서울시 강북구 미아동 sk북한산시티 아파트 전세 있습니다.(43평)','joo333','
▶  피터팬 APP, WEB 동시 노출 동의 여부 (Y / N) :  

▶  주소 : 서울시 강북구 미아동 1353

▶  건물형태 : 

▶  거래 유형 : 전세 

▶  가격 :  6억2천

▶  방개수 : 4개

▶  옵션정보 : 화장실 2개, 계단식

▶  관리비 : 20만원 내외

▶  관리비 포함내역 : 

▶  층수 : 6층 

▶  면적 : 142/ 43평

▶  난방 방식 : 개별난방도시가스

▶  주차 가능 :  지하주차장 연결 되어있습니다.

▶  이사가능일 : 4월 10일 이후 협의 가능합니다.

▶  문의 연락처 :  01034257658

​

▶  상세설명 : 

​

- 조명은 모두 LED조명으로 교체되어있고, 

집 자체가 엄청 밝습니다.

- 정남향으로 햇빛 잘드는건 당연하고 그래서 난방을 낮에는 안틀어도 됩니다.

- 풀 인테리어로 집 상태가 매우 좋습니다.

- 솔샘역 160m 거리로 지하철역이 매우 가까워서 

매우 편합니다.

- 43평 지하주차장 연결동(106,107,110,111동) 중 지하철 / 단지 내 주상가, 벽산 주상가 가장 가깝습니다.

- 삼각산초 중학교 품고있으며 삼각산 초 중학교는 강북에서 가장 좋은 학군 입니다.

- 태양열 설치 해서 전기세 정말 조금 나옵니다.',DEFAULT,DEFAULT,NULL,1);

INSERT INTO board VALUES(NULL,'[영등포구] [영등포구]중흥 s 클래스/귀한 신축전세/역세권','joo333','
▶  피터팬 APP, WEB 동시 노출 동의 여부 (Y / N) :  Y

▶  주소 : 서울시 영등포구 양평동1가 247

▶  건물형태 :  주상복합아파트

▶  거래 유형 :  협의

▶  가격 : 7억

▶  방개수 : 3개

▶  옵션정보 :  친환경마감, 확장, 에어컨 4대(거실, 각 방), (세탁기, 김치냉장고, TV 가능)

▶  관리비 : 

▶  관리비 포함내역 : 

▶  층수 :  중층

▶  면적 :  59m^2

▶  난방 방식 : 개별난방 

▶  주차 가능 :  세대당 1.35대

▶  이사가능일 :  4월~5월 가능

▶  문의 연락처 : 010-6401-2841

​

▶  상세설명 : 양평역 3분/ 협의가능 ',DEFAULT,DEFAULT,NULL,1);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);
INSERT INTO board VALUES(NULL,'[부산]아파트 부산시 북구 구포동 올수리 아파트 26평 매매합니다','test111','내용3입니다',DEFAULT,DEFAULT,NULL,8);



INSERT INTO gob VALUES(1,'joo333',TRUE);
INSERT INTO gob VALUES(1,'test111',TRUE);
INSERT INTO gob VALUES(1,'test222',FALSE);
INSERT INTO reply VALUES(NULL,1,'joo333','좋은 내용이네요',DEFAULT);
INSERT INTO reply VALUES(NULL,2,'joo333','좋은 내용이네요',DEFAULT);
INSERT INTO reply VALUES(NULL,1,'test111','동의합니다',DEFAULT);