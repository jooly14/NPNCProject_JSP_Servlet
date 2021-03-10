SELECT REPLACE(content,'\r\n','<br>') FROM board;


SELECT FOUND_ROWS();
(SELECT idx,gob,COUNT(id) FROM gob GROUP BY idx, gob) AS g;
(SELECT bidx, COUNT(bidx) AS repcnt FROM reply GROUP BY bidx) AS reply;
SELECT bidx, COUNT(bidx) FROM reply GROUP BY bidx;
SELECT * FROM gob;
SELECT * FROM board;

DELETE FROM gob WHERE id = 'jyp333';


SELECT * FROM category ORDER BY maincategory;
update category SET maincategory = '[직거래]수도권' WHERE maincategory='수도권';
update category SET maincategory = '[직거래]지방권' WHERE maincategory='지방권';
update category SET name = '강남.서초.강동.송파' WHERE maincategory='[직거래]수도권';

[전세]강남.서초.강동.송파 새 게시글
[전세]금천.구로.강서.양천 새 게시글
[전세]마포.은평.서대문구 새 게시글
[전세]중구.종로.동대문구 새 게시글
[전세]성북.성동.광진.용산 새 게시글
[전세]중랑.강북.노원.도봉 새 게시글
[전세]동작.관악.영등포구 새 게시글


[직거래]부산광역시 새 게시글
[직거래]대구광역시 새 게시글
[직거래]울산광역시 새 게시글
[직거래]대전광역시 새 게시글
[직거래]광주광역시 새 게시글
[직거래]경상도지역 새 게시글
[직거래]전라도지역 새 게시글
[직거래]충청도지역 새 게시글
[직거래]강원도지역 새 게시글
[직거래]제주지역 새 게시글


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