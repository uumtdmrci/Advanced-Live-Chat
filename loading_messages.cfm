  

<cfif isdefined("form.chat_id_")>
        <cfset is_close = 0>
<cfelse>
        <cfset is_close = 1> 
</cfif>

    <cfquery name="managers" datasource="next_destekportal">
        SELECT 
        MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_,
        * FROM MANAGERS 
        LEFT JOIN SETUP_PROJECT SP ON SP.PROJECT_ID =MANAGER_PROJECT
        WHERE MANAGER_ID =#form.manager_id#
    </cfquery> 

    <cfquery name="get_man_check" datasource="next_destekportal">
        SELECT * FROM MANAGERS_LOGIN_CODE 
            WHERE MANAGER_ID=#form.manager_id_#
    </cfquery> 

     <div class="chat-content d-lg-flex">
                        <!-- start chat conversation section -->
        <div class="w-100 overflow-hidden position-relative" >
            <!-- conversation user -->
            <div id="users-chat" class="position-relative overflow-auto" style="overflow-y: scroll;" >
                            
                            <cfset manager_id_ =get_man_check.manager_id> 
                            <input type="hidden" name="manager_id_" id="manager_id_" value="<cfoutput>#get_man_check.manager_id#</cfoutput>">   
                            <div class="p-3 p-lg-4 user-chat-topbar">
                                <div class="row align-items-center">
                                    <div class="col-sm-4 col-8">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 d-block d-lg-none me-3">
                                                <a href="javascript: void(0);" class="user-chat-remove font-size-18 p-1"><i class="bx bx-chevron-left align-middle"></i></a>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden" > 
                                                <input type="hidden" class="message_manager_id" id="message_manager_id" value="<cfoutput>#form.manager_id#</cfoutput>"> 
                                                <div class="d-flex align-items-center">                            
                                                    <div class="flex-shrink-0 chat-user-img online user-own-img align-self-center me-3 ms-0" id="your_image">
                                                        <img src="assets/images/users/<cfoutput><cfif len(managers.MANAGER_PHOTO)>#managers.MANAGER_PHOTO#<cfelse>user-dummy-img.jpg</cfif></cfoutput>" class="rounded-circle avatar-sm" >
                                                        <span class="user-status"></span>
                                                    </div>
                                                    <div class="flex-grow-1 overflow-hidden" >
                                                        <h6 class="text-truncate mb-0 font-size-18"><a href="#" class="user-profile-show text-reset manager_name_rename2" ><cfoutput>#managers.NAME_#</cfoutput></a></h6>
                                                        <p class="text-truncate text-muted mb-0"><small>Online</small></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 col-4">
                                        <ul class="list-inline user-chat-nav text-end mb-0">                                        
                                            <li class="list-inline-item">
                                                <div class="dropdown">
                                                    <button class="btn nav-btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class='bx bx-search'></i>
                                                    </button>
                                                    <div class="dropdown-menu p-0 dropdown-menu-end dropdown-menu-lg">
                                                        <div class="search-box p-2">
                                                            <input type="text" class="form-control" placeholder="Search.." id="searchChatMessage">
                                                        </div>
                                                    </div>
                                                </div>
                                            </li> 
                                             <li class="list-inline-item d-none d-lg-inline-block me-2 ms-0">
                                                <button type="button" class="btn nav-btn user-profile-show">
                                                    <i class='bx bxs-info-circle'></i>
                                                </button>
                                            </li>
                                            <li class="list-inline-item">
                                                <div class="dropdown">
                                                    <button class="btn nav-btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class='bx bx-dots-vertical-rounded' ></i>
                                                    </button>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex justify-content-between align-items-center d-lg-none user-profile-show" href="#">View Profile <i class="bx bx-user text-muted"></i></a>
                                                        <cfif is_close eq 1><a class="dropdown-item d-flex justify-content-between align-items-center is_solved" href="#">Çözüldü <i class="bx bx-archive text-muted"></i></a></cfif>
                                                        <a class="dropdown-item d-flex justify-content-between align-items-center is_chat_delete" href="#">Delete <i class="bx bx-trash text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </li>                                        
                                        </ul>                                    
                                    </div>
                                </div>
                            <!---    <div class="alert alert-warning alert-dismissible topbar-bookmark fade show p-1 px-3 px-lg-4 pe-lg-5 pe-5" role="alert">
                                    <div class="d-flex align-items-start bookmark-tabs">
                                        <div class="tab-list-link">
                                            <a href="#" class="tab-links" data-bs-toggle="modal" data-bs-target=".pinnedtabModal"><i class="ri-pushpin-fill align-middle me-1"></i> 10 Pinned</a>
                                        </div>
                                        <div>
                                            <a href="#" class="tab-links border-0 px-3" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="bottom" title="Add Bookmark"><i class="ri-add-fill align-middle"></i></a>
                                        </div>
                                    </div>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div> --->

                            </div>
                            <!-- end chat user head -->

                            <!-- start chat conversation -->

                            <div class="chat-conversation p-3 p-lg-4 testtt " id="chat-conversation" data-simplebar >
                                     <ul class="list-unstyled chat-conversation-list chat_list_all " id="users-conversation" > 
                                            <cfquery name="messages_detail" datasource="next_destekportal">
                                                    SELECT  
                                                        M.MANAGER_NAME+' '+M.MANAGER_SURNAME AS KISI1,
                                                        *
                                                        FROM 
                                                            CHATS C   
                                                            LEFT JOIN MANAGERS M ON C.SENDER_ID = M.MANAGER_ID
                                                            LEFT JOIN MANAGERS MM ON C.RECEIVER_ID = mM.MANAGER_ID
                                                        WHERE 
                                                        
                                                        (C.SENDER_ID = #manager_id_# AND RECEIVER_ID =#form.manager_id#) OR  (C.SENDER_ID =#form.manager_id# AND RECEIVER_ID=#manager_id_#)
                                                        ORDER BY SEND_DATE
                                            </cfquery>
 
                                            <cfoutput query="messages_detail">
                                                <li class="chat-list chat_manager_#managers.manager_id# chat_id_#id# <cfif sender_id eq manager_id_>right<cfelse>left</cfif>" id="chat-list" >
                                                    <div class="conversation-list">
                                                        <cfif sender_id neq manager_id_>
                                                            <div class="chat-avatar">
                                                                <img src="assets/images/users/<cfif len(MANAGER_PHOTO)>#MANAGER_PHOTO#<cfelse>user-dummy-img.jpg</cfif>" alt="">
                                                            </div>
                                                        </cfif>
                                                        <div class="user-chat-content">
                                                            <div class="ctext-wrap"> 
                                                             <cfif photo_file eq 1>
                                                            <div class="ctext-wrap-content" style="background-color: rgba(var(--bs-primary-rgb),.23) !important;">
                                                                <div class="message-img mb-0">
                                                                    <div class="message-img-list">
                                                                        <div>
                                                                            <a class="popup-img d-inline-block" href="assets/chat_images/#MESSAGE#" target="_blank"> <img src="assets/chat_images/#MESSAGE#" alt="" class="rounded border" width="200"/> </a>
                                                                        </div>
                                                                        <div class="message-img-link">
                                                                            <ul class="list-inline mb-0">
                                                                                <li class="list-inline-item dropdown">
                                                                                    <a class="dropdown-toggle" href="##" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="bx bx-dots-horizontal-rounded"></i> </a>
                                                                                    <div class="dropdown-menu">
                                                                                         <a class="dropdown-item d-flex align-items-center justify-content-between" href="assets/images/small/img-1.jpg" download="">Download <i class="bx bx-download ms-2 text-muted"></i></a>
                                                                                    <cfif sender_id eq manager_id_>
                                                                                        <a class="dropdown-item d-flex align-items-center justify-content-between delete-image" style="cursor:pointer" onclick="delete_item(#id#)">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                                                    </cfif>
                                                                                    </div>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>   
                                                            </div> 
                                                            <cfelseif photo_file eq 2>
                                                                <div class="ctext-wrap-content">
                                                                    <div class="p-3 border-primary border rounded-3">
                                                                        <div class="d-flex align-items-center attached-file">
                                                                            <div class="flex-shrink-0 avatar-sm me-3 ms-0 attached-file-avatar">
                                                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle font-size-20"><i class="ri-attachment-2"></i></div>
                                                                            </div>
                                                                            <div class="flex-grow-1 overflow-hidden">
                                                                                <div class="text-start">
                                                                                    <h5 class="font-size-14 mb-1">#MESSAGE#</h5>
                                                                                    <p class="text-muted text-truncate font-size-13 mb-0"></p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="flex-shrink-0 ms-4">
                                                                                <div class="d-flex gap-2 font-size-20 d-flex align-items-start">
                                                                                    <div>
                                                                                        <a href="##" class="text-muted download-file" data-id="2"> <i class="bx bxs-download"></i> </a>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="dropdown align-self-start message-box-drop">
                                                                    <cfif sender_id eq manager_id_>
                                                                        <a class="dropdown-toggle" href="" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ri-more-2-fill"></i> </a>
                                                                         <div class="dropdown-menu">
                                                                            <cfif sender_id eq manager_id_>
                                                                                <a class="dropdown-item d-flex align-items-center justify-content-between delete-image" style="cursor:pointer" onclick="delete_item(#id#)">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                                            </cfif>
                                                                        </div>
                                                                    </cfif>
                                                                </div>
                                                            <cfelse>
                                                                <div class="ctext-wrap-content">
                                                                    <p class="mb-0 ctext-content">
                                                                        #MESSAGE#
                                                                     </p>
                                                                </div>
                                                                  <div class="dropdown align-self-start message-box-drop">
                                                                    <cfif sender_id eq manager_id_>
                                                                        <a class="dropdown-toggle" href="" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ri-more-2-fill"></i> </a>
                                                                    </cfif>
                                                                    <div class="dropdown-menu">
                                                                        <a class="dropdown-item d-flex align-items-center justify-content-between delete-item" style="cursor:pointer" id="delete-item-1" onclick="delete_item(#id#)">Delete <i class="bx bx-trash text-muted ms-2"></i></a>
                                                                    </div>
                                                                </div>
                                                            </cfif>
                                                            </div>
                                                            <div class="conversation-name">
                                                                <small class="text-muted time">#timeformat(SEND_DATE,'HH:MM')#</small>
                                                                <span class="text-success check-message-icon"><i class="bx bx-check"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <cfif sender_id neq manager_id_>
                                                    <cfquery name="upd__" datasource="next_destekportal">
                                                        UPDATE CHATS SET
                                                        IS_VIEW = 1
                                                        WHERE ID IN (#id#)
                                                    </cfquery> 
                                                </cfif>  
                                            </cfoutput>
                                     </ul>       
                             </div>
 
                           <!---  <div class="alert alert-warning alert-dismissible copyclipboard-alert px-4 fade show " id="copyClipBoard" role="alert">
                                 message copied
                            </div>
                            <div class="alert alert-warning alert-dismissible copyclipboard-alert px-4 fade" id="copyClipBoardChannel" role="alert">
                                message copied
                            </div>
       --->

                            <!-- end chat conversation end -->
                            </div>
 
                            <!-- start chat input section -->
                              <!-- s<script>
                                alert("asd");
                                var d = $('.user_chat_add');
                                d.animate({ scrollTop:d.height()}, 1000);

                            </script> -->

                            <div class="position-relative" >
                                <div class="chat-input-section p-3 p-lg-3"> 
                                    <form id="chatinput-form" enctype="multipart/form-data" > 
                                        <div class="row g-0 align-items-center">  
                                            <div class="file_Upload">
                                            <div class="profile-media-img image_pre">
                                                
                                            </div>
                                        </div>

                                            <div class="col-auto">
                                                <div class="chat-input-links me-md-2">
                                                    <div class="links-list-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="" data-bs-original-title="More" aria-describedby="tooltip649604">
                                                        <button type="button" class="btn btn-link text-decoration-none btn-lg waves-effect collapsed file-btn"  data-bs-toggle="collapse" data-bs-target="#chatinputmorecollapse" aria-expanded="false" aria-controls="chatinputmorecollapse">
                                                            <i class="bx bx-dots-horizontal-rounded align-middle"></i>
                                                        </button>
                                                    </div>
                                                    <div class="links-list-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="" data-bs-original-title="Emoji">
                                                        <button type="button" class="btn btn-link text-decoration-none btn-lg waves-effect emoji-btn" id="emoji-btn" data-bs-toggle="collapse" data-bs-target="#hazir_cevap" aria-expanded="false" aria-controls="hazir_cevap">
                                                            HC
                                                        </button>
                                                        
                                                     </div> 
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="position-relative">
                                                    <div class="chat-input-feedback">
                                                        Lütfen Geçerli Bir Mesaj Giriniz
                                                    </div>  
                                                    <input autocomplete="off" type="text" class="form-control form-control-lg chat-input chat_input_<cfoutput>#form.manager_id#</cfoutput>" id="chat-input" placeholder="Mesaj Yazınız..."  >
                                                 </div>
                                                 
                                            </div>
                                            <div class="col-auto">
                                                <div class="chat-input-links ms-2 gap-md-1">
                                                     <div class="links-list-item"   onclick="submit_btn(<cfoutput>#form.manager_id#</cfoutput>)">
                                                        <button type="button" class="btn btn-primary btn-lg chat-send waves-effect waves-light"  data-bs-toggle="collapse" data-bs-target=".chat-input-collapse1.show">
                                                            <i class="bx bxs-send align-middle" ></i>
                                                        </button>
                                                    </div>
                                                 </div>
                                            </div>
                                        </div>
                                    </form>  
                                    <div class="row col-md-12 chat-input-collapse chat-input-collapse1 collapse overflow-hidden chatinputmorecollapse" id="chatinputmorecollapse"  >
                                        <div class="card mb-0">
                                            <div class="card-body py-3">
                                                <!-- Swiper -->
                                                  <div class="swiper chatinput-links swiper-initialized swiper-horizontal overflow-hidden" style="overflow-x:hidden;overflow:hidden" >
                                                    <div class="swiper-wrapper row " id="swiper-wrapper-973d50b44e10c76de" aria-live="polite" style="display: flex;justify-content: center;transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                                                        <div class="swiper-slide swiper-slide-active col-sm-2" role="group" aria-label="1 / 7">
                                                            <div class="text-center px-2 position-relative">
                                                                <div>
                                                                 
                                                                    <input id="attachedfile-input" type="file" class="d-none" accept=".zip,.rar,.7zip,.pdf,image/png, image/gif, image/jpeg" multiple="">
                                                                    <label for="attachedfile-input" class="avatar-sm mx-auto stretched-link">
                                                                        <span class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                            <i class="bx bx-paperclip"></i>
                                                                        </span>
                                                                    </label>
                                                                </div>
                                                                <h5 class="font-size-11 text-uppercase mt-3 mb-0 text-body text-truncate">Attached</h5>
                                                            </div>
                                                        </div>
                                                        <div class="swiper-slide swiper-slide-next col-sm-2" role="group" aria-label="2 / 7">
                                                            <div class="text-center px-2">
                                                                <div class="avatar-sm mx-auto">
                                                                    <div class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                        <i class="bx bxs-camera"></i>
                                                                    </div>
                                                                </div>
                                                                <h5 class="font-size-11 text-uppercase text-truncate mt-3 mb-0"><a href="#" class="text-body stretched-link" onclick="cameraPermission()">Camera</a></h5>
                                                            </div>
                                                        </div>
                                                        <div class="swiper-slide col-sm-2" role="group" aria-label="3 / 7"   <!---  onchange="gallery_(<cfoutput>#manager_id#</cfoutput>)" --->>
                                                            <div class="text-center px-2 position-relative" >
                                                                <div>
                                                                    <input type="hidden" class="photo_url_" id="photo_url_" value=""> 
                                                                    <input id="galleryfile-input" type="file" class="d-none" accept="image/png, image/gif, image/jpeg">
                                                                    <label for="galleryfile-input" class="avatar-sm mx-auto stretched-link">
                                                                        <span class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                            <i class="bx bx-images"></i>
                                                                        </span>
                                                                    </label>
                                                                </div>
                                                                <h5 class="font-size-11 text-uppercase text-truncate mt-3 mb-0">Gallery</h5>
                                                            </div>
                                                        </div>
                                                    <!---     <div class="swiper-slide col-sm-2" role="group" aria-label="4 / 7">
                                                            <div class="text-center px-2">
                                                                <div>
                                                                    <input id="audiofile-input" type="file" class="d-none" accept="audio/*" multiple="">
                                                                    <label for="audiofile-input" class="avatar-sm mx-auto stretched-link">
                                                                        <span class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                            <i class="bx bx-headphone"></i>
                                                                        </span>
                                                                    </label>
                                                                </div>
                                                                <h5 class="font-size-11 text-uppercase text-truncate mt-3 mb-0">Audio</h5>
                                                            </div>
                                                        </div> --->
                                                        <div class="swiper-slide col-sm-2" role="group" aria-label="5 / 7" onclick="getLocation(<cfoutput>#manager_id#</cfoutput>)">
                                                            <div class="text-center px-2">
                                                                <div class="avatar-sm mx-auto">
                                                                    <div class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                        <i class="bx bx-current-location"></i>
                                                                    </div>
                                                                </div>
                                                                 <h5 class="font-size-11 text-uppercase text-truncate mt-3 mb-0"><a href="#" class="text-body stretched-link" >Location</a></h5>
                                                            </div>
                                                        </div>
                                                   <!---     <div class="swiper-slide col-sm-2" role="group" aria-label="6 / 7" >
                                                            <div class="text-center px-2">
                                                                <div class="avatar-sm mx-auto">
                                                                    <div class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                        <i class="bx bxs-user-circle"></i>
                                                                    </div>
                                                                </div>
                                                                <h5 class="font-size-11 text-uppercase text-truncate mt-3 mb-0"><a href="#" class="text-body stretched-link" data-bs-toggle="modal" data-bs-target=".contactModal">Contacts</a></h5>
                                                            </div>
                                                        </div>
                                     
                                                        <div class="swiper-slide d-block d-sm-none" role="group" aria-label="7 / 7" >
                                                            <div class="text-center px-2">
                                                                <div class="avatar-sm mx-auto">
                                                                    <div class="avatar-title font-size-18 bg-soft-primary text-primary rounded-circle">
                                                                        <i class="bx bx-microphone"></i>
                                                                    </div>
                                                                </div>
                                                                <h5 class="font-size-11 text-uppercase text-truncate mt-3 mb-0"><a href="#" class="text-body stretched-link">Audio</a></h5>
                                                            </div>
                                                        </div> --->
                                                    </div>
                                                <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>  
                                            </div>
                                        </div>
                                    </div>
                                    <!--- HAZIR CEVAP COLLAPSE UD.--->
                                    <div class="chat-input-collapse chat-input-collapse1 collapse hazir_cevap<cfoutput>#form.manager_id#</cfoutput> hazir_cevap_collapse" style="overflow-y: scroll !important;max-height: 400px !important;" id="hazir_cevap">
                                        <div class="card mb-0">
                                            <div class="card-body py-3">
                                                 <!-- Swiper -->
                                                    <div class="card-header bg-white text-right" style="text-align:right">   
                                                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target=".cannedmodal">
                                                            Ekle
                                                        </button>  
                                                    </div>
                                                     <!-- Modal -->
                                                     <div class="swiper chatinput-links swiper-initialized swiper-horizontal">
                                                        <div class="swiper-wrapper row " id="swiper-wrapper-973d50b44e10c76de" aria-live="polite" style="display: flex;justify-content: center;transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                                                            <div class="panel-collapse">
                                                            <ul class="list-group" id="canned_answer_prepend">
                                                            <cfquery name="canned_answer" datasource="next_destekportal">
                                                                    SELECT * FROM CANNED_ANSWER
                                                            </cfquery>
                                                                <cfoutput query="canned_answer">
                                                                    <li class="list-group-item" style="cursor:pointer" id="hazir_cevap_#ANSWER_ID#">#ANSWER#</li>
                                                                </cfoutput>
                                                            </ul>
                                                            </div>
                                                            <script>
                                                                $('.list-group-item').click(function () {
                                                                    var manager_id = $("#message_manager_id").val();
                                                                    $(`.hazir_cevap${manager_id}`).collapse("toggle");
                                                                    $(".chat-input").val($(this).text())
                                                                })
                                                            </script>
                                                        </div>
                                                        <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                                    </div>   
                                            </div>  
                                        </div>   
                                    </div>  
                                     <!--- HAZIR CEVAP COLLAPSE UD.--->

                                    <!--- KONUM COLLAPSE UD.--->
                                    <div class="chat-input-collapse chat-input-collapse1 collapse konum_yazdir" style="overflow-y: scroll !important;max-height: 400px !important;" id="konum_yazdir<cfoutput>#form.manager_id#</cfoutput>">
                                        <div class="card mb-0">
                                            <div class="card-body py-3">
                                                    <div class="bg-white text-right" style="text-align:right">   
                                                        <span class="btn btn-gray btn-sm konum_yazdir_close" >
                                                            Kapat
                                                        </span>  
                                                    </div>
                                                     <div class="swiper chatinput-links swiper-initialized swiper-horizontal">
                                                        <div class="swiper-wrapper row " id="swiper-wrapper-973d50b44e10c76de" aria-live="polite" style="display: flex;justify-content: center;transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                                                            <div class="card konum_html">
                                                                <div class="row">
                                                                     
                                                                        <div class="col-md-12" style="text-align:center">
                                                                            Konum <br>
                                                                            E :<span class="latitude">  </span> <br>
                                                                            B :<span class="longitutde">  </span> <br>
                                                                        </div>
                                                                     
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                         <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                                </div>   
                                        </div>  
                                    </div>   
                                      <!--- KONUM COLLAPSE UD.---> 
                                  

                                    <div class="chat-input-collapse chat-input-collapse1 collapse hazir_cevap<cfoutput>#form.manager_id#</cfoutput> hazir_cevap_collapse" style="overflow-y: scroll !important;max-height: 400px !important;" id="hazir_cevap">
                                        <div class="card mb-0">
                                            <div class="card-body py-3">
                                                 <!-- Swiper -->
                                                    <div class="card-header bg-white text-right" style="text-align:right">   
                                                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target=".cannedmodal">
                                                            Ekle
                                                        </button>  
                                                    </div>
                                                     <!-- Modal -->
                                                     <div class="swiper chatinput-links swiper-initialized swiper-horizontal">
                                                        <div class="swiper-wrapper row " id="swiper-wrapper-973d50b44e10c76de" aria-live="polite" style="display: flex;justify-content: center;transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                                                            <div class="panel-collapse">
                                                            <ul class="list-group" id="canned_answer_prepend">
                                                            <cfquery name="canned_answer" datasource="next_destekportal">
                                                                    SELECT * FROM CANNED_ANSWER
                                                            </cfquery>
                                                                <cfoutput query="canned_answer">
                                                                    <li class="list-group-item" style="cursor:pointer" id="hazir_cevap_#ANSWER_ID#">#ANSWER#</li>
                                                                </cfoutput>
                                                            </ul>
                                                            </div>
                                                            <script>
                                                                $('.list-group-item').click(function () {
                                                                    var manager_id = $("#message_manager_id").val();
                                                                    $(`.hazir_cevap${manager_id}`).collapse("toggle");
                                                                    $(".chat-input").val($(this).text())
                                                                })
                                                            </script>
                                                        </div>
                                                    <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                                                    </div>   
                                            </div>  
                                        </div>   
                                    </div>  
                                     <!--- HAZIR CEVAP COLLAPSE UD.--->
                                </div>
                                <div class="replyCard">
                                    <div class="card mb-0">
                                        <div class="card-body py-3">
                                            <div class="replymessage-block mb-0 d-flex align-items-start">
                                                <div class="flex-grow-1">
                                                    <h5 class="conversation-name"></h5>
                                                    <p class="mb-0"></p>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <button type="button" id="close_toggle" class="btn btn-sm btn-link mt-n2 me-n3 font-size-18">
                                                        <i class="bx bx-x align-middle"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end chat input section -->
                        </div>
                        <!-- end chat conversation section -->
        
                        <!-- start User profile detail sidebar -->
                        <div class="user-profile-sidebar">
                             <div class="p-3 border-bottom">
                                <div class="user-profile-img">
                                    <img src="assets/images/users/<cfoutput>#managers.MANAGER_PHOTO#</cfoutput>" class="profile-img rounded" alt="">
                                    <div class="overlay-content rounded">
                                        <div class="user-chat-nav p-2">
                                            <div class="d-flex w-100">
                                                <div class="flex-grow-1">
                                                    <button type="button" class="btn nav-btn text-white d-none d-lg-block user-profile-hide">
                                                        <i class="bx bx-x"></i>
                                                    </button>
                                                    <button type="button" class="btn nav-btn text-white d-block d-lg-none user-profile-hide">
                                                        <i class="bx bx-left-arrow-alt"></i>
                                                    </button>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="dropdown">
                                                        <button class="btn nav-btn text-white dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class='bx bx-dots-vertical-rounded'></i>
                                                        </button>
                                                        <div class="dropdown-menu dropdown-menu-end">
                                                            <a class="dropdown-item d-flex justify-content-between align-items-center d-lg-none user-profile-show" href="#">View Profile <i class="bx bx-user text-muted"></i></a>
                                                            <cfif is_close eq 1>
                                                                <a class="dropdown-item d-flex justify-content-between align-items-center is_solved" href="#">Çözüldü <i class="bx bx-archive text-muted"></i></a>
                                                            </cfif>
                                                            <a class="dropdown-item d-flex justify-content-between align-items-center is_chat_delete" href="#">Delete <i class="bx bx-trash text-muted"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mt-auto p-3">
                                            <h5 class="user-name mb-1 text-truncate"><cfoutput>#managers.NAME_#</cfoutput></h5>
                                            <p class="font-size-14 text-truncate mb-0"><i class="bx bxs-circle font-size-10 text-success me-1 ms-0"></i> Online</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End profile user -->

                            <!-- Start user-profile-desc -->
                            <div class="p-4 user-profile-desc" data-simplebar>

                                <div class="text-center border-bottom">
                                    <div class="row">
                                        <div class="col-sm col-4 user-profile-hide-focus">
                                            <div class="mb-4">
                                                <button type="button" class="btn avatar-sm p-0">
                                                    <span class="avatar-title rounded bg-light text-body">
                                                        <i class="bx bxs-message-alt-detail"></i>
                                                    </span>
                                                </button>
                                                <h5 class="font-size-11 text-uppercase text-muted mt-2 ">Message</h5>
                                            </div>
                                        </div>
                                        <div class="col-sm col-4">
                                            <div class="mb-4">
                                                <button type="button" class="btn avatar-sm p-0 favourite-btn">
                                                    <span class="avatar-title rounded bg-light text-body">
                                                        <i class="bx bx-heart"></i>
                                                    </span>
                                                </button>
                                                <h5 class="font-size-11 text-uppercase text-muted mt-2">Favourite</h5>
                                            </div>
                                        </div>
                                        <!--- <div class="col-sm col-4">
                                            <div class="mb-4">
                                                <button type="button" class="btn avatar-sm p-0" data-bs-toggle="modal" data-bs-target=".audiocallModal">
                                                    <span class="avatar-title rounded bg-light text-body">
                                                        <i class="bx bxs-phone-call"></i>
                                                    </span>
                                                </button>
                                                <h5 class="font-size-11 text-uppercase text-muted mt-2">Audio</h5>
                                            </div>
                                        </div> 
                                        <div class="col-sm col-4">
                                            <div class="mb-4">
                                                <button type="button" class="btn avatar-sm p-0" data-bs-toggle="modal" data-bs-target=".videocallModal">
                                                    <span class="avatar-title rounded bg-light text-body">
                                                        <i class="bx bx-video"></i>
                                                    </span>
                                                </button>
                                                <h5 class="font-size-11 text-uppercase text-muted mt-2">Video</h5>
                                            </div>
                                        </div>--->
                                        <div class="col-sm col-4">
                                            <div class="mb-4">
                                                <div class="dropdown">
                                                    <button class="btn avatar-sm p-0 dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="avatar-title bg-light text-body rounded">
                                                            <i class='bx bx-dots-horizontal-rounded'></i>
                                                        </span>
                                                    </button>
                                
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                    <cfif is_close eq 1>
                                                        <a class="dropdown-item d-flex justify-content-between align-items-center is_solved" href="#">Çözüldü <i class="bx bx-archive text-muted"></i></a>
                                                    </cfif>
                                                        <a class="dropdown-item d-flex justify-content-between align-items-center is_chat_delete" href="#">Delete <i class="bx bx-trash text-muted"></i></a>
                                                    </div>
                                                </div>
                                                <h5 class="font-size-11 text-uppercase text-muted mt-2">More</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-muted pt-4">
                                    <h5 class="font-size-11 text-uppercase">Status :</h5>
                                    <p class="mb-4">...</p>
                                </div>

                                <div class="pb-2 edit_profile_hide">
                                    <h5 class="font-size-11 text-uppercase mb-2 ">İsim :</h5>
                                    <div>
                                        <div class="d-flex align-items-end">
                                            <div class="flex-grow-1">
                                                <p class="text-muted font-size-14 mb-1 edit_manager_name"><cfoutput>#managers.NAME_#</cfoutput></p>
                                            </div>
                                            <div class="flex-shrink-0">
                                                <button type="button" class="btn btn-sm btn-soft-primary" onclick="profile_edit(<cfoutput>#form.manager_id#</cfoutput>)">Edit</button>
                                            </div>
                                        </div>
                                        <h5 class="font-size-14 text-truncate"></h5>
                                    </div>

                                    <!--- <div class="mt-4">
                                        <p class="text-muted font-size-14 mb-1">Email</p>
                                        <h5 class="font-size-14">adc@123.com</h5>
                                    </div>
 --->
                                    <div class="mt-4">
                                        <p class="text-muted font-size-14 mb-1">Proje</p>
                                        <h5 class="font-size-14 mb-0 edit_project_name">
                                            <cfoutput>
                                                <cfif len(managers.PROJECT_NAME)>
                                                         #managers.PROJECT_NAME#
                                                <cfelse>
                                                        NextStation
                                                </cfif>
                                            </cfoutput>
                                        </h5>
                                    </div>
                                </div>


                                <div class="pb-2 edit_profile_show d-none">
                                
                                    <h5 class="font-size-11 text-uppercase mb-2">İsim :</h5>
                                    <div>
                                        <div class="d-flex align-items-end">
                                            <div class="flex-grow-1">
                                                <input type="text" class="form-control" name="profile_name" id="profile_name<cfoutput>#managers.manager_id#</cfoutput>" value="<cfoutput>#managers.MANAGER_NAME#  </cfoutput>">
                                            </div>
                                            <div class="flex-grow-1">
                                                <input type="text" class="form-control" name="profile_surname" id="profile_surname<cfoutput>#managers.manager_id#</cfoutput>" value="<cfoutput>#managers.MANAGER_SURNAME#</cfoutput>">
                                            </div>
                                        </div>
                                        <h5 class="font-size-14 text-truncate"></h5>
                                    </div>

                                    <cfquery name="get_project" datasource="next_destekportal">
                                        SELECT * FROM SETUP_PROJECT
                                    </cfquery>
                                    <div class="mt-4">
                                        <p class="text-muted font-size-14 mb-1">Proje</p>
                                        <select name="profile_project" id="profile_project<cfoutput>#managers.manager_id#</cfoutput>" class="form-control">
                                            <option value="0">Seçiniz</option>
                                            <cfoutput query="get_project">
                                                <option value="#project_id#" <cfif managers.project_id eq project_id> selected</cfif>>#project_name#</option>
                                            </cfoutput>
                                        </select>
                                    </div>
                                    <div class="mt-4">
                                        <button type="button" class="btn btn-success" onclick="profile_save_button(<cfoutput>#form.manager_id#</cfoutput>)"> Kaydet</button>
                                    </div>
                            
                                </div>
                                <hr class="my-4">
<!--- 
                                <div>
                                    <div class="d-flex">
                                        <div class="flex-grow-1">
                                            <h5 class="font-size-11 text-muted text-uppercase">Group in common</h5>
                                        </div>
                                    </div>
                
                                    <ul class="list-unstyled chat-list mx-n4">
                                        <li>
                                            <a href="javascript: void(0);">
                                                <div class="d-flex align-items-center">                            
                                                    <div class="flex-shrink-0 avatar-xs me-2">
                                                        <span class="avatar-title rounded-circle bg-soft-light text-dark">
                                                            #
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 overflow-hidden">
                                                        <p class="text-truncate mb-0">Landing Design</p>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript: void(0);">
                                                <div class="d-flex align-items-center">                            
                                                    <div class="flex-shrink-0 avatar-xs me-2">
                                                        <span class="avatar-title rounded-circle bg-soft-light text-dark">
                                                            #
                                                        </span>
                                                    </div>
                                                    <div class="flex-grow-1 overflow-hidden">
                                                        <p class="text-truncate mb-0">Design Phase 2</p>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div> --->

                                <hr class="my-4">
                       
                                <div>
                                    <div class="d-flex">
                                        <div class="flex-grow-1">
                                            <h5 class="font-size-11 text-muted text-uppercase">Media</h5>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <a href="#" class="font-size-12 d-block mb-2 open_gallery_modal ">Show all</a>
                                        </div>
                                    </div>
                                    <cfquery name="get_photos" datasource="next_destekportal">
                                        SELECT   TOP 4
                                            MESSAGE
                                            FROM 
                                                CHATS C   
                                                LEFT JOIN MANAGERS M ON C.SENDER_ID = M.MANAGER_ID
                                                LEFT JOIN MANAGERS MM ON C.RECEIVER_ID = mM.MANAGER_ID
                                            WHERE 
                                            PHOTO_FILE  =1 AND 
                                            ((C.SENDER_ID = #manager_id_# AND RECEIVER_ID =#form.manager_id#) OR  (C.SENDER_ID =#form.manager_id# AND RECEIVER_ID=#manager_id_#))  
                                            ORDER BY SEND_DATE
                                    </cfquery>
                                <cfif get_photos.recordcount> 
                                     <div class="profile-media-img">
                                    <cfoutput query="get_photos">
                                        <div class="media-img-list">
                                            <a href="##">
                                                <img src="assets/chat_images/#MESSAGE#" alt="media img" class="img-fluid">
                                                <cfif get_photos.recordcount eq currentrow and currentrow eq 4>
                                                    <div class="bg-overlay open_gallery_modal ">daha fazla </div>
                                                </cfif>
                                            </a>
                                        </div>
                                     </cfoutput>
                                     </div>
                                </cfif>
                                </div>
                         
                                <hr class="my-4">

                                <div>
                                    <div>
                                        <h5 class="font-size-11 text-muted text-uppercase mb-3">Attached Files</h5>
                                    </div>
                
                                    <div>
                                        <div class="card p-2 border mb-2">
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 avatar-xs ms-1 me-3">
                                                    <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                        <i class="bx bx-file"></i>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <h5 class="font-size-14 text-truncate mb-1">design-phase-1-approved.pdf</h5>
                                                    <p class="text-muted font-size-13 mb-0">12.5 MB</p>
                                                </div>

                                                <div class="flex-shrink-0 ms-3">
                                                    <div class="d-flex gap-2">
                                                        <div>
                                                            <a href="#" class="text-muted px-1">
                                                                <i class="bx bxs-download"></i>
                                                            </a>
                                                        </div>
                                                        <div class="dropdown">
                                                            <a class="dropdown-toggle text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-horizontal-rounded"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Share <i class="bx bx-share-alt ms-2 text-muted"></i></a>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Bookmark <i class="bx bx-bookmarks text-muted ms-2"></i></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card p-2 border mb-2">
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 avatar-xs ms-1 me-3">
                                                    <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                        <i class="bx bx-image"></i>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <h5 class="font-size-14 text-truncate mb-1">Image-1.jpg</h5>
                                                    <p class="text-muted font-size-13 mb-0">4.2 MB</p>
                                                </div>

                                                <div class="flex-shrink-0 ms-3">
                                                    <div class="d-flex gap-2">
                                                        <div>
                                                            <a href="#" class="text-muted px-1">
                                                                <i class="bx bxs-download"></i>
                                                            </a>
                                                        </div>
                                                        <div class="dropdown">
                                                            <a class="dropdown-toggle text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-horizontal-rounded"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Share <i class="bx bx-share-alt ms-2 text-muted"></i></a>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Bookmark <i class="bx bx-bookmarks text-muted ms-2"></i></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card p-2 border mb-2">
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 avatar-xs ms-1 me-3">
                                                    <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                        <i class="bx bx-image"></i>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <h5 class="font-size-14 text-truncate mb-1">Image-2.jpg</h5>
                                                    <p class="text-muted font-size-13 mb-0">3.1 MB</p>
                                                </div>

                                                <div class="flex-shrink-0 ms-3">
                                                    <div class="d-flex gap-2">
                                                        <div>
                                                            <a href="#" class="text-muted px-1">
                                                                <i class="bx bxs-download"></i>
                                                            </a>
                                                        </div>
                                                        <div class="dropdown">
                                                            <a class="dropdown-toggle text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-horizontal-rounded"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Share <i class="bx bx-share-alt ms-2 text-muted"></i></a>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Bookmark <i class="bx bx-bookmarks text-muted ms-2"></i></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card p-2 border mb-2">
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 avatar-xs ms-1 me-3">
                                                    <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                        <i class="bx bx-file"></i>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <h5 class="font-size-14 text-truncate mb-1">Landing-A.zip</h5>
                                                    <p class="text-muted font-size-13 mb-0">6.7 MB</p>
                                                </div>

                                                <div class="flex-shrink-0 ms-3">
                                                    <div class="d-flex gap-2">
                                                        <div>
                                                            <a href="#" class="text-muted px-1">
                                                                <i class="bx bxs-download"></i>
                                                            </a>
                                                        </div>
                                                        <div class="dropdown">
                                                            <a class="dropdown-toggle text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-horizontal-rounded"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Share <i class="bx bx-share-alt ms-2 text-muted"></i></a>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Bookmark <i class="bx bx-bookmarks text-muted ms-2"></i></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end user-profile-desc -->
                        </div>
                        <!-- end User profile detail sidebar -->
 </div>         

  

    
<script>
    $('.user-profile-show').click(function () {
        $('.user-profile-sidebar').show();
    }) 
    $('.user-chat-remove').click(function () {
        $(".user_chat_add").removeClass("user-chat-show");
    })
    $('.user-profile-hide').click(function () {
        $('.user-profile-sidebar').hide();
    })
    $('.user-profile-hide-focus').click(function () {
        $('.user-profile-sidebar').hide();
        $(".chat-input").focus();
    })
    $('.file-btn').click(function () {
        $(".hazir_cevap_collapse").collapse("hide");
        $(`.konum_yazdir`).collapse("hide");
      }) 
    $(".emoji-btn").click(function ()
    {      
        $(".konum_yazdir").collapse("hide");
        $(".chatinputmorecollapse").collapse("hide");
     })
    $(".konum_yazdir_close").click(function ()
    {
         $(".konum_yazdir").collapse("hide");
     }) 
     $(".open_gallery_modal").click(function ()
        {    
            var manager_id = $("#message_manager_id").val();
                    url_ = 'https://destekportal.com/destekportal/dist/index1912.cfm';
                    $.ajax({
                        type: "POST",
                        url: url_,
                        data: {manager_id:manager_id}, 
                        success: function(data){  
                            console.log(data);
                            $(".gallerymodal").modal('show');
                            $(`.gallerymodal`).html(data);
                        }
                    }); 
        })
    $(".is_solved").click(function ()
    {
        var solved_id = $("#message_manager_id").val();
         $.ajax({
            type: "POST",
            url: `cfc/add_message.cfc?method=solved_message&returnformat=json&solved_id=${solved_id}`,
            success: function (status) { 
                $(`#user-chat-dnone`).removeClass("d-none");
                $(`.user_chat_add`).addClass("d-none");
                $(`#contact-id-${solved_id}`).hide()
                url_ = `http://destekportal.com/destekportal/dist/loading_closed_chats.cfm`;
                $.ajax({
                    type: "POST",
                    url: url_,
                    data: {manager_id:solved_id}, 
                    success: function(data){  
                        $(`.closed_chats`).html(data);
                     }
                });
            }
        });    
     })
    $(".is_chat_delete").click(function ()
    {
        var chat_id = $("#message_manager_id").val();
         $.ajax({
            type: "POST",
            url: `cfc/add_message.cfc?method=delete_chat&returnformat=json&chat_id=${chat_id}`,
            success: function (status) { 
                $(`#user-chat-dnone`).removeClass("d-none");
                $(`.user_chat_add`).addClass("d-none");
                $(`#contact-id-${chat_id}`).hide()
            }
        });    
     })
     
    function profile_edit(manager_id){
       $(".edit_profile_hide").addClass('d-none');
       $(".edit_profile_show").removeClass('d-none');
    }

    function profile_save_button(manager_id){
        
      var profile_name= $(`#profile_name${manager_id}`).val();
      var profile_surname= $(`#profile_surname${manager_id}`).val();
      var profile_project= $(`#profile_project${manager_id}`).val();
       $.ajax({
            type: "POST",
            url: `cfc/add_message.cfc?method=update_managers&returnformat=json&profile_name=${profile_name}&profile_surname=${profile_surname}&profile_project=${profile_project}&man_id=${manager_id}`,
            success: function (status) { 
                $(".edit_profile_hide").removeClass('d-none');
                $(".edit_profile_show").addClass('d-none'); 
                var json_parse = JSON.parse(status); 

                
                $(".edit_manager_name").html(json_parse.DATA[0][0]);
                $('.manager_name_rename2').html(json_parse.DATA[0][0]);
                $(`.manager_name_rename${manager_id}`).html(json_parse.DATA[0][0]);
                $('.user-name').html(json_parse.DATA[0][0]);
                $(".edit_project_name").html(json_parse.DATA[0][1]);
            }
        });     
    }                                               
    function delete_item(message_id){
        $.ajax({
            type: "POST",
            url: `cfc/add_message.cfc?method=delete_message&returnformat=json&message_id=${message_id}`,
            success: function (status) { 
                $(`.chat_id_${message_id}`).remove();
                reloadChat2();
                
              
            }
        });     
    }
   
   function getLocation(manager_id)
        {
             
            $(".chatinputmorecollapse").collapse("hide");
            $(`#konum_yazdir${manager_id}`).collapse("toggle");
            var konum_text = $(".konum_html").text();
            konum_text = konum_text.trim();
            $(".chat-input").val(konum_text);
        
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        }
        else {
        x.innerHTML = "Geolocation is not supported by this browser.";
         }

  }

function showPosition(position) {
    
    $('.latitude').html(position.coords.latitude);
    $('.longitutde').html(position.coords.longitude);
     var konum_text = $(".konum_html").text();
    konum_text = konum_text.trim();
    $(".chat-input").val(konum_text);
    $('#chat-input').attr('readonly', true);


}
    var C = [];
        removeimg = 0;
        var photo_url_= '';
        document.querySelector("#galleryfile-input").addEventListener("change", function() {
            var s = document.querySelector(".file_Upload");
            s.insertAdjacentHTML("beforeend", '<div class="profile-media-img image_pre"></div>');
            var i = document.querySelector(".file_Upload .profile-media-img");
        
            this.files && [].forEach.call(this.files, function(e) {
                if (!/\.(jpe?g|png|gif)$/i.test(e.name)) return alert(e.name + " is not an image");
                var t = new FileReader,
                    a = "";
                t.addEventListener("load", function() { 
                    var photo_url_= (this.result);
                    $("#photo_url_").val(photo_url_);
                   
                    console.log(this.result);         
                    removeimg++, s && s.classList.add("show"), C.push(t.result), a += '<div class="media-img-list" id="remove-image-' + removeimg + '">          <a href="#">              <img src="' + this.result + '" alt="' + e.name + '" class="img-fluid">          </a>            <i class="ri-close-line image-remove" onclick="removeImage(`remove-image-' + removeimg + '`)"></i>          </div>', i.insertAdjacentHTML("afterbegin", a), 0
                }), t.readAsDataURL(e)
            
            })
             
            $(".chatinputmorecollapse").collapse("hide");
             
        });
            //Remove image
        function removeImage(id) {
            document.querySelector("#" + id).remove();
             if (document.querySelectorAll(".image-remove").length == 0) {
            $('.file_Upload').removeClass('show');
                 // console.log($("#galleryfile-input").val(''));
            }
        }
    var q, k, c, L = [],    
        A = 1;
        document.querySelector("#attachedfile-input").addEventListener("change", function() {
            var a = document.querySelector(".file_Upload");
            c = document.querySelector("#attachedfile-input").files[0], fr = new FileReader, fr.readAsDataURL(c), a && a.classList.add("show"), fr.addEventListener("load", function() {
                var e = c.name,
                    t = Math.round(c.size / 1e6).toFixed(2);
                a.innerHTML = '<div class="card p-2 border attchedfile_pre d-inline-block position-relative">            <div class="d-flex align-items-center">                <div class="flex-shrink-0 avatar-xs ms-1 me-3">                    <div class="avatar-title bg-soft-primary text-primary rounded-circle">                        <i class="ri-attachment-2"></i>                    </div>                </div>                <div class="flex-grow-1 overflow-hidden">                <a href="" id="a"></a>                    <h5 class="font-size-14 text-truncate mb-1">' + e + '</h5>                    <input type="hidden" name="downloaddata" value="' + c + '"/>                    <p class="text-muted text-truncate font-size-13 mb-0">' + t + 'mb</p>                </div>                <div class="flex-shrink-0 align-self-start ms-3">                    <div class="d-flex gap-2">                        <div>                        <i class="ri-close-line text-muted attechedFile-remove"  id="remove-attechedFile"></i>                        </div>                    </div>                </div>            </div>          </div>', q = e, k = t, L[A] = c, removeAttachedFile()
            }, !1), A++
            console.log(c.name);
            $(".chatinputmorecollapse").collapse("hide");

        });
        
       
        //Remove Attached Files
        function removeAttachedFile() {
            if (document.getElementById("remove-attechedFile")) {
                document.getElementsByClassName("attechedFile-remove")[0];
                // Delete Upload Preview Attached Files
                document.getElementById("remove-attechedFile").addEventListener("click", function(e) {
                    e.target.closest(".attchedfile_pre").remove();
                });
            }
            var removeButton = document.querySelector("#remove-attechedFile");
            removeButton.addEventListener("click", function() {
            $('.file_Upload').removeClass('show');
            });
        } 
        

    function submit_btn_file(manager_id) {
    var sender_id =$(`#manager_id_`).val();
    var receiver_id = manager_id;
    var photo_url_ =  $("#photo_url_").val();
      $.ajax({
        type: "POST",
        url: `cfc/add_message.cfc?method=getonay_photo&returnformat=json&sender_id=${sender_id}&receiver_id=${receiver_id}`,
        data: {message:photo_url_}, 
        success: function (data) {   
            var json_parse = JSON.parse(data);
            const length = Object.keys(json_parse).length;
            $('.file_Upload').removeClass('show');
             $('.chat_list_all').append(`
                    <li class="chat-list chat_manager_${receiver_id} chat_id_${json_parse.DATA[0][2]} right" id="chat-list" >
                        <div class="conversation-list">
                            <div class="user-chat-content">
                                <div class="ctext-wrap">
                                    <div class="ctext-wrap-content">
                                        <div class="message-img mb-0">
                                            <div class="message-img-list">
                                                <div>
                                                    <a class="popup-img d-inline-block" href="assets/chat_images/${json_parse.DATA[0][0]}"> <img src="assets/chat_images/${json_parse.DATA[0][0]}" alt="" class="rounded border" /> </a>
                                                </div>
                                                <div class="message-img-link">
                                                    <ul class="list-inline mb-0">
                                                        <li class="list-inline-item dropdown">
                                                            <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="bx bx-dots-horizontal-rounded"></i> </a>
                                                            <div class="dropdown-menu">
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="assets/images/small/img-1.jpg" download="">Download <i class="bx bx-download ms-2 text-muted"></i></a>
                                                                <a class="dropdown-item d-flex align-items-center justify-content-between delete-item" style="cursor:pointer" id="delete-item-1" onclick="delete_item(${json_parse.DATA[0][2]})" >Delete <i class="bx bx-trash text-muted ms-2"></i></a>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="conversation-name">
                                    <small class="text-muted time">${json_parse.DATA[0][1]}</small>
                                    <span class="text-success check-message-icon"><i class="bx bx-check"></i></span>
                                </div>
                            </div>
                        </div>
                    </li>
                `);
                 
                $(`.chat_input_${receiver_id}`).val("");
                $('.chat-input-feedback').hide(); 
                $('.remove_class').removeClass("active" );
                $(`#contact-id-${receiver_id}`).addClass( "active" );

                $(`#contact-id-${receiver_id}`).hide().prependTo("#favourite-users").fadeIn();
                $(`#end-message-${receiver_id}`).html(`  <i class="fa fa-image"></i> Görüntü`);
                $(`#end-message-date-${receiver_id}`).html(`${json_parse.DATA[0][1]}`);
                $(`#contact-id-close-${receiver_id}`).hide();
                $('#galleryfile-input').val('');
                $('.media-img-list').remove();
            }
        });      
 }

    function submit_btn_file_attached(manager_id) {
    var sender_id =$(`#manager_id_`).val();
    var receiver_id = manager_id;
    var file_url_ = ($("#attachedfile-input").val());
        

        $.ajax({
        type: "POST",
        url: `cfc/add_message.cfc?method=getonay_file&returnformat=json&sender_id=${sender_id}&receiver_id=${receiver_id}`,
        data: {message:file_url_}, 
        success: function (data) {   
            var json_parse = JSON.parse(data);
            const length = Object.keys(json_parse).length;
            $('.file_Upload').removeClass('show');
            console.log(data);
            $('#attachedfile-input ').val('');
            $('.chat_list_all').append(`
                   <li class="chat-list chat_manager_${receiver_id} chat_id_${json_parse.DATA[0][2]} right" id="chat-list">
                        <div class="conversation-list">
                            <div class="user-chat-content">
                                <div class="ctext-wrap">
                                    <div class="ctext-wrap-content">
                                        <div class="p-3 border-primary border rounded-3">
                                            <div class="d-flex align-items-center attached-file">
                                                <div class="flex-shrink-0 avatar-sm me-3 ms-0 attached-file-avatar">
                                                    <div class="avatar-title bg-soft-primary text-primary rounded-circle font-size-20"><i class="ri-attachment-2"></i></div>
                                                </div>
                                                <div class="flex-grow-1 overflow-hidden">
                                                    <div class="text-start">
                                                        <h5 class="font-size-14 mb-1">${json_parse.DATA[0][0]}</h5>
                                                        <p class="text-muted text-truncate font-size-13 mb-0"></p>
                                                    </div>
                                                </div>
                                                <div class="flex-shrink-0 ms-4">
                                                    <div class="d-flex gap-2 font-size-20 d-flex align-items-start">
                                                        <div>
                                                            <a href="#" class="text-muted download-file" data-id="2"> <i class="bx bxs-download"></i> </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="dropdown align-self-start message-box-drop">
                                        <a class="dropdown-toggle" href="" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ri-more-2-fill"></i> </a>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item d-flex align-items-center justify-content-between delete-image" style="cursor:pointer" onclick="delete_item(${json_parse.DATA[0][2]})">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="conversation-name">
                                    <small class="text-muted time">${json_parse.DATA[0][1]}</small>
                                    <span class="text-success check-message-icon"><i class="bx bx-check"></i></span>
                                </div>
                            </div>
                        </div>
                    </li>

                `);  
                 
                $(`.chat_input_${receiver_id}`).val("");
                $('.chat-input-feedback').hide(); 
                $('.remove_class').removeClass("active" );
                $(`#contact-id-${receiver_id}`).addClass( "active" );

                $(`#contact-id-${receiver_id}`).hide().prependTo("#favourite-users").fadeIn();
                $(`#end-message-${receiver_id}`).html(` <i class="fa fa-file"></i>  Dosya`);
                $(`#end-message-date-${receiver_id}`).html(`${json_parse.DATA[0][1]}`);
                $(`#contact-id-close-${receiver_id}`).hide();
                $('#attachedfile-input ').val('');
                $('.attchedfile_pre').remove();
            }
        });       
 }
</script>

<!--- Start Ajax Message Loading UD.--->

<script language="javascript" type="text/javascript">
    var timeout = setInterval(reloadChat, 1000);    
    function reloadChat () {
    var receiver_id = $("#message_manager_id").val();

    var sender_id=$(`#manager_id_`).val();
        $.ajax({
            type: "POST",
            url: `cfc/add_message.cfc?method=loading_message&returnformat=json&sender_id=${sender_id}&receiver_id=${receiver_id}`,
            success: function (status) {   
            var json_parse = JSON.parse(status);
            var json_parse = json_parse.sizelist;
            const length = Object.keys(json_parse).length;
            //console.log(json_parse[0])
            var ids = new Array();
            for (let i = 0; i < length; i++) {
                var photo_file = json_parse[0].PHOTO_FILE;
                //console.log(photo_file);
                if (photo_file == 1){
                $('.chat_list_all').append(`
                    <li class="chat-list chat_manager_${receiver_id}  left" id="chat-list" >
                        <div class="conversation-list">
                            <div class="chat-avatar">
                                <img src="assets/images/users/${json_parse[0].MANAGER_PHOTO}" alt="">
                            </div>
                            <div class="user-chat-content">
                                <div class="ctext-wrap">
                                        <div class="ctext-wrap-content" style="background-color: rgba(var(--bs-primary-rgb),.23) !important;">
                                            <div class="message-img mb-0">
                                                <div class="message-img-list">
                                                    <div>
                                                        <a class="popup-img d-inline-block" href="assets/chat_images/${json_parse[0].MESSAGE}" target="_blank"> <img src="assets/chat_images/${json_parse[0].MESSAGE}" alt="" class="rounded border" width="200"/> </a>
                                                    </div>
                                                    <div class="message-img-link">
                                                        <ul class="list-inline mb-0">
                                                            <li class="list-inline-item dropdown">
                                                                <a class="dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="bx bx-dots-horizontal-rounded"></i> </a>
                                                                <div class="dropdown-menu">
                                                                    <a class="dropdown-item d-flex align-items-center justify-content-between" href="assets/images/small/img-1.jpg" download="">Download <i class="bx bx-download ms-2 text-muted"></i></a>
                                                                </div>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>   
                                        </div>
                                </div>
                                <div class="conversation-name">
                                    <small class="text-muted time">${json_parse[0].SEND_DATE}</small>
                                    <span class="text-success check-message-icon"><i class="bx bx-check"></i></span>
                                </div>
                            </div>
                        </div>
                    </li>
                `);
                }
                else{
                $('.chat_list_all').append(`
                    <li class="chat-list chat_manager_${receiver_id}  left" id="chat-list" >
                        <div class="conversation-list">
                            <div class="chat-avatar">
                                <img src="assets/images/users/${json_parse[0].MANAGER_PHOTO}" alt="">
                            </div>
                            <div class="user-chat-content">
                                <div class="ctext-wrap">
                                    <div class="ctext-wrap-content">
                                        <p class="mb-0 ctext-content">${json_parse[0].MESSAGE}</p>
                                    </div>
                                    <div class="dropdown align-self-start message-box-drop">
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item d-flex align-items-center justify-content-between delete-item" id="delete-item-1" onclick="delete_item(${json_parse[0].ID})" >Delete <i class="bx bx-trash text-muted ms-2"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="conversation-name">
                                    <small class="text-muted time">${json_parse[0].SEND_DATE}</small>
                                    <span class="text-success check-message-icon"><i class="bx bx-check"></i></span>
                                </div>
                            </div>
                        </div>
                    </li>
                `);
                }
                
                ids.push(json_parse[i].ID);
            } 
            if(ids.length !=0)
                {
                        $.ajax({
                            type: "POST",
                            url: `cfc/add_message.cfc?method=message_is_view&returnformat=json&ids=${ids}`,
                            success: function (status) {   
                            }
                        });
                }  
            }
            });   
    }
</script>

    <!--- End Ajax Message Loading UD.--->

    <!--- Send Message UD.--->
<script>
        
    var message_manager_id = $("#message_manager_id").val();
    
    
    var wage = document.getElementById("chat-input");
    wage.addEventListener("keydown", function (e) {
        if (e.keyCode == 13) {
            e.preventDefault();
             submit_btn(message_manager_id);
          }
    });

     function submit_btn(manager_id)
    {
        var input_file_=$('#galleryfile-input').val();
        if(input_file_)
        {
            submit_btn_file(manager_id);
            return false;
        }
      var input_file_a=$('#attachedfile-input').val();
        if(input_file_a)
        {
            submit_btn_file_attached(manager_id);
            return false;
        }
        var receiver_id = $("#message_manager_id").val();
        var message = $(`.chat_input_${message_manager_id}`).val();

        // alert(message);
        if($(`.chat_input_${message_manager_id}`).val() == '')
        {
            $('.chat-input-feedback').show();
            return false;
        }
 
        var sender_id =$(`#manager_id_`).val();
         
        $.ajax({
        type: "POST",
        url: `cfc/add_message.cfc?method=getonay&returnformat=json&sender_id=${sender_id}&message=${message}&receiver_id=${receiver_id}`,
        success: function (data) {   
                var json_parse = JSON.parse(data);
                // console.log(json_parse);
                $('.chat_list_all').append(`
                    <li class="chat-list chat_manager_${receiver_id} chat_id_${json_parse.DATA[0][2]} right" id="chat-list" >
                        <div class="conversation-list">
                            <div class="user-chat-content">
                                <div class="ctext-wrap">
                                    <div class="ctext-wrap-content">
                                        <p class="mb-0 ctext-content">${json_parse.DATA[0][0]}</p>
                                    </div>
                                    <div class="dropdown align-self-start message-box-drop">
                                        <a class="dropdown-toggle" href="" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="ri-more-2-fill"></i> </a>
                                         <div class="dropdown-menu">
                                            <a class="dropdown-item d-flex align-items-center justify-content-between delete-item" id="delete-item-1" onclick="delete_item(${json_parse.DATA[0][2]})" >Delete <i class="bx bx-trash text-muted ms-2"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <div class="conversation-name">
                                    <small class="text-muted time">${json_parse.DATA[0][1]}</small>
                                    <span class="text-success check-message-icon"><i class="bx bx-check"></i></span>
                                </div>
                            </div>
                        </div>
                    </li>
                `);
                $(`.chat_input_${receiver_id}`).val("");
                $('.chat-input-feedback').hide(); 
                $('.remove_class').removeClass("active" );
                $(`#contact-id-${receiver_id}`).addClass( "active" );

                $(`#contact-id-${receiver_id}`).hide().prependTo("#favourite-users").fadeIn();
                $(`#end-message-${receiver_id}`).html(`${json_parse.DATA[0][0]}`);
                $(`#end-message-date-${receiver_id}`).html(`${json_parse.DATA[0][1]}`);
                $(`#contact-id-close-${receiver_id}`).hide();
                $('#chat-input').attr('readonly', false);
                $(".chat-input").focus();
                 
              }
        });   
 }
</script> 

    <!--- Send Message UD.--->
 
 