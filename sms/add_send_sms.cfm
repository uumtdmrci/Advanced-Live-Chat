<CFTRY>
<!--- sms_body_report parametresi sms raporunda gorunmemesi gereken ifadeleri * a cevirerek yaziyor, sifre vb ifadeleri icin kullanilabilir --->
<cfif not isDefined("attributes.data_source")><cfset attributes.data_source = dsn></cfif>
<cfif isDefined("caller.")>
	<!--- CustomTaglerden Geldigi Durumlarda Caller --->
	<cfset dsn_alias = caller.dsn_alias>
	<cfset dsn3_alias = caller.dsn3_alias>
</cfif>
<cfif isDefined("session.ep.userid")>
	<cfset TimeZone = session.ep.time_zone>
	<cfset OurCompanyId = session.ep.company_id>
	<cfset PeriodId = session.ep.period_id>
	<cfset UserId = session.ep.userid>
<cfelseif isDefined("session.pp.userid")>
	<cfset TimeZone = session.pp.time_zone>
	<cfset OurCompanyId = session.pp.company_id>
	<cfset PeriodId = session.pp.period_id>
	<cfset UserId = session.pp.userid>
<cfelseif isDefined("session.ww.userid")>
	<cfset TimeZone = session.ww.time_zone>
	<cfset OurCompanyId = session.ww.our_company_id>
	<cfset PeriodId = session.ww.period_id>
	<cfset UserId = session.ww.userid>
<cfelse>
	<!--- session olusmadan da sms alinmasi gerekebiliyor bu yuzden gerekenlere default degerler verildi --->
	<cfif not isDefined("TimeZone")><cfset TimeZone = 2></cfif>
	<cfif not isDefined("OurCompanyId")><cfset OurCompanyId = 1></cfif>
	<cfif not isDefined("PeriodId")><cfset PeriodId = 0></cfif>
	<cfif not isDefined("UserId")><cfset UserId = 0></cfif>
</cfif>

<cfif not isdefined('attributes.send_date')>
	<cfset sms_send_date=dateadd('h',TimeZone, now())>
<cfelse>
	<cfset sms_send_date=CreateODBCDateTime(dateformat(attributes.send_date,'dd/mm/yyyy')&" "&send_hour&":"&send_minute&":00")>
</cfif>
<cfquery name="use_webservice_control" datasource="#attributes.data_source#">
	SELECT IS_USE_SMS_WEBSERVICE,SMS_COMPANY FROM #dsn_alias#.OUR_COMPANY_INFO WHERE COMP_ID = 1
</cfquery>


<cfif use_webservice_control.sms_company neq 1>
	<cfset Turkish_List = 'ç,ğ,ı,ö,ş,ü,Ç,Ğ,İ,Ö,Ş,Ü,|,½,[,]'>
	<cfset Usable_List = 'c,g,i,o,s,u,C,G,I,O,S,U, , , , '>
	<!--- Turatelde Karakter Sorunu Oldugu Icin, Enter Kullanimi Da Sorun Olabileceginden Duzenlendi, FBS 20120402 --->
	<cfset attributes.sms_body = ReplaceList(attributes.sms_body,Turkish_List,Usable_List)>
	<cfset attributes.sms_body = Replace(attributes.sms_body,Chr(13)&Chr(10),' ','all')>
	<cfif isdefined("attributes.sms_body_report") and len(attributes.sms_body_report)>
		<cfset attributes.sms_body_report = ReplaceList(attributes.sms_body_report,Turkish_List,Usable_List)>
		<cfset attributes.sms_body_report = Replace(attributes.sms_body_report,Chr(13)&Chr(10),' ','all')>
	</cfif>
