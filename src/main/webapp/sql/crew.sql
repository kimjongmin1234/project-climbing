CREATE TABLE CREW (
    CREW_NUM INT PRIMARY KEY,               -- 크루 PK
    CREW_NAME VARCHAR(250) NOT NULL,        -- 크루 이름
    CREW_DESCRIPTION CLOB,                  -- 크루 설명
    CREW_MAX_MEMBER_SIZE INT NOT NULL,      -- 크루 최대 인원수
    CREW_LEADER VARCHAR(100) NOT NULL,      -- 크루 리더 PK
    CREW_BATTLE_STATUS CHAR(1) DEFAULT 'F' CHECK (CREW_BATTLE_STATUS IN ('T', 'F')),  -- 크루 배틀 상태
    CREW_PROFILE VARCHAR(2048) DEFAULT NULL -- 크루 프로필
);
--크루 PK로 크루 검색 CREW_NUM
SELECT CREW_NUM,CREW_NAME,CREW_DESCRIPTION,CREW_MAX_MEMBER_SIZE,CREW_LEADER,CREW_BATTLE_STATUS,CREW_PROFILE FROM CREW WHERE CREW_NUM = 1

SELECT 
CREW_NUM,CREW_NAME,CREW_DESCRIPTION,CREW_MAX_MEMBER_SIZE,CREW_LEADER,CREW_BATTLE_STATUS,CREW_PROFILE,
(SELECT count(*) from member where MEMBER_CREW_NUM = 5)
FROM CREW WHERE CREW_NUM = 5

SELECT
			    C.CREW_NUM,    
			    COUNT(M.MEMBER_ID) AS CREW_CURRENT_MEMBER_SIZE
			FROM
			    CREW C
			LEFT JOIN
			    MEMBER M ON M.MEMBER_CREW_NUM = C.CREW_NUM
			WHERE
			    C.CREW_NUM = 1
			GROUP BY
			    C.CREW_NUM

INSERT INTO CREW(CREW_NUM, CREW_NAME, CREW_MAX_MEMBER_SIZE, CREW_LEADER, CREW_PROFILE) 
VALUES 
(1,'코마장', 10, 'coma@naver.com', 'sample.jpg');

SELECT * FROM CREW;

--(페이지네이션) 크루 전체 목록
SELECT
	RN,
	CREW_NUM,
    CREW_NAME,
    CREW_DESCRIPTION,
    CREW_MAX_MEMBER_SIZE,
    CREW_LEADER,
    CREW_BATTLE_STATUS,
    CREW_PROFILE
FROM (
    SELECT 
        CREW_NUM,
    	CREW_NAME,
    	CREW_DESCRIPTION,
    	CREW_MAX_MEMBER_SIZE,
    	CREW_LEADER,
    	CREW_BATTLE_STATUS,
    	CREW_PROFILE,
        ROW_NUMBER() OVER (ORDER BY CREW_NUM) AS RN
    FROM 
        BOARD
)
WHERE RN BETWEEN 1 AND 10;

--크루 총 개수
SELECT COUNT(*) AS CREW_TOTAL FROM CREW;

--특정 크루의 인원수
SELECT
	COUNT(*) AS CREW_CURRENT_MEMBER_SIZE
FROM
	CREW C
JOIN
	MEMBER M
ON
	M.MEMBER_CREW_NUM = C.CREW_NUM
WHERE
	C.CREW_NUM = ?


SELECT * FROM CREW;

DROP TABLE CREW;