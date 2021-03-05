CREATE database npnc DEFAULT CHARACTER SET utf8 COLLATE UTF8_GENERAL_CI;;
USE npnc;
CREATE TABLE member( -- 회원정보  테이블 
	id VARCHAR(100) PRIMARY KEY,
	pw VARCHAR(100) NOT NULL,
	NAME VARCHAR(100) NOT NULL, 
	idnum VARCHAR(13) NOT NULL UNIQUE, -- 주민등록번호 
	email VARCHAR(100),
	address VARCHAR(100),
	phonenum VARCHAR(15) NOT NULL
);

CREATE TABLE board( -- 게시판 테이블 
	idx INT PRIMARY KEY AUTO_INCREMENT, -- 글번호 
	title VARCHAR(100) NOT NULL,
	id VARCHAR(100) NOT NULL, -- 작성자 
	content TEXT,
	regDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성시간 
	hit INT DEFAULT 0, -- 조회수 
	FILE VARCHAR(100),
	category VARCHAR(100) NOT NULL,
	foreign key(id) references member(id) on delete CASCADE
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
