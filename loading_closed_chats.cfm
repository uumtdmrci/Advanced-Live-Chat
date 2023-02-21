 
                    <cfquery name="managers" datasource="next_destekportal">
                            SELECT MANAGER_ID
                        ,MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_
                        ,MANAGER_PHOTO
                        ,NOT_VIEW_COUNT.PIECE AS IS_NOT_VIEW_COUNT
                        ,END_MESSAGE.SEND_DATE AS END_MESSAGE_DATE
                        ,END_MESSAGE.MESSAGE AS END_MESSAGE
                        ,END_MESSAGE.ID AS END_ID
                        FROM MANAGERS
                        OUTER APPLY
                        (
                            SELECT  TOP 1
                                MESSAGE,SEND_DATE,ID                                   
                            FROM 
                                CHATS C   
                            WHERE 
                                                                    
                            (C.SENDER_ID = 1000 AND RECEIVER_ID =MANAGER_ID) OR  (C.SENDER_ID =MANAGER_ID AND RECEIVER_ID=1000)

                            ORDER BY SEND_DATE DESC
                        ) AS END_MESSAGE
                        OUTER APPLY
                        (
                            SELECT COUNT(ID) AS PIECE FROM CHATS WHERE RECEIVER_ID = 1000 AND SENDER_ID = MANAGER_ID AND IS_VIEW IS NULL
                        ) AS NOT_VIEW_COUNT
                        WHERE IS_SOLVED = 1
                        ORDER BY END_MESSAGE_DATE DESC 
                </cfquery>
                <cfoutput query="managers">
                    <cfif len(END_MESSAGE)>
                      <li id="contact-id-close-#manager_id#" data-name="favorite" class="remove_class" onclick="close_message_button(#manager_id#)">             
                        <a href="javascript: void(0);" class="unread-msg-user"  >                  
                            <div class="d-flex align-items-center">            
                                <div class="chat-user-img online align-self-center me-2 ms-0">       
                                    <cfif len(MANAGER_PHOTO)>
                                        <img src="assets/images/users/#MANAGER_PHOTO#" class="rounded-circle avatar-xs" alt="">
                                    <cfelse>
                                        <img src="assets/images/users/user-dummy-img.jpg" class="rounded-circle avatar-xs" alt="">
                                    </cfif>
                                    <span class="user-status"></span>                   
                                </div>            
                                <div class="row d-flex align-items-center end_id_top#manager_id#">       
                                        <p class="text-truncate mb-0 manager_name_rename#manager_id#" >#NAME_# </p> 
                                        <p class="text-truncate mb-0" id="end-message-#manager_id#" style="width:10rem;word-wrap: break-word;">
                                            #END_MESSAGE# 
                                        </p> 
                                        <span class="end_message_id d-none" >#END_ID#,</span>       
                                </div>   
                                    
                                <div class="ms-auto"> 
                                    <span class="right font-size-11" style="float: right;" id="end-message-date-#manager_id#">
                                        <cfif dateFormat(end_message_date,'dd-mm-yyyy') eq dateFormat(now(),'dd-mm-yyyy')>
                                            #timeformat(END_MESSAGE_DATE,'HH:MM')# 
                                        <cfelse>
                                            #dateformat(END_MESSAGE_DATE,'dd.mm')# 
                                        </cfif>
                                        </span> 
                                        <br>
                                    <span class="badge badge-soft-primary text-dark rounded p-1" id="end-message-view_count-#manager_id#" style="float: right;"><cfif IS_NOT_VIEW_COUNT gt 0> #IS_NOT_VIEW_COUNT#</cfif></span>
                                </div> 
                            </div>            
                        </a>           
                    </li>   
                    </cfif>
            </cfoutput>