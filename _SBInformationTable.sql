drop PROCEDURE _SBInformationTable;

DELIMITER $$
CREATE PROCEDURE _SBInformationTable
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
    
    DECLARE State INT;
    
    -- ---------------------------------------------------------------------------------------------------
    -- Check --
	call _SBInformationTable_Check
		(
			 InData_OperateFlag			
			,InData_Companyseq
			,InData_TableName		
	        ,InData_ChgTableName
			,InData_TableKorName				
			,InData_TableSeqColumn			
			,InData_TableSerlColumn			
			,InData_TableSubSerlColumn		
			,Login_UserSeq		
			,@Error_Check
		);
    

	IF( @Error_Check = (SELECT 9999) ) THEN
		
        SET State = 9999; -- Error 발생
        
	ELSE

	    SET State = 1111; -- 정상작동
        
		-- ---------------------------------------------------------------------------------------------------
		-- Save --
		IF( (InData_OperateFlag = 'S' OR InData_OperateFlag = 'D') AND STATE = 1111 ) THEN
			call _SBInformationTable_Save
				(
					 InData_OperateFlag		
					,InData_Companyseq     
					,InData_TableName		
			        ,InData_ChgTableName
					,InData_TableKorName				
					,InData_TableSeqColumn			
					,InData_TableSerlColumn			
					,InData_TableSubSerlColumn		
					,Login_UserSeq				
				);
		END IF;	
    
		-- ---------------------------------------------------------------------------------------------------
		-- Update --
		IF( InData_OperateFlag = 'U' AND STATE = 1111 ) THEN
			call _SBInformationTable_Update
				(
					 InData_OperateFlag	
                    ,InData_Companyseq
					,InData_TableName			
			        ,InData_ChgTableName
					,InData_TableKorName				
					,InData_TableSeqColumn			
					,InData_TableSerlColumn			
					,InData_TableSubSerlColumn		
					,Login_UserSeq				
				);		
		END IF;	    

	END IF;
END $$
DELIMITER ;