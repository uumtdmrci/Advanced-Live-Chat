<cfcomponent>
  <cffunction name="getonay" access="remote" returnFormat="JSON" output="false" returntype="query">
  <cfargument name="sender_id" type="string" required="no">
    <cfargument name="message" type="string" required="no">
    <cfargument name="receiver_id" type="string" required="no">
      <cfquery name="add_message" datasource="next_destekportal" result="get_max">
          INSERT INTO
              CHATS
                (
                  SENDER_ID,
                  RECEIVER_ID,
                  MESSAGE,
                  SEND_DATE,
                  SEND_EMP
                )
              VALUES
                (
                  
                  #arguments.sender_id#,
                  #arguments.receiver_id#,
                  '#arguments.message#',
                  #now()#,
                  #arguments.sender_id#
                )
      </cfquery>
      <cfquery name="get_man_check" datasource="next_destekportal">
        SELECT * FROM MANAGERS WHERE MANAGER_ID = #arguments.sender_id# 
      </cfquery>
      <cfif get_man_check.manager_project neq 33 >
          <cfquery name="get_check_auto_mes" datasource="next_destekportal" >
            SELECT * FROM CHATS WHERE (SENDER_ID = #arguments.receiver_id# AND RECEIVER_ID =#arguments.sender_id#) OR  (SENDER_ID = #arguments.sender_id# AND RECEIVER_ID =#arguments.receiver_id#)
          </cfquery>
            <cfif get_check_auto_mes.recordcount eq 1>
                <cfquery name="add_message" datasource="next_destekportal">
                    INSERT INTO
                        CHATS
                          (
                            SENDER_ID,
                            RECEIVER_ID,
                            MESSAGE,
                            SEND_DATE,
                            SEND_EMP,
                            IS_AUTO
                          )
                        VALUES
                          (
                            
                            #arguments.receiver_id#,
                            #arguments.sender_id#,
                            'Next Station Destek Portalına Hoş Geldiniz , size en kısa sürede destek vereceğiz.',
                            #now()#,
                            #arguments.sender_id#,
                            1
                          )
                </cfquery>
             </cfif>
      </cfif> 
      <cfquery name="upd" datasource="next_destekportal">
            UPDATE MANAGERS SET
              IS_SOLVED = NULL
            WHERE MANAGER_ID IN (#arguments.receiver_id#)
      </cfquery>
      <cfquery name="select_message" datasource="next_destekportal">
            SELECT MESSAGE,LEFT(CONVERT(varchar,SEND_DATE,8),5) as SEND_DATE,ID,ISNULL(PHOTO_FILE,0) AS PHOTO_FILE FROM CHATS
            LEFT JOIN MANAGERS M ON M.MANAGER_ID = CHATS.RECEIVER_ID 
            WHERE ID = #get_max.identitycol#
      </cfquery>  
      
     <cfreturn select_message >  
</cffunction> 

 <cffunction name="upfile" access="remote" returnformat="JSON" output="false" returntype="string">
        <cfargument name="fileFieldName" type="string" required="true">
        <cfargument name="specname" required="no" type="any">

        <cffile action="upload"
                destination="D:\Sites\destekportal\destekportal\dist\assets\chat_files"
                fileField="#arguments.fileFieldName#"              
                nameconflict="MakeUnique"
                strict="true"
                result="local.result"
                allowedExtensions=".png,.jpg,.jpeg"
        >
        <cfset file_name = 'icerik_#createUUID()#'>
        <cffile action="rename" source="D:\Sites\destekportal\destekportal\dist\assets\chat_files/#local.result.serverfile#" destination="D:\Sites\destekportal\destekportal\dist\assets\chat_files/#file_name#.#local.result.serverfileext#">

        <!--- <cfquery name="instest" datasource="rugs_db" result="get_max">
            INSERT INTO TEST_TABLE
            (
                NAME
            )
            VALUES
            (
                '#arguments.specname#'
            )
        </cfquery>  
        <cfset max_id = get_max.identitycol>

        <cfquery name="getTesgt" datasource="rugs_db">
            SELECT * FROM TEST_TABLE WHERE ID = #max_id#
        </cfquery>  
        <cfset newdata = getTesgt.NAME>
       
        <cfreturn {
            "fileWasSaved": local.result.fileWasSaved,
            "serverFile": local.result.serverFile,
            "imageurl": '/documents/rugs/test/#file_name#.#local.result.serverfileext#',
            "newdata": newdata,
            "status":200
        } > --->
        <cfreturn '1'>
    </cffunction>
<cffunction name="getonay_photo" access="remote" returnFormat="JSON" output="false" returntype="query">
  <cfargument name="sender_id" type="string" required="no">
    <cfargument name="message" type="string" required="no">
    <cfargument name="receiver_id" type="string" required="no">
    
    <cfset image = imageReadBase64('#arguments.message#')/>
    <cfset createuuid = createUUID()/>
    <cfimage source="#image#" destination="D:\Sites\destekportal\destekportal\dist\assets\chat_images\#createuuid#.jpg" action="write">
    <cfquery name="add_message" datasource="next_destekportal" result="get_max">
          INSERT INTO
              CHATS
                (
                  SENDER_ID,
                  RECEIVER_ID,
                  MESSAGE,
                  SEND_DATE,
                  SEND_EMP,
                  PHOTO_FILE
                )
              VALUES
                (
                  
                  #arguments.sender_id#,
                  #arguments.receiver_id#,
                  '#createuuid#.jpg',
                  #now()#,
                  #arguments.sender_id#,
                  1
                )
      </cfquery>   
      <cfquery name="get_man_check" datasource="next_destekportal">
        SELECT * FROM MANAGERS WHERE MANAGER_ID = #arguments.sender_id# 
      </cfquery>
      <cfif get_man_check.manager_project neq 33 >
          <cfquery name="get_check_auto_mes" datasource="next_destekportal" >
            SELECT * FROM CHATS WHERE (SENDER_ID = #arguments.receiver_id# AND RECEIVER_ID =#arguments.sender_id#) OR  (SENDER_ID = #arguments.sender_id# AND RECEIVER_ID =#arguments.receiver_id#)
          </cfquery>
            <cfif get_check_auto_mes.recordcount eq 1>
                <cfquery name="add_message" datasource="next_destekportal">
                    INSERT INTO
                        CHATS
                          (
                            SENDER_ID,
                            RECEIVER_ID,
                            MESSAGE,
                            SEND_DATE,
                            SEND_EMP,
                            IS_AUTO
                          )
                        VALUES
                          (
                            
                            #arguments.receiver_id#,
                            #arguments.sender_id#,
                            'Next Station Destek Portalına Hoş Geldiniz , size en kısa sürede destek vereceğiz.',
                            #now()#,
                            #arguments.sender_id#,
                            1
                          )
                </cfquery>
             </cfif>
      </cfif> 
       <cfquery name="upd" datasource="next_destekportal">
            UPDATE MANAGERS SET
              IS_SOLVED = NULL
            WHERE MANAGER_ID IN (#arguments.receiver_id#)
      </cfquery>  
      <cfquery name="select_message" datasource="next_destekportal">
            SELECT MESSAGE,LEFT(CONVERT(varchar,SEND_DATE,8),5) as SEND_DATE,ID,PHOTO_FILE FROM CHATS
            LEFT JOIN MANAGERS M ON M.MANAGER_ID = CHATS.RECEIVER_ID 
            WHERE ID = #get_max.identitycol#
      </cfquery>  
      
     <cfreturn select_message >  
</cffunction> 
 

<cffunction name="getonay_file" access="remote" returnFormat="JSON" output="false" returntype="query">

    <cfargument name="sender_id" type="string" required="no">
    <cfargument name="message" type="string" required="no">
    <cfargument name="receiver_id" type="string" required="no">

      
      <!---   <cffile
          action="UPLOAD" 
          filefield="file" 
          destination="D:\Sites\destekportal\destekportal\dist\assets\chat_files" 
          mode="777" 
          nameconflict="MAKEUNIQUE"
          >
        
 
      <cfset file_name = 'photo_#arguments.message#'>
      <cffile action="rename" source="D:\Sites\destekportal\destekportal\dist\assets\chat_files" destination="D:\Sites\destekportal\destekportal\dist\assets\chat_files">
        
     --->
     <cfquery name="add_message" datasource="next_destekportal" result="get_max">
          INSERT INTO
              CHATS
                (
                  SENDER_ID,
                  RECEIVER_ID,
                  MESSAGE,
                  SEND_DATE,
                  SEND_EMP,
                  PHOTO_FILE
                )
              VALUES
                (
                  
                  #arguments.sender_id#,
                  #arguments.receiver_id#,
                  '#arguments.message#',
                  #now()#,
                  #arguments.sender_id#,
                  2
                )
      </cfquery>
      <cfquery name="get_man_check" datasource="next_destekportal">
        SELECT * FROM MANAGERS WHERE MANAGER_ID = #arguments.sender_id# 
      </cfquery>
      <cfif get_man_check.manager_project neq 33 >
          <cfquery name="get_check_auto_mes" datasource="next_destekportal" >
            SELECT * FROM CHATS WHERE (SENDER_ID = #arguments.receiver_id# AND RECEIVER_ID =#arguments.sender_id#) OR  (SENDER_ID = #arguments.sender_id# AND RECEIVER_ID =#arguments.receiver_id#)
          </cfquery>
            <cfif get_check_auto_mes.recordcount eq 1>
                <cfquery name="add_message" datasource="next_destekportal">
                    INSERT INTO
                        CHATS
                          (
                            SENDER_ID,
                            RECEIVER_ID,
                            MESSAGE,
                            SEND_DATE,
                            SEND_EMP,
                            IS_AUTO
                          )
                        VALUES
                          (
                            
                            #arguments.receiver_id#,
                            #arguments.sender_id#,
                            'Next Station Destek Portalına Hoş Geldiniz , size en kısa sürede destek vereceğiz.',
                            #now()#,
                            #arguments.sender_id#,
                            1
                          )
                </cfquery>
             </cfif>
      </cfif> 
       <cfquery name="upd" datasource="next_destekportal">
            UPDATE MANAGERS SET
              IS_SOLVED = NULL
            WHERE MANAGER_ID IN (#arguments.receiver_id#)
      </cfquery>  
      <cfquery name="select_message" datasource="next_destekportal">
            SELECT MESSAGE,LEFT(CONVERT(varchar,SEND_DATE,8),5) as SEND_DATE,ID,PHOTO_FILE FROM CHATS
            LEFT JOIN MANAGERS M ON M.MANAGER_ID = CHATS.RECEIVER_ID 
            WHERE ID = #get_max.identitycol#
      </cfquery>    
      
     <cfreturn select_message>  
</cffunction> 


<cffunction name="add_canned_message" access="remote" returnFormat="JSON" output="false" returntype="query">
    <cfargument name="ans" type="string" required="no">
        <cfquery name="add_answer" datasource="next_destekportal" result="get_max">
          INSERT INTO
              CANNED_ANSWER
                (
                  ANSWER ,
                  RECORD_DATE,
                  RECORD_EMP
                )
              VALUES
                (
                  '#arguments.ans#',
                  #now()#,
                  1000
                )
      </cfquery>  
       <cfquery name="ans_return" datasource="next_destekportal">
            SELECT ANSWER_ID,ANSWER FROM CANNED_ANSWER
            WHERE ANSWER_ID = #get_max.identitycol#
      </cfquery>  
      
     <cfreturn ans_return >  
</cffunction>


<cffunction name="update_managers" access="remote" returnFormat="JSON" output="false" returntype="query">
    <cfargument name="profile_name" type="string" required="no">
    <cfargument name="profile_project" type="string" required="no">
    <cfargument name="man_id" type="string" required="no">
        <cfquery name="upd_man" datasource="next_destekportal">
            UPDATE MANAGERS SET
              MANAGER_NAME = '#arguments.profile_name#',
              MANAGER_SURNAME = '#arguments.profile_surname#',
              MANAGER_PROJECT = #arguments.profile_project#
            WHERE MANAGER_ID = #arguments.man_id#
        </cfquery> 
        <cfquery name="select_man" datasource="next_destekportal">
            SELECT MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_,SP.PROJECT_NAME FROM  MANAGERS M
            LEFT JOIN SETUP_PROJECT SP ON SP.PROJECT_ID = M.MANAGER_PROJECT
            WHERE MANAGER_ID = #arguments.man_id#
        </cfquery>               
      <cfreturn select_man >  
</cffunction>


<cffunction name="message_is_view" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="ids" type="string" required="no">
        <cfquery name="upd__" datasource="next_destekportal">
            UPDATE CHATS SET
              IS_VIEW = 1,
              VIEW_DATE = #now()#
            WHERE ID IN (#arguments.ids#)
        </cfquery>         
     <cfset status = "1"> 
     <cfreturn status >  
</cffunction>


<cffunction name="delete_message" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="message_id" type="string" required="no">
      <cfquery name="add" datasource="next_destekportal">
             INSERT INTO
                DELETE_CHATS
              SELECT 
                SENDER_ID,RECEIVER_ID,IS_VIEW,VIEW_DATE,MESSAGE,SEND_DATE,SEND_EMP,GETDATE(),IS_AUTO 
              FROM CHATS 
              WHERE ID IN (#arguments.message_id#)
      </cfquery>  
      <cfquery name="upd__" datasource="next_destekportal">
            DELETE FROM CHATS  
              WHERE ID IN (#arguments.message_id#)
      </cfquery>
     <cfset status = "1"> 
     <cfreturn status >  
</cffunction>

<cffunction name="manager_check_login" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="number" type="string" required="no">
    
      <cfquery name="chck" datasource="next_destekportal">
            SELECT * FROM MANAGERS WHERE MANAGER_PHONE_CODE + MANAGER_PHONE = '#arguments.number#' AND IS_CHECK IS NULL
      </cfquery>
      <cfif chck.recordcount>
          <cfset status = "1"> 
      <cfelse>
        <cfset status = "0"> 
      </cfif>
    <cfreturn status >  
</cffunction>
<cffunction name="wait_manager_success" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="manager_id" type="string" required="no">
    <cfargument name="durum" type="string" required="no">
    <cfif arguments.durum eq 1>
      <cfquery name="chck" datasource="next_destekportal">
          UPDATE MANAGERS
          SET IS_CHECK = NULL 
          WHERE MANAGER_ID = #arguments.manager_id#
      </cfquery>
    <cfelse>
      <cfquery name="chck" datasource="next_destekportal">
          UPDATE MANAGERS
          SET IS_CHECK = 2
          WHERE MANAGER_ID = #arguments.manager_id#
      </cfquery>
    </cfif>
      <cfset status = "1"> 
     <cfreturn status >  
</cffunction>
<cffunction name="manager_add_login" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="name" type="string" required="no">
    <cfargument name="surname" type="string" required="no">
    <cfargument name="number" type="string" required="no">
    
      <cfquery name="chck" datasource="next_destekportal">
            SELECT * FROM MANAGERS WHERE MANAGER_PHONE_CODE + MANAGER_PHONE = '#arguments.number#'
      </cfquery>
      <cfif chck.recordcount>
          <cfset status = "0"> 
      <cfelse>
          <cfquery name="add" datasource="next_destekportal">
            INSERT INTO MANAGERS 
            (
              MANAGER_NAME,
              MANAGER_SURNAME,
              MANAGER_PHONE_CODE,
              MANAGER_PHONE,
              IS_CHECK
            )
            VALUES 
            (
              '#arguments.name#',
              '#arguments.surname#',
              '#left(arguments.number,3)#',
              '#right(arguments.number,7)#',
              1
            )
          </cfquery>
            <cfset status = "1"> 
       </cfif>  
      
    <cfreturn status >  
</cffunction>
<cffunction name="solved_message" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="solved_id" type="string" required="no">
      <cfquery name="upd" datasource="next_destekportal">
            UPDATE MANAGERS SET
              IS_SOLVED = 1
            WHERE MANAGER_ID IN (#arguments.solved_id#)
      </cfquery>  
    <cfset status = "1"> 
    <cfreturn status >  
</cffunction>

<cffunction name="delete_chat" access="remote" returnFormat="JSON" output="false" returntype="string">
    <cfargument name="chat_id" type="string" required="no">
      <cfquery name="get_ss" datasource="next_destekportal">
            SELECT * FROM CHATS WHERE (SENDER_ID = #arguments.chat_id#) OR  ( RECEIVER_ID =#arguments.chat_id#)
      </cfquery>  
      <cfset ids = valueList(get_ss.ID)>
      
        <cfquery name="add" datasource="next_destekportal">
          INSERT INTO
              DELETE_CHATS
            SELECT 
              SENDER_ID,RECEIVER_ID,IS_VIEW,VIEW_DATE,MESSAGE,SEND_DATE,SEND_EMP,GETDATE(),IS_AUTO 
            FROM CHATS 
            WHERE ID IN (#ids#)
        </cfquery> 
        <cfquery name="get_ss" datasource="next_destekportal">
            DELETE FROM CHATS WHERE ID IN (#ids#)
        </cfquery>  
    
    <cfset status = "1"> 
    <cfreturn status >  
</cffunction>

<cffunction name="loading_message" returnFormat="JSON" access="remote" output="false" returntype="any">
  <cfargument name="sender_id" type="string" required="no">
  <cfargument name="receiver_id" type="string" required="no"> 
      <cfquery name="getSize_" datasource="next_destekportal">
              SELECT  ID,MESSAGE,MM.MANAGER_PHOTO,LEFT(CONVERT(varchar,SEND_DATE,8),5) as SEND_DATE,ISNULL(PHOTO_FILE,0) AS PHOTO_FILE
              FROM CHATS
              LEFT JOIN MANAGERS MM ON MM.MANAGER_ID = CHATS.SENDER_ID
               WHERE 
                IS_VIEW  IS NULL AND
                RECEIVER_ID =#arguments.sender_id# AND 
                SENDER_ID = #arguments.receiver_id#
              ORDER BY SEND_DATE ASC
      </cfquery>

      <cfset var result=ArrayNew(1)>
    <cfloop query="getSize_">
        <cfset returnStruct = StructNew() />
        <cfset returnStruct["ID"] = ID/>
        <cfset returnStruct["MESSAGE"] = MESSAGE/>
        <cfset returnStruct["MANAGER_PHOTO"] = MANAGER_PHOTO/>
        <cfset returnStruct["SEND_DATE"] = SEND_DATE/>
        <cfset returnStruct["PHOTO_FILE"] = PHOTO_FILE/>
        <cfset ArrayAppend(result,returnStruct) />
    </cfloop>
     
      <cfscript>
          serializedStr=SerializeJSON(result,true);
          serializedStr=serializedStr.replace('//[','[');
          serializedStr='{"sizelist":'&serializedStr&'}';
      </cfscript>
   
      <cfreturn serializedStr />
</cffunction>

<cffunction name="loading_chats" returnFormat="JSON" access="remote" output="false" returntype="any">
    <cfargument name="sender_id" type="string" required="no">
    <cfargument name="end_ids" type="string" required="no">
    <cfif not len(arguments.end_ids)><cfset arguments.end_ids = 0></cfif>
      <cfquery name="getSize_" datasource="next_destekportal">
                SELECT 
                  MANAGER_ID,ID,MESSAGE,LEFT(CONVERT(varchar,SEND_DATE,8),5) as SEND_DATE,VIEW_COUNT.PIECE AS VIEW_COUNT ,MANAGER_PHOTO,MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_,ISNULL(PHOTO_FILE,0) AS PHOTO_FILE
                FROM MANAGERS
                  OUTER APPLY
                  (
                      SELECT  TOP 1
                        MESSAGE,SEND_DATE,ID ,PHOTO_FILE                                  
                      FROM 
                        CHATS C   
                      WHERE 
                      (C.SENDER_ID =  #arguments.sender_id# AND RECEIVER_ID =MANAGER_ID) OR  (C.SENDER_ID =MANAGER_ID AND RECEIVER_ID= #arguments.sender_id#)
                      ORDER BY SEND_DATE DESC
                  ) AS END_MESSAGE
                	OUTER APPLY (
                  SELECT COUNT(ID) AS PIECE FROM CHATS C
                  WHERE 
                    (C.SENDER_ID =  MANAGER_ID AND RECEIVER_ID =#arguments.sender_id#) AND IS_VIEW IS NULL
                  ) AS VIEW_COUNT
                WHERE END_MESSAGE.MESSAGE IS NOT NULL
                AND END_MESSAGE.ID NOT IN (#REReplace(arguments.end_ids, ",$", "")#) AND IS_SOLVED IS NULL
                ORDER BY SEND_DATE DESC 
      </cfquery> 
  
    <cfset var result=ArrayNew(1)>
    <cfloop query="getSize_">
        <cfset returnStruct = StructNew() />
        <cfset returnStruct["ID"] = ID/>
        <cfset returnStruct["MANAGER_ID"] = MANAGER_ID/>
        <cfset returnStruct["MANAGER_PHOTO"] = MANAGER_PHOTO/>
        <cfset returnStruct["NAME_"] = NAME_/>
        <cfset returnStruct["MESSAGE"] = MESSAGE/>
         <cfset returnStruct["SEND_DATE"] = SEND_DATE/>
         <cfset returnStruct["VIEW_COUNT"] = VIEW_COUNT/>
         <cfset returnStruct["PHOTO_FILE"] = PHOTO_FILE/>
        <cfset ArrayAppend(result,returnStruct) />
    </cfloop>
     
      <cfscript>
          serializedStr=SerializeJSON(result,true);
          serializedStr=serializedStr.replace('//[','[');
          serializedStr='{"sizelist":'&serializedStr&'}';
      </cfscript>  
    
      <cfreturn serializedStr />
</cffunction>

</cfcomponent>