
INSERT INTO category VALUES(NULL,'메인카테고리1','카테고리이름',DEFAULT,DEFAULT);
delete from category where maincategory ='메인카테고리1';

SELECT * FROM member;


SELECT * FROM grade;
SELECT m.*,g.name FROM member m INNER JOIN grade g ON m.usergrade = g.grade;


SELECT c.*, t.cnt FROM category AS c left outer JOIN (SELECT category,COUNT(*) AS cnt FROM board GROUP BY category) AS t ON c.idx=t.category ORDER BY maincategory,idx




-- 보내야되는 쿼리
CREATE TABLE grade(
	grade INT PRIMARY KEY,
	name VARCHAR(50)
);
INSERT INTO grade VALUES(0,'관리자');
INSERT INTO grade VALUES(1,'정회원');