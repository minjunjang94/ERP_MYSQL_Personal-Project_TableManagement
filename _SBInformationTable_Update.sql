drop PROCEDURE _SBInformationTable_Update;

DELIMITER $$
CREATE PROCEDURE _SBInformationTable_Update
	(
		 InData_OperateFlag				CHAR(2)			-- 작업표시
		,InData_Companyseq				INT				-- 법인내부코드
		,InData_TableName				VARCHAR(100)	-- (기존)테이블Name
        ,InData_ChgTableName			VARCHAR(100)	-- (변경)테이블Name
		,InData_TableKorName			VARCHAR(100)	-- 테이블명칭
		,InData_TableSeqColumn			VARCHAR(100)	-- 테이블NameSeq
		,InData_TableSerlColumn			VARCHAR(100)	-- 테이블NameSerl
		,InData_TableSubSerlColumn		VARCHAR(100)	-- 테이블NameSerlSub
		,Login_UserSeq					INT				-- 현재 로그인 중인 유저
    )
BEGIN

	-- 변수선언
    DECLARE Var_GetDateNow			VARCHAR(100);    
    DECLARE Var_TableSeq			INT;
    
	SET Var_GetDateNow  = (SELECT DATE_FORMAT(NOW(), "%Y-%m-%d %H:%i:%s") AS GetDate); -- 작업일시는 Update 되는 시점의 일시를 Insert
	SET Var_TableSeq = (SELECT A.TableSeq FROM _TCBaseTables AS A WHERE A.TableName = InData_TableName);   
    
    -- ---------------------------------------------------------------------------------------------------
    -- Update --
	IF( InData_OperateFlag = 'U' ) THEN     
			UPDATE _tcbasetables			AS A
			   SET   A.TableName			= InData_ChgTableName
			 	    ,A.TableKorName			= InData_TableKorName
			 	    ,A.TableSeqColumn		= InData_TableSeqColumn
			 	    ,A.TableSerlColumn		= InData_TableSerlColumn
				    ,A.TableSubSerlColumn	= InData_TableSubSerlColumn
				    ,A.LastUserSeq			= Login_UserSeq
				    ,A.LastDateTime			= Var_GetDateNow          
			WHERE  A.TableSeq				= Var_TableSeq;
                     
              SELECT '저장되었습니다.' AS Result; 
                     
	ELSE
			  SELECT '저장이 완료되지 않았습니다.' AS Result;
	END IF;	


END $$
DELIMITER ;