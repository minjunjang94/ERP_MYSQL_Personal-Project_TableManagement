drop PROCEDURE _SBInformationTable_Query;

DELIMITER $$
CREATE PROCEDURE _SBInformationTable_Query
	(
		 InData_TableName				VARCHAR(100)	-- 테이블Name
		,InData_TableKorName			VARCHAR(100)	-- 테이블명칭
		,Login_UserSeq					INT				-- 현재 로그인 중인 유저
    )
BEGIN    

	IF (InData_TableName 		IS NULL OR InData_TableName 	LIKE ''	) THEN	SET InData_TableName 		= '%'; END IF;
 	IF (InData_TableKorName 	IS NULL OR InData_TableKorName 	LIKE ''	) THEN	SET InData_TableKorName 	= '%'; END IF;
    
    -- ---------------------------------------------------------------------------------------------------
    -- Query --
  
    set session transaction isolation level read uncommitted;  
    -- 최종조회 --
    SELECT 
		 A.TableSeq				AS TableSeq			
		,A.TableName			AS TableName
		,A.TableKorName			AS TableKorName
		,A.TableSeqColumn		AS TableSeqColumn
		,A.TableSerlColumn		AS TableSerlColumn
		,A.TableSubSerlColumn	AS TableSubSerlColumn
		,B.UserName				AS LastUserName
		,B.UserSeq				AS LastUserSeq
		,A.LastDateTime			AS LastDateTime
	FROM _TCBaseTables 					AS A
	LEFT OUTER JOIN _TCBaseUser			AS B    ON  B.UserSeq		    = A.LastUserSeq
    WHERE A.TableName 				LIKE InData_TableName
      AND A.TableKorName			LIKE InData_TableKorName;

	set session transaction isolation level repeatable read;
    
END $$
DELIMITER ;