</cfif>
<cfquery name="ADD_SMS_SEND_RECEIVE" datasource="workcubedev_brfplatform">
	INSERT INTO
		SMS_SEND_RECEIVE
	(
		SMS_TEMPLATE_ID,
		IS_SEND_RECEIVE,
		PHONE_NUMBER,
		SMS_STATUS,
		SMS_BODY,
		SEND_DATE,
		RECEIVE_EMPOYEE_ID,
		RECEIVE_CONSUMER_ID,
		RECEIVE_COMPANY_ID,
		RECEIVE_COMPANY_PARTNER_ID,
		CAMP_ID,
		SMS_CONT_ID,
		PAPER_ID,
		PAPER_TYPE,
		PAPER_PERIOD_ID,
		IS_USE_WEBSERVICE,
		<cfif isDefined("session.pp")>
			RECORD_PAR,
		<cfelseif isDefined("session.ww")>
			RECORD_CON,
		<cfelse>
			RECORD_EMP,
		</cfif>
		RECORD_DATE,
		RECORD_IP
	)
	VALUES
	(
		<cfif isdefined("attributes.sms_template_id") and len(attributes.sms_template_id)>#attributes.sms_template_id#<cfelse>NULL</cfif>,
		0,
		'#attributes.mobil_phone#',
		0,
		<cfif isdefined("attributes.sms_body_report") and len(attributes.sms_body_report)>'#attributes.sms_body_report#'<cfelse>'#attributes.sms_body#'</cfif>,
		#sms_send_date#,
		<cfif isDefined("attributes.member_type") and attributes.member_type eq 'employee'>#attributes.member_id#<cfelse>NULL</cfif>,
		<cfif isDefined("attributes.member_type") and attributes.member_type eq 'consumer'>#attributes.member_id#<cfelse>NULL</cfif>,
		<cfif isDefined("attributes.member_type") and attributes.member_type eq 'company'>
			#attributes.member_id#,
			<cfif isdefined('attributes.member_id_2') and len(attributes.member_id_2)>#attributes.member_id_2#<cfelse>NULL</cfif>,
		<cfelseif isDefined('attributes.member_type') and attributes.member_type eq 'partner'>
			<cfif isdefined('attributes.member_id_2') and len(attributes.member_id_2)>#attributes.member_id_2#<cfelse>NULL</cfif>,
			#attributes.member_id#,
		<cfelse>
			NULL,
			NULL,
		</cfif>
		<cfif isdefined("attributes.campaign_id") and len(attributes.campaign_id)>#attributes.campaign_id#<cfelse>NULL</cfif>,
		<cfif isdefined("attributes.sms_cont_id") and len(attributes.sms_cont_id)>#attributes.sms_cont_id#<cfelse>NULL</cfif>,
		<cfif isdefined("attributes.paper_id") and len(attributes.paper_id)>#attributes.paper_id#<cfelse>NULL</cfif>,
		<cfif isdefined("attributes.paper_type") and len(attributes.paper_type)>#attributes.paper_type#<cfelse>NULL</cfif>,
		<cfif isdefined("PeriodId") and PeriodId gt 0>#PeriodId#<cfelse>NULL</cfif>,
		<cfif len(use_webservice_control.is_use_sms_webservice) and use_webservice_control.is_use_sms_webservice eq 1>1<cfelse>0</cfif>,
		<cfif isdefined("UserId") and UserId gt 0>#UserId#<cfelse>NULL</cfif>,
		#now()#,
		'#cgi.remote_addr#'
	)
</cfquery>
<cfif len(use_webservice_control.is_use_sms_webservice) and use_webservice_control.is_use_sms_webservice eq 1>
	<cfset _PhoneNumber_ = attributes.mobil_phone>
	<cfset  _Message_ = attributes.sms_body>
	<cfset _StatusControl_ = 1>
	<cfset _SendDate_ = sms_send_date>
	<cfset _DeleteDate_ = "">
	<cfinclude template="../sms/send_sms_web_service.cfm"> 
</cfif>
<cfif not isdefined("callcenter_include")>
	<script type="text/javascript">
		window.close();
	</script>
</cfif>
<cfcatch TYPE="any">
	<cfsavecontent variable="hata_"><cfdump var="#cfcatch#"></cfsavecontent>
	<cffile action = "write"
	file = "#upload_folder#sms_hata.txt"
	output = "#hata_#">
</cfcatch>
</CFTRY>