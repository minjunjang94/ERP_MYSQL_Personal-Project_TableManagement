drop PROCEDURE _SBInformationTable_Save;

DELIMITER $$
CREATE PROCEDURE _SBInformationTable_Save
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
    DECLARE Var_TableSeq			INT;
    DECLARE Var_GetDateNow			VARCHAR(100);

	SET Var_GetDateNow  		= (SELECT DATE_FORMAT(NOW(), "%Y-%m-%d %H:%i:%s") AS GetDate); -- 작업일시는 Save되는 시점의 일시를 Insert

    -- ---------------------------------------------------------------------------------------------------
    -- Insert --
	IF( InData_OperateFlag = 'S' ) THEN
		INSERT INTO _TCBaseTables 
		( 	 
			 TableName				-- 테이블Name
			,TableKorName			-- 테이블명칭
			,TableSeqColumn			-- 테이블NameSeq
			,TableSerlColumn		-- 테이블NameSerl
			,TableSubSerlColumn		-- 테이블NameSerlSub
			,LastUserSeq			-- 작업자
			,LastDateTime			-- 작업일시
        )
		VALUES
		(
			 InData_TableName			
			,InData_TableKorName		
			,InData_TableSeqColumn			
			,InData_TableSerlColumn	
            ,InData_TableSubSerlColumn
			,Login_UserSeq	
			,Var_GetDateNow		
		);
        
        SELECT '저장이 완료되었습니다' AS Result;

	-- ---------------------------------------------------------------------------------------------------        
    -- Delete --
	ELSEIF ( InData_OperateFlag = 'D' ) THEN  

		SET Var_TableSeq = (SELECT A.TableSeq FROM _TCBaseTables AS A WHERE A.TableName = InData_TableName);  
      
		DELETE FROM _TCBaseTables AS A WHERE A.TableName = InData_TableName;

        SELECT '삭제되었습니다.' AS Result; 
        
	END IF;	
    
END $$
DELIMITER ;