 
<cfquery name="get_wait_support" datasource="next_destekportal">
	SELECT DATEDIFF(MINUTE,SEND_DATE,GETDATE()) AS DAKIKA_FARK ,M.MANAGER_NAME + ' ' + M.MANAGER_SURNAME AS NAME_,C.ID FROM CHATS C
		LEFT JOIN MANAGERS M ON M.MANAGER_ID = C.SENDER_ID 
	 WHERE RECEIVER_ID = 1000 AND M.IS_SOLVED IS NULL AND IS_VIEW IS NULL AND DATEDIFF(MINUTE,SEND_DATE,GETDATE()) >5 AND ID NOT IN (SELECT DISTINCT CHAT_ID FROM AUTO_SMS_LOG)
</cfquery>
<cfset ids = valuelist(get_wait_support.ID)> 
 
<cfif get_wait_support.recordcount>
	<cfquery name="get_sms_info" datasource="workcubedev_brfplatform">
		SELECT IS_USE_SMS_WEBSERVICE,SMS_COMPANY,SMS_CUSTOMERNO,SMS_USERNAME,SMS_PASSWORD,SMS_SERVICECODE,SMS_ALPHANUMERIC FROM OUR_COMPANY_INFO WHERE COMP_ID = 1
	</cfquery>
	
	<cfset phone = 5541645464>
	<cfset attributes.message ='Sistemde destek bekleyen #get_wait_support.recordcount# adet talep bulunmaktadır. !'> 
	<cfset _StatusControl_ =1>
	<cfset _DeleteDate_ = ""> 
	<cfset _SendDate_ = #now()#> 
	<cfset _PhoneNumber_ = phone>
	<cfset uid_code = createUUID()>
	<cfset _Message_ = "#attributes.message#">
		<cfif Len(get_sms_info.is_use_sms_webservice) and get_sms_info.is_use_sms_webservice eq 1>
		<cfif Len(get_sms_info.sms_customerno)><cfset _CustomerNo_ = get_sms_info.sms_customerno><cfelse><cfset _CustomerNo_ = ""></cfif>
		<cfif Len(get_sms_info.sms_username)><cfset _UserName_ = get_sms_info.sms_username><cfelse><cfset _UserName_ = ""></cfif>
		<cfif Len(get_sms_info.sms_password)><cfset _Password_ = get_sms_info.sms_password><cfelse><cfset _Password_ = ""></cfif>
		<cfif Len(get_sms_info.sms_servicecode)><cfset _ServiceCode_ = get_sms_info.sms_servicecode><cfelse><cfset _ServiceCode_ = ""></cfif>
		<cfif Len(get_sms_info.sms_alphanumeric)><cfset _AlphaNumeric_ = get_sms_info.sms_alphanumeric><cfelse><cfset _AlphaNumeric_ = ""></cfif>
		<cfif get_sms_info.sms_company eq 1>
			<cfif Len(_SendDate_)><cfset _SendDate_ = DateFormat(_SendDate_,'yyyy-mm-dd') & ' ' & TimeFormat(_SendDate_,'HH:MM:ss')></cfif>
 			<cfhttp url="http://sms.dataport.com.tr/WebServices/SmsServices.asmx/SendSingleSMS" method="Post" timeout="60">
				<cfhttpparam type="formfield" name="CustomerNo" value="#_CustomerNo_#">
				<cfhttpparam type="formfield" name="UserName" value="#_UserName_#">
				<cfhttpparam type="formfield" name="Password" value="#_Password_#">
				<cfhttpparam type="formfield" name="ServiceCode" value="#_ServiceCode_#">
				<cfhttpparam type="formfield" name="AlphaNumeric" value="#_AlphaNumeric_#">
				<cfhttpparam type="formfield" name="PhoneNumber" value="#_PhoneNumber_#">
				<cfhttpparam type="formfield" name="Message" value="#_Message_#">
				<cfhttpparam type="formfield" name="StatusControl" value="#_StatusControl_#">
				<cfhttpparam type="formfield" name="SendDate" value="#_SendDate_#">
				<cfhttpparam type="formfield" name="DeleteDate" value="#_DeleteDate_#">
			</cfhttp>
			
			<cfset xmlDoc = XmlParse(cfhttp.Filecontent)>
			<cfif len(xmlDoc)>
				<cfset resources=xmlDoc.xmlroot>
				<cfif len(resources[1].SMS.MsgID.xmltext) and resources[1].SMS.MsgID.xmltext neq -1><cfset Sms_Status = 1><cfelse><cfset Sms_Status = 0></cfif>
				<cfif len(resources[1].SMS.ErrorCode.xmltext)><cfset Error_Code = resources[1].SMS.ErrorCode.xmltext><cfelse><cfset Error_Code = ""></cfif>
			</cfif>
			<!--- //DataPort --->
		<cfelse>
			<cfif Len(_SendDate_)><cfset _SendDate_ = DateFormat(_SendDate_,'ddmmyyyyHHMM')></cfif>
			<cfscript>
				my_doc = XmlNew();
				my_doc.xmlRoot = XmlElemNew(my_doc,"MainmsgBody");
				my_doc.xmlRoot.XmlChildren[1] = XmlElemNew(my_doc,"Command");
				my_doc.xmlRoot.XmlChildren[1].XmlText = "0";
				
				my_doc.xmlRoot.XmlChildren[2] = XmlElemNew(my_doc,"PlatformID");
				my_doc.xmlRoot.XmlChildren[2].XmlText = "1";
				
				my_doc.xmlRoot.XmlChildren[3] = XmlElemNew(my_doc,"UserName");
				my_doc.xmlRoot.XmlChildren[3].XmlText = "#_UserName_#";
				
				my_doc.xmlRoot.XmlChildren[4] = XmlElemNew(my_doc,"PassWord");
				my_doc.xmlRoot.XmlChildren[4].XmlText = "#_Password_#";
				
				my_doc.xmlRoot.XmlChildren[5] = XmlElemNew(my_doc,"ChannelCode");
				my_doc.xmlRoot.XmlChildren[5].XmlText = "#_ServiceCode_#";
				
				my_doc.xmlRoot.XmlChildren[6] = XmlElemNew(my_doc,"Mesgbody");
				my_doc.xmlRoot.XmlChildren[6].XmlText = "#_Message_#";
				
				my_doc.xmlRoot.XmlChildren[7] = XmlElemNew(my_doc,"Numbers");
				my_doc.xmlRoot.XmlChildren[7].XmlText = "#_PhoneNumber_#";
				
				my_doc.xmlRoot.XmlChildren[8] = XmlElemNew(my_doc,"Type");
				my_doc.xmlRoot.XmlChildren[8].XmlText = "1";
				
				my_doc.xmlRoot.XmlChildren[9] = XmlElemNew(my_doc,"Originator");
				my_doc.xmlRoot.XmlChildren[9].XmlText = "#_AlphaNumeric_#";

				my_doc.xmlRoot.XmlChildren[10] = XmlElemNew(my_doc,"Option");
				my_doc.xmlRoot.XmlChildren[10].XmlText = "1";
				
			</cfscript>
			<cfhttp url="http://processor.smsorigin.com/xml/process.aspx" method="Post" timeout="60">
				<cfhttpparam type="xml" name="data" value="#my_doc#">
			</cfhttp>
			
			<cfset Sms_Status = 1>
			<cfset xmlDoc = cfhttp.FileContent>
			<cfif Len(xmlDoc)>
				<!--- Hata Olmadiysa Onay kodunu yazmamiza gerek yok,-1 sorunsuz anlaminda kullanilacak raporlarda da --->
				<cfif xmlDoc contains ':'>
					<cfset Error_Code = -1>
				<cfelse>
					<cfset Error_Code = Trim(xmlDoc)>
				</cfif>
			</cfif>
			<!--- //TuraTel --->
		</cfif>
		
		<!--- Sonuclar - Hata ve Donus Kodlari Tabloya Yazilir --->
		<cfif isDefined("Error_Code") and isNumeric(Error_Code)>
			<cfquery name="get_max_sms_id" datasource="workcubedev_brfplatform">
				SELECT MAX(SMS_ID) SMS_ID FROM SMS_SEND_RECEIVE
			</cfquery>
			<cfloop list="#ids#" item="chat_id">
 				<cfquery name="ins_log" datasource="next_destekportal">
						INSERT INTO AUTO_SMS_LOG
						(
							SCHEDLUES_NAME,
							CALISMA_TARIHI,
							MESSAGE,
							RECORD_EMP,
							UID_CODE,
							CHAT_ID
						)
						VALUES 
						(   
							'support_',
							#now()#,
							'#_Message_#',
							1000,
							'#uid_code#',
							#chat_id#
						)
					</cfquery>
			</cfloop>
			<cfquery name="update_deliver_info" datasource="workcubedev_brfplatform">
				UPDATE
					SMS_SEND_RECEIVE
				SET
					IS_USE_WEBSERVICE = 1,
					SMS_STATUS = <cfif isDefined("Sms_Status") and Len(Sms_Status)>#Sms_Status#<cfelse>0</cfif>,
					ERROR_CODE = <cfif isDefined("Error_Code") and isNumeric(Error_Code)>#Error_Code#<cfelse>NULL</cfif>
				WHERE
					SMS_ID = #get_max_sms_id.sms_id#
			</cfquery>
		</cfif>
		<!--- //Sonuclar - Hata ve Donus Kodlari Tabloya Yazilir --->
	</cfif>
</cfif>