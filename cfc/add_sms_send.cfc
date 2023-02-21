<!--- <cfcomponent>
	<cfif session.pp.userid>
		<cfset manager_id_ = session.pp.userid>
		<cfset dsn = "next_station_guzelye">
		<cfquery name="get_firma_indirim" datasource="#dsn#"> <!--- firma bazlı indirimi öğrenme --->
			SELECT ISNULL(UF.INDIRIM_ORANI,0) AS INDIRIM_ORANI FROM MANAGERS M
			LEFT JOIN FIRMA F ON F.ID =M.FIRMA_ID 
			LEFT JOIN UST_FIRMA UF ON UF.ID = F.UST_FIRMA_ID
			WHERE 
				M.MANAGER_ID = #manager_id_#
		</cfquery>
		<cfset ust_firma_indirim = get_firma_indirim.INDIRIM_ORANI>

		<cfset total_indirim_price_= 0> 
		<cfset indirim_price_  = 0>
		<cfset indirim_menu_tutar =0>
		<cfset indirim_tutari = 0>

		<cffunction name="sepeteekle" access="remote" returnFormat="JSON" output="false" returntype="query">
			<cfargument name="product_id" type="any" required="no">
			<cfargument name="adet" type="any" required="no">
			<cfargument name="markaid" type="any" required="no">
			<cfargument name="resid" type="any" required="no">
			<cfargument name="selectedchoise" type="any" required="no" default="-1">
			<cfargument name="sub_selectedchoise" type="any" required="no" default="-1">
			<cfargument name="selectedproduct_sub" type="any" required="no" default="-1">
			<cfargument name="subselectedproduct_sub" type="any" required="no" default="-1">
			
			<!--- <cfargument name="extra_product" type="any" required="no" default="-1"> --->

				<cfset adet_ = arguments.adet>

				<cfquery name="get_basket_" datasource="#dsn#">
					SELECT * FROM SEPET WHERE MANAGER_ID = #manager_id_# AND STATUS=0
				</cfquery>

	

				<cfquery name="Get_product" datasource="#dsn#"> <!--- ürün --->
					SELECT * FROM MARKA_PRODUCT WHERE MARKA_ID = #arguments.markaid# AND URUN_ID=#arguments.product_id#
				</cfquery>

				<cfset extra_product_price = 0 >


				<cfif listlen(arguments.selectedchoise)> <!--- ürün seçin fiyatları --->

					<cfquery name="get_choise_price" datasource="#dsn#">
						SELECT ISNULL(SUM(PRICE),0) AS CHOISE_PRICE FROM CHOISE_CAPTION CP
						LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
						WHERE 
						PRODUCT_ID = #arguments.product_id# AND 
						CHOISE_PRODUCT_ID IN (#arguments.selectedchoise#)
					</cfquery>

					<cfif get_choise_price.CHOISE_PRICE gt 0>
						<cfset extra_product_price = extra_product_price+get_choise_price.CHOISE_PRICE >
					</cfif>

					<cfif listlen(arguments.sub_selectedchoise)> <!--- ürün ana seçimlerinin alt seçim fiyatları --->
						<cfquery name="get_choise_price" datasource="#dsn#">
							SELECT CPR.ID,CPR.CHOISE_PRODUCT_ID,SCP.PRODUCT_ID FROM CHOISE_CAPTION CP
							LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
							LEFT JOIN SETUP_CHOISE_PRODUCT SCP ON SCP.ID = CPR.CHOISE_PRODUCT_ID
							WHERE 
							CP.PRODUCT_ID = #arguments.product_id# AND 
							CHOISE_PRODUCT_ID IN (#arguments.selectedchoise#)
						</cfquery>
	
						<cfif get_choise_price.recordCount and len(get_choise_price.PRODUCT_ID)>
							<cfloop query="get_choise_price">
								<cfquery name="get_sub_choise_product_id" datasource="#dsn#">
									SELECT ISNULL(SUM(PRICE),0) AS CHOISE_PRICE FROM CHOISE_CAPTION CP
									LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
									WHERE 
									PRODUCT_ID = #get_choise_price.PRODUCT_ID# AND 
									CHOISE_PRODUCT_ID IN (#arguments.sub_selectedchoise#)
								</cfquery>
	
								<cfif get_sub_choise_product_id.recordcount>
									<cfloop query="get_sub_choise_product_id">
										<cfif get_sub_choise_product_id.CHOISE_PRICE gt 0>
											<cfset extra_product_price = extra_product_price+get_sub_choise_product_id.CHOISE_PRICE >
										</cfif>
									</cfloop>
								</cfif>
							</cfloop>
						</cfif>
					</cfif>

				</cfif>

				
				<!--- end::müşterinin seçimine göre ürünün üstüne eklenecek + fiyat var ise bulunur --->



				<cfquery name="Get_product_basket" datasource="#dsn#">
					SELECT * FROM SEPET_ROW WHERE URUN_ID=#arguments.product_id# AND SEPET_ID=#get_basket_.id#
				</cfquery>

				<cfif Get_product_basket.recordCount> <!--- bu ürün daha önceden sepete atıldıysa yapılacaklar --->
					<cfset all_control = 0>

					<cfloop query="Get_product_basket"> <!--- sepetteki aynı ürünler için kombinasyon kontrolü yapılan döngü --->
						
						<cfif all_control eq 0 > 

							<cfquery name="get_müsteri_tercih" datasource="#dsn#"> <!--- müşteri tercihleri tablosu --->
							 	SELECT CCR.CHOISE_PRODUCT_ID
								FROM BASKET_CHOISE_SELECTED BCS
								LEFT JOIN CHOISE_CAPTION_ROW CCR ON CCR.ID = BCS.CHOISE_CAPTION_ROW_ID
								WHERE SEPET_ROW_ID = #Get_product_basket.ID#
								ORDER BY CHOISE_PRODUCT_ID ASC
							</cfquery>
							
							<!--- müşteri tercihleri asc list --->
								<cfset selected_CHOISE_PRODUCT_ID = valueList(get_müsteri_tercih.CHOISE_PRODUCT_ID)>
								<cfset sort_CHOISE_PRODUCT_ID = listSort(arguments.selectedchoise, "Numeric", "asc")>
							<!--- müşteri tercihleri asc list --->


							<cfquery name="get_müsteri_alt_tercih" datasource="#dsn#"> <!--- müşteri tercihleri tablosu --->
								SELECT CCR.CHOISE_PRODUCT_ID
							   FROM SUB_PRODUCT_BASKET_CHOISE_SELECTED BCS
							   LEFT JOIN CHOISE_CAPTION_ROW CCR ON CCR.ID = BCS.CHOISE_CAPTION_ROW_ID
							   WHERE SEPET_ROW_ID = #Get_product_basket.ID#
							   ORDER BY CHOISE_PRODUCT_ID ASC
						   </cfquery>
						   
						   <!--- müşteri tercihlerinin alt tercihleri asc list --->
							   <cfset sub_selected_CHOISE_PRODUCT_ID = valueList(get_müsteri_alt_tercih.CHOISE_PRODUCT_ID)>
							   <cfset sub_sort_CHOISE_PRODUCT_ID = listSort(arguments.sub_selectedchoise, "Numeric", "asc")>
						   <!--- müşteri tercihleri alt tercihleri asc list --->



							<cfquery name="get_product_sub" datasource="#dsn#"> <!--- ürün malzemeleri tablosu  ---> 
								SELECT PRODUCT_SUB_ID FROM BASKET_PRODUCT_SUB_SELECTED WHERE SEPET_ROW_ID = #Get_product_basket.ID#  ORDER BY PRODUCT_SUB_ID ASC
							</cfquery>

							<!--- ürün malzemeleri asc list --->
								<cfset selected_PRODUCT_SUB_ID = valueList(get_product_sub.PRODUCT_SUB_ID)>
								<cfset sort_PRODUCT_SUB_ID = listSort(arguments.selectedproduct_sub, "Numeric", "asc")>
							<!--- müşteri tercihleri asc list --->


							
							<cfif (selected_CHOISE_PRODUCT_ID eq sort_CHOISE_PRODUCT_ID) and 
									(selected_PRODUCT_SUB_ID eq sort_PRODUCT_SUB_ID) and
									(sub_selected_CHOISE_PRODUCT_ID eq sub_sort_CHOISE_PRODUCT_ID)>

								<cfset all_control= 1>
								<cfset basketrow_id = Get_product_basket.id>

								<!--- güncelleme için fiyat işlemleri --->
									<cfset new_adet = arguments.adet + Get_product_basket.adet>
									<cfset total_price= (Get_product.P_PRICE + extra_product_price) * new_adet> 
									<cfset toplam_sepet_fiyat = total_price> <!--- toplam sepet fiyati (indirim yoksa) --->

									<cfif ust_firma_indirim gt 0 > <!--- üst firma indirimi varsa --->
										<cfset indirim_price_  = ( Get_product.P_PRICE*ust_firma_indirim ) / 100 >
										<cfset total_indirim_price_=( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*new_adet> <!--- menünün indirimli fiyatı * adet --->
										<cfset indirim_menu_tutar = Get_product.P_PRICE - indirim_price_> <!--- ürünün indirimli satış fiyatı --->
										<cfset indirim_tutari = indirim_price_ * new_adet> <!--- bu ürüne adet bazlı ne kadar indirim yapıldığı --->
										<cfset toplam_sepet_fiyat =( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*new_adet>  <!--- toplam sepet fiyat (indirim varsa) --->
									</cfif>

								<!--- end :: fiyat işlemleri --->
							</cfif>
						</cfif>
						
					</cfloop>
				

					<cfif all_control eq 1 > <!--- bütün tercihler sepetteki ürünle aynı olduğu için güncelleme yapılacak --->
						<cfquery name="upd_" datasource="#dsn#">
							UPDATE
								SEPET_ROW
							SET
								ADET=#new_adet#,
								TOPLAM_URUN_FIYATI=#total_price#,
								TOPLAM_INDIRIMLI_URUN_FIYAT = #total_indirim_price_#,								
								INDIRIM_TUTARI = #indirim_tutari#,
								TOPLAM_SEPET_FIYAT = #toplam_sepet_fiyat#,
								INDIRIMLI_MENU_FIYAT = #indirim_menu_tutar#

							WHERE ID=#basketrow_id#
						</cfquery>
					<cfelse>  <!--- tercihler sepetteki ürünler ile eşleşmiyorsa yeni kayıt atılacak --->

						<!--- fiyat işlemleri --->
							<cfset total_price= (Get_product.P_PRICE + extra_product_price) * adet_> 
							<cfset toplam_sepet_fiyat = total_price> <!--- toplam sepet fiyati (indirim yoksa) --->
							<cfif ust_firma_indirim gt 0 > <!--- üst firma indirimi varsa --->
								<cfset indirim_price_  = ( Get_product.P_PRICE*ust_firma_indirim ) / 100 >
								<cfset total_indirim_price_=( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*adet_> <!--- menünün indirimli fiyatı * adet --->
								<cfset indirim_menu_tutar = Get_product.P_PRICE - indirim_price_> <!--- ürünün indirimli satış fiyatı --->
								<cfset indirim_tutari = indirim_price_ * adet_> <!--- bu ürüne adet bazlı ne kadar indirim yapıldığı --->
								<cfset toplam_sepet_fiyat =( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*adet_>  <!--- toplam sepet fiyat (indirim varsa) --->
							</cfif>
						<!--- end :: fiyat işlemleri --->

						<cfquery name="add_" datasource="#dsn#" result="get_max">
							INSERT INTO
								SEPET_ROW
								(
									URUN_ID,
									ADET,
									TOPLAM_URUN_FIYATI,
									SEPET_ID,
									MENU_FIYAT,
									RECORD_DATE,
									RES_ID,
									MARKA_ID,

									
									TOPLAM_INDIRIMLI_URUN_FIYAT,								
									INDIRIM_TUTARI,
									TOPLAM_SEPET_FIYAT,
									INDIRIMLI_MENU_FIYAT
								)
								VALUES
								(
									#arguments.product_id#,
									#arguments.adet#,
									#total_price#,
									#get_basket_.id#,
									#Get_product.P_PRICE#,
									#now()#,
									#arguments.resid#,
									#arguments.markaid#,

									#total_indirim_price_#,
									#indirim_tutari#,
									#toplam_sepet_fiyat#,
									#indirim_menu_tutar#
									

								)
						</cfquery>
			
						<!--- müşterinin seçimleri kayıt atılıyor --->
							<cfif listlen(arguments.selectedchoise)>
								<cfquery name="get_choise_price" datasource="#dsn#">
									SELECT CPR.ID FROM CHOISE_CAPTION CP
									LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
									WHERE 
									PRODUCT_ID = #arguments.product_id# AND 
									CHOISE_PRODUCT_ID IN (#arguments.selectedchoise#)
								</cfquery>

								<cfif get_choise_price.recordCount>
									<cfloop query="get_choise_price">
										<cfquery name="add_choise" datasource="#dsn#">
											INSERT INTO 
											BASKET_CHOISE_SELECTED
											(
												SEPET_ROW_ID,
												PRODUCT_ID,
												CHOISE_CAPTION_ROW_ID

											)
											VALUES
											(
												#get_max.identitycol#,
												#arguments.product_id#,
												#get_choise_price.ID#

											)
										</cfquery>
									</cfloop>
								</cfif>

								<cfif listlen(arguments.sub_selectedchoise)> <!--- ürün ana seçimlerinin alt seçimleri --->
									<cfquery name="get_choise_price" datasource="#dsn#">
										SELECT CPR.ID,CPR.CHOISE_PRODUCT_ID,SCP.PRODUCT_ID FROM CHOISE_CAPTION CP
										LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
										LEFT JOIN SETUP_CHOISE_PRODUCT SCP ON SCP.ID = CPR.CHOISE_PRODUCT_ID
										WHERE 
										CP.PRODUCT_ID = #arguments.product_id# AND 
										CHOISE_PRODUCT_ID IN (#arguments.selectedchoise#)
									</cfquery>
		
									<cfif get_choise_price.recordCount>
										<cfloop query="get_choise_price">
											<cfif get_choise_price.recordCount and len(get_choise_price.PRODUCT_ID)>
												<cfquery name="get_sub_choise_product_id" datasource="#dsn#">
													SELECT CPR.ID,CPR.CHOISE_PRODUCT_ID FROM CHOISE_CAPTION CP
													LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
													WHERE 
													PRODUCT_ID = #get_choise_price.PRODUCT_ID# AND 
													CHOISE_PRODUCT_ID IN (#arguments.sub_selectedchoise#)
												</cfquery>
			
												<cfif get_sub_choise_product_id.recordcount>
													<cfloop query="get_sub_choise_product_id">
														<cfquery name="add_choise" datasource="#dsn#">
															INSERT INTO 
															SUB_PRODUCT_BASKET_CHOISE_SELECTED
															(
																SEPET_ROW_ID,
																PRODUCT_ID,
																OPTION_PRODUCT_ID,
																CHOISE_CAPTION_ROW_ID
			
															)
															VALUES
															(
																#get_max.identitycol#,
																#arguments.product_id#,
																<cfif len(get_choise_price.product_id)>#get_choise_price.product_id#<cfelse>NULL</cfif>,
																#get_sub_choise_product_id.ID#
															)
														</cfquery>
													</cfloop>
												</cfif>
											</cfif>
										</cfloop>
									</cfif>
								</cfif>
							</cfif>

							<cfif listlen(arguments.selectedproduct_sub)>
								<cfloop list="#arguments.selectedproduct_sub#" index="index">
									<cfquery name="add_choise" datasource="#dsn#">
										INSERT INTO 
										BASKET_PRODUCT_SUB_SELECTED
										(
											SEPET_ROW_ID,
											PRODUCT_ID,
											PRODUCT_SUB_ID
										)
										VALUES
										(
											#get_max.identitycol#,
											#arguments.product_id#,
											#index#

										)
									</cfquery>
								</cfloop>
							</cfif>
						<!--- end::  müşterinin seçimleri kayıt atılıyor  --->
					</cfif>
				<cfelse><!--- bu ürün ilk defa sepete atılıyorsa --->
					
					<!--- fiyat işlemleri --->
						<cfset total_price= (Get_product.P_PRICE + extra_product_price) * adet_> 
						<cfset toplam_sepet_fiyat = total_price> <!--- toplam sepet fiyati (indirim yoksa) --->
						<cfif ust_firma_indirim gt 0 > <!--- üst firma indirimi varsa --->
							<cfset indirim_price_  = ( Get_product.P_PRICE*ust_firma_indirim ) / 100 >
							<cfset total_indirim_price_=( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*adet_> <!--- menünün indirimli fiyatı * adet --->
							<cfset indirim_menu_tutar = Get_product.P_PRICE - indirim_price_> <!--- ürünün indirimli satış fiyatı --->
							<cfset indirim_tutari = indirim_price_ * adet_> <!--- bu ürüne adet bazlı ne kadar indirim yapıldığı --->
							<cfset toplam_sepet_fiyat =( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*adet_>  <!--- toplam sepet fiyat (indirim varsa) --->
						</cfif>
					<!--- end :: fiyat işlemleri --->

					<cfquery name="add_" datasource="#dsn#" result="get_max">
						INSERT INTO
							SEPET_ROW
							(
								URUN_ID,
								ADET,
								TOPLAM_URUN_FIYATI,
								SEPET_ID,
								MENU_FIYAT,
								RECORD_DATE,
								RES_ID,
								MARKA_ID,

								
								TOPLAM_INDIRIMLI_URUN_FIYAT,								
								INDIRIM_TUTARI,
								TOPLAM_SEPET_FIYAT,
								INDIRIMLI_MENU_FIYAT
							)
							VALUES
							(
								#arguments.product_id#,
								#arguments.adet#,
								#total_price#,
								#get_basket_.id#,
								#Get_product.P_PRICE#,
								#now()#,
								#arguments.resid#,
								#arguments.markaid#,

								#total_indirim_price_#,
								#indirim_tutari#,
								#toplam_sepet_fiyat#,
								#indirim_menu_tutar#
								

							)
					</cfquery>
		
					<!--- müşterinin seçimleri kayıt atılıyor --->
						
						<cfif listlen(arguments.selectedchoise)><!--- ürün ana seçimleri --->
							<cfquery name="get_choise_price" datasource="#dsn#">
								SELECT CPR.ID FROM CHOISE_CAPTION CP
								LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
								WHERE 
								PRODUCT_ID = #arguments.product_id# AND 
								CHOISE_PRODUCT_ID IN (#arguments.selectedchoise#)
							</cfquery>

							<cfif get_choise_price.recordCount>
								<cfloop query="get_choise_price">
									<cfquery name="add_choise" datasource="#dsn#">
										INSERT INTO 
										BASKET_CHOISE_SELECTED
										(
											SEPET_ROW_ID,
											PRODUCT_ID,
											CHOISE_CAPTION_ROW_ID

										)
										VALUES
										(
											#get_max.identitycol#,
											#arguments.product_id#,
											#get_choise_price.ID#
										)
									</cfquery>
								</cfloop>
							</cfif>

							<cfif listlen(arguments.sub_selectedchoise)> <!--- ürün ana seçimlerinin alt seçimleri --->
								<cfquery name="get_choise_price" datasource="#dsn#">
									SELECT CPR.ID,CPR.CHOISE_PRODUCT_ID,SCP.PRODUCT_ID FROM CHOISE_CAPTION CP
									LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
									LEFT JOIN SETUP_CHOISE_PRODUCT SCP ON SCP.ID = CPR.CHOISE_PRODUCT_ID
									WHERE 
									CP.PRODUCT_ID = #arguments.product_id# AND 
									CHOISE_PRODUCT_ID IN (#arguments.selectedchoise#)
								</cfquery>
	
								<cfif get_choise_price.recordCount and len(get_choise_price.PRODUCT_ID)>
									<cfloop query="get_choise_price">
										<cfquery name="get_sub_choise_product_id" datasource="#dsn#">
											SELECT CPR.ID,CPR.CHOISE_PRODUCT_ID FROM CHOISE_CAPTION CP
											LEFT JOIN CHOISE_CAPTION_ROW CPR ON CP.ID = CPR.CHOISE_CAPTION_ID
											WHERE 
											PRODUCT_ID = #get_choise_price.PRODUCT_ID# AND 
											CHOISE_PRODUCT_ID IN (#arguments.sub_selectedchoise#)
										</cfquery>
	
										<cfif get_sub_choise_product_id.recordcount>
											<cfloop query="get_sub_choise_product_id">
												<cfquery name="add_choise" datasource="#dsn#">
													INSERT INTO 
													SUB_PRODUCT_BASKET_CHOISE_SELECTED
													(
														SEPET_ROW_ID,
														PRODUCT_ID,
														OPTION_PRODUCT_ID,
														CHOISE_CAPTION_ROW_ID
	
													)
													VALUES
													(
														#get_max.identitycol#,
														#arguments.product_id#,
														<cfif len(get_choise_price.product_id)>#get_choise_price.product_id#<cfelse>NULL</cfif>,
														#get_sub_choise_product_id.ID#
													)
												</cfquery>
											</cfloop>
										</cfif>
									</cfloop>
								</cfif>

								
								
							</cfif>
						</cfif>

						<cfif listlen(arguments.selectedproduct_sub)><!--- çıkarılacak malzemeler tablosu --->
							<cfloop list="#arguments.selectedproduct_sub#" index="index">
								<cfquery name="add_choise" datasource="#dsn#">
									INSERT INTO 
									BASKET_PRODUCT_SUB_SELECTED
									(
										SEPET_ROW_ID,
										PRODUCT_ID,
										PRODUCT_SUB_ID
									)
									VALUES
									(
										#get_max.identitycol#,
										#arguments.product_id#,
										#index#
									)
								</cfquery>
							</cfloop>
							
						</cfif>

						
			

					<!--- end ::  müşterinin seçimleri kayıt atılıyor--->

				</cfif>
			
			
		
			<cfquery name="get_man_basket" datasource="#dsn#">
				SELECT * FROM SEPET_ROW WHERE SEPET_ID=#get_basket_.id#
			</cfquery>
			<cfreturn get_man_basket>
		</cffunction>

		<cffunction name="guncelle" access="remote" returnFormat="JSON" output="false" returntype="query">
			<cfargument name="basket_row" type="any" required="no">
			<cfargument name="product_id" type="any" required="no">
			<cfargument name="adet" type="any" required="no">
			<cfargument name="markaid" type="any" required="no">
			<cfargument name="resid" type="any" required="no">
			<cfset adet_ = arguments.adet>
			<cfquery name="get_basket_" datasource="#dsn#">
				SELECT * FROM SEPET WHERE MANAGER_ID = #manager_id_# AND STATUS=0
			</cfquery>

			<cfset extra_product_price = 0 >

			<cfquery name="get_choise_price" datasource="#dsn#">
					SELECT ISNULL(sum(CCR.PRICE),0) as CHOISE_PRICE
					FROM BASKET_CHOISE_SELECTED BCS
					LEFT JOIN CHOISE_CAPTION_ROW CCR ON CCR.ID = BCS.CHOISE_CAPTION_ROW_ID
					WHERE SEPET_ROW_ID =  #arguments.basket_row#
			</cfquery>

			<cfif get_choise_price.CHOISE_PRICE gt 0>
				<cfset extra_product_price = extra_product_price+get_choise_price.CHOISE_PRICE >
			</cfif>

			<cfquery name="getsub_choise_price" datasource="#dsn#">
					SELECT ISNULL(sum(CCR.PRICE),0) as CHOISE_PRICE
					FROM SUB_PRODUCT_BASKET_CHOISE_SELECTED BCS
					LEFT JOIN CHOISE_CAPTION_ROW CCR ON CCR.ID = BCS.CHOISE_CAPTION_ROW_ID
					WHERE SEPET_ROW_ID =  #arguments.basket_row#
			</cfquery>

			<cfif getsub_choise_price.CHOISE_PRICE gt 0>
				<cfset extra_product_price = extra_product_price+getsub_choise_price.CHOISE_PRICE >
			</cfif>


			<cfquery name="get_firma_indirim" datasource="#dsn#">
				SELECT ISNULL(UF.INDIRIM_ORANI,0) AS INDIRIM_ORANI FROM MANAGERS M
				LEFT JOIN FIRMA F ON F.ID =M.FIRMA_ID 
				LEFT JOIN UST_FIRMA UF ON UF.ID = F.UST_FIRMA_ID
				WHERE 
					M.MANAGER_ID = #manager_id_#
			</cfquery>
			<cfset ust_firma_indirim = get_firma_indirim.INDIRIM_ORANI>

			<cfif get_basket_.recordCount>
		
				
				<cfquery name="Get_product" datasource="#dsn#">
					SELECT * FROM MARKA_PRODUCT WHERE MARKA_ID = #arguments.markaid# AND URUN_ID=#arguments.product_id#
				</cfquery>
				

				
				<cfquery name="Get_product_basket" datasource="#dsn#">
					SELECT * FROM SEPET_ROW WHERE ID = #arguments.basket_row# AND SEPET_ID=#get_basket_.id#
				</cfquery>
			

				
				<cfif Get_product_basket.recordCount>
					
					<cfset total_price=(Get_product.P_PRICE + extra_product_price) * adet_>
					<cfif ust_firma_indirim gt 0 >
						<cfset total_indirim_price_=( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*adet_>
						<cfset indirim_price_  = ( Get_product.P_PRICE*ust_firma_indirim ) / 100 >
					
						<cfset toplam_sepet_fiyat =( (Get_product.P_PRICE*(100-ust_firma_indirim)/100) + extra_product_price)*adet_> 
						<cfset indirim_menu_tutar = Get_product.P_PRICE - indirim_price_>
						<cfset indirim_tutari = indirim_price_ * adet_>
					<cfelse>
						<cfset total_indirim_price_= 0>
						<cfset indirim_price_  = 0>
						<cfset toplam_sepet_fiyat = 0>
						<cfset indirim_menu_tutar =0>
						<cfset indirim_tutari = 0>
					</cfif>

						
					<cfquery name="upd_" datasource="#dsn#">
						UPDATE
							SEPET_ROW
						SET
							ADET=#adet_#,
							TOPLAM_URUN_FIYATI=#total_price#,
							TOPLAM_INDIRIMLI_URUN_FIYAT = #total_indirim_price_#,								
							INDIRIM_TUTARI = #indirim_tutari#,
							TOPLAM_SEPET_FIYAT = #toplam_sepet_fiyat#,
							INDIRIMLI_MENU_FIYAT = #indirim_menu_tutar#
						WHERE ID=#Get_product_basket.id#
					</cfquery>
				
				</cfif>
			</cfif>
			<cfquery name="get_man_basket" datasource="#dsn#">
				SELECT * FROM SEPET_ROW WHERE SEPET_ID=#get_basket_.id# AND ID=#arguments.basket_row#
			</cfquery>
			
			<cfreturn get_man_basket> 
		</cffunction>

		<cffunction name="del" access="remote" returnFormat="JSON" output="false" returntype="query">
			<cfargument name="product_id" type="any" required="no">
			<cfargument name="adet" type="any" required="no">
			<cfargument name="markaid" type="any" required="no">
			<cfargument name="resid" type="any" required="no">
			<cfquery name="get_basket_" datasource="#dsn#">
				SELECT * FROM SEPET WHERE MANAGER_ID = #manager_id_# AND STATUS=0
			</cfquery>

			<cfif get_basket_.recordCount>
				
			
				<cfquery name="Get_product_basket" datasource="#dsn#">
					SELECT * FROM SEPET_ROW WHERE URUN_ID=#arguments.product_id# AND SEPET_ID=#get_basket_.id#
				</cfquery>
				
				
				<cfif Get_product_basket.recordCount>
					
					<cfquery name="upd_" datasource="#dsn#">
						DELETE
							SEPET_ROW
						WHERE ID=#Get_product_basket.id#
					</cfquery>
				
				</cfif>
			</cfif>
			<cfquery name="get_man_basket" datasource="#dsn#">
				SELECT * FROM SEPET_ROW WHERE SEPET_ID=#get_basket_.id#
			</cfquery>
			<cfreturn get_man_basket>
		</cffunction>
		
		<cffunction name="toplam" access="remote" returnFormat="JSON" output="false" returntype="string">
			<cfargument name="basketid" type="any" required="no">

			<cfquery name="get_man_basket" datasource="#dsn#">
				SELECT SUM(TOPLAM_SEPET_FIYAT) AS TOPLAM FROM SEPET_ROW WHERE SEPET_ID=#arguments.basketid#
			</cfquery>

			<cfset total=get_man_basket.toplam>
			
			<cfreturn "#total#">
		</cffunction>

		<cffunction name="restaurant" access="remote" returnFormat="JSON" output="false" returntype="string">
			<cfargument name="basketid" type="any" required="no">
			<cfargument name="resid" type="any" required="no">
			<cfquery name="get_man_basket" datasource="#dsn#">
				SELECT * FROM SEPET_ROW WHERE SEPET_ID=#arguments.basketid# AND RES_ID=#arguments.resid#
			</cfquery>
			<cfset count=get_man_basket.recordCount>
			<cfreturn "#count#">
		</cffunction>

		<cffunction name="sepet_count" access="remote" returnFormat="JSON" output="false" returntype="string">
			<cfargument name="basketid" type="any" required="no">
			<cfquery name="get_man_basket" datasource="#dsn#">
				SELECT * FROM SEPET_ROW WHERE SEPET_ID=#arguments.basketid#
			</cfquery>
			<cfset count=get_man_basket.recordCount>
			<cfreturn "#count#">
		</cffunction>
	<cfelse>
		Geçersiz İmza	
	</cfif>
</cfcomponent> --->

<cfcomponent>
	
	<cffunction name="upd_sms" access="remote" returnFormat="JSON" output="false" returntype="string">
		<cfargument name="id" type="any" required="no">
		<cfquery name="upd_sms" datasource="next_station_guzelye">
			UPDATE SETUP_SEND_SMS SET STATUS=0 WHERE ID=#arguments.id#
		</cfquery>
		<cfreturn "success">
	</cffunction>
	<cffunction name="kontrol" access="remote" returnFormat="JSON" output="false" returntype="string">
		<cfargument name="id" type="any" required="no">
		<cfargument name="string" type="any" required="no">
		<cfset kontrol=0>
		<cfquery name="get_kontrol" datasource="next_station_guzelye">
			SELECT SMS_CODE FROM SETUP_SEND_SMS WHERE ID=#arguments.id#
		</cfquery>
		<cfif get_kontrol.SMS_CODE eq arguments.string>
			<cfset kontrol=1>
		</cfif>
		<cfreturn "#kontrol#">
	</cffunction>
</cfcomponent>