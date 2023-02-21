 <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 <cfif isdefined("url.sender_code") and isdefined("url.number")>
  <cfquery name="man" datasource="next_destekportal">
        SELECT * FROM MANAGERS_LOGIN_CODE MLG
        LEFT JOIN MANAGERS M ON M.MANAGER_ID =MLG.MANAGER_ID 
        WHERE CODE='#url.sender_code#' AND NUMBER_PHONE ='#url.number#'
 </cfquery>   
 <cfelse>
    Giriş Durduruldu
    <cflocation url = "https://destekportal.com/destekportal/dist/auth-login.cfm" >
 
    <cfabort> 
 </cfif>
 <cfif not man.recordCount>
    Giriş Durduruldu
    <cfabort> 
</cfif> 
  
 <cfset manager_id_ =man.manager_id> 
 <input type="hidden" name="manager_id_" id="manager_id_" value="<cfoutput>#man.manager_id#</cfoutput>">   
<html lang="en">

    <head>
        
        <meta charset="utf-8" />
        <title>DestekPortal</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Doot - Responsive Chat App Template in HTML. A fully featured HTML chat messenger template in Bootstrap 5" name="description" />
        <meta name="keywords" content="Doot chat template, chat, web chat template, chat status, chat template, communication, discussion, group chat, message, messenger template, status"/>
        <meta content="Themesbrand" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico" id="tabIcon">

        <!-- glightbox css -->
        <link rel="stylesheet" href="assets/libs/glightbox/css/glightbox.min.css">

        <!-- swiper css -->
        <link rel="stylesheet" href="assets/libs/swiper/swiper-bundle.min.css">

        
        <!-- Bootstrap Css -->
        <link href="assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        <style>
            .contact_message_hover li:hover { background-color:#e4e4e8; }
        </style>    

    </head>

    <body>

        <div class="layout-wrapper d-lg-flex">

            <!-- Start left sidebar-menu -->
            <div class="side-menu flex-lg-column">
                <!-- LOGO -->
                <br> 
                <div class="navbar-brand-box">
                    <a href="index.cfm" class="logo logo-dark">
                        <span class="logo-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24"><path d="M8.5,18l3.5,4l3.5-4H19c1.103,0,2-0.897,2-2V4c0-1.103-0.897-2-2-2H5C3.897,2,3,2.897,3,4v12c0,1.103,0.897,2,2,2H8.5z M7,7h10v2H7V7z M7,11h7v2H7V11z"/></svg>
                        </span>
                    </a>

                    <a href="index.cfm" class="logo logo-light">
                        <span class="logo-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24"><path d="M8.5,18l3.5,4l3.5-4H19c1.103,0,2-0.897,2-2V4c0-1.103-0.897-2-2-2H5C3.897,2,3,2.897,3,4v12c0,1.103,0.897,2,2,2H8.5z M7,7h10v2H7V7z M7,11h7v2H7V11z"/></svg>
                        </span>
                    </a>
                     <br>
                </div>
                <!-- end navbar-brand-box -->

                <!-- Start side-menu nav -->
                <div class="flex-lg-column my-0 sidemenu-navigation" >
                    <ul class="nav nav-pills side-menu-nav" role="tablist">
                        <li class="nav-item d-none d-lg-block" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover" data-bs-container=".sidemenu-navigation" title="Profile">
                            <a class="nav-link" id="pills-user-tab" data-bs-toggle="pill" href="#pills-user" role="tab">
                                <i class='bx bx-user-circle'></i>
                            </a>
                        </li>
                        <li class="nav-item" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover" data-bs-container=".sidemenu-navigation" title="Sohbetler" id="all_chats">
                            <a class="nav-link active" id="pills-chat-tab" data-bs-toggle="pill" href="#pills-chat" role="tab">
                                <i class='bx bx-conversation'></i>
                            </a>
                        </li>
                        
                        <li class="nav-item" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover" data-bs-container=".sidemenu-navigation" title="Kapanan Sohbetler" id="closed_chats">
                            <a class="nav-link" id="pills-bookmark-tab" data-bs-toggle="pill" href="#pills-bookmark" role="tab">
                                <i class='bx bx-bookmarks'></i>
                            </a>
                        </li>
                        <cfif man.MANAGER_PROJECT eq 33>
                            <li class="nav-item" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover" data-bs-container=".sidemenu-navigation" title="Onay Bekleyen Kullanıcılar" id="closed_chats">
                                <a class="nav-link" id="pills-waitman-tab" data-bs-toggle="pill" href="#pills-waitman" role="tab">
                                    <i class="fa fa-users"></i>
                                </a>
                            </li>
                        </cfif>

                       <!---  <li class="nav-item" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover" data-bs-container=".sidemenu-navigation" title="Kişiler">
                            <a class="nav-link" id="pills-contacts-tab" data-bs-toggle="pill" href="#pills-contacts" role="tab">
                                <i class='bx bxs-user-detail'></i>
                            </a>
                        </li> --->
                     <!---  <li class="nav-item" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover" data-bs-container=".sidemenu-navigation" title="Calls">
                            <a class="nav-link" id="pills-calls-tab" data-bs-toggle="pill" href="#pills-calls" role="tab">
                                <i class='bx bx-phone-call'></i>
                            </a>
                        </li> --->
                       
                        <li class="nav-item d-none d-lg-block" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container=".sidemenu-navigation" data-bs-trigger="hover" title="Settings">
                            <a class="nav-link" id="pills-setting-tab" data-bs-toggle="pill" href="#pills-setting" role="tab">
                                <i class='bx bx-cog'></i>
                            </a>
                        </li>
                        <li class="nav-item mt-auto">
                            <a class="nav-link light-dark" href="#" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="right" data-bs-container=".sidemenu-navigation" data-bs-html="true" title="<span class='light-mode'>Light</span> <span class='dark-mode'>Dark</span> Mode">
                                <i class='bx bx-moon'></i>
                            </a>
                        </li>
                        <li class="nav-item dropdown profile-user-dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="assets/images/users/avatar-1.jpg" alt="" class="profile-user rounded-circle">
                            </a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item d-flex align-items-center justify-content-between" id="pills-user-tab" data-bs-toggle="pill" href="#pills-user" role="tab">Profile <i class="bx bx-user-circle text-muted ms-1"></i></a>
                                <a class="dropdown-item d-flex align-items-center justify-content-between" id="pills-setting-tab" data-bs-toggle="pill" href="#pills-setting" role="tab">Setting <i class="bx bx-cog text-muted ms-1"></i></a>
                                 <div class="dropdown-divider"></div>
                                <a class="dropdown-item d-flex align-items-center justify-content-between" href="auth-logout.html">Log out <i class="bx bx-log-out-circle text-muted ms-1"></i></a>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- end side-menu nav -->
            </div>
            <!-- end left sidebar-menu -->

            <!-- start chat-leftsidebar -->
            <div class="chat-leftsidebar">

                <div class="tab-content">
                    <!-- Start Profile tab-pane -->
                    <div class="tab-pane" id="pills-user" role="tabpanel" aria-labelledby="pills-user-tab">
                        <!-- Start profile content -->
                        <div>
                            <div class="user-profile-img">
                                <img src="assets/images/small/img-4.jpg" class="profile-img" style="height: 160px;" alt="">
                                <div class="overlay-content">
                                    <div>
                                        <div class="user-chat-nav p-2 ps-3">
                    
                                            <div class="d-flex w-100 align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="text-white mb-0">My Profile</h5>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="dropdown">
                                                        <button class="btn nav-btn text-white dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class='bx bx-dots-vertical-rounded'></i>
                                                        </button>
                                                        <div class="dropdown-menu dropdown-menu-end">
                                                            <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Info <i class="bx bx-info-circle ms-2 text-muted"></i></a>
                                                            <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Setting <i class="bx bx-cog text-muted ms-2"></i></a>
                                                            <div class="dropdown-divider"></div>
                                                            <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Help <i class="bx bx-help-circle ms-2 text-muted"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center p-3 p-lg-4 border-bottom pt-2 pt-lg-2 mt-n5 position-relative">
                                <div class="mb-lg-3 mb-2">
                                    <img src="assets/images/users/user-dummy-img.jpg" class="rounded-circle avatar-lg img-thumbnail" alt="">
                                </div>

                                <h5 class="font-size-16 mb-1 text-truncate">UMUT DEMİRCİ</h5>
                                <p class="text-muted font-size-14 text-truncate mb-0">Front end Developer</p>
                            </div>
                            <!-- End profile user -->

                            <!-- Start user-profile-desc -->
                            <div class="p-4 profile-desc" data-simplebar>
                                <div class="text-muted">
                                    <p class="mb-4">If several languages coalesce, the grammar of the resulting language is more simple.</p>
                                </div>

                                <div>
                                    <div class="d-flex py-2">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="bx bx-user align-middle text-muted"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <p class="mb-0">UMUT DEMİRCİ</p>
                                        </div>
                                    </div>

                                    <div class="d-flex py-2">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="bx bx-message-rounded-dots align-middle text-muted"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <p class="mb-0">umut.demirci@nextstation.com.tr</p>
                                        </div>
                                    </div>
            
                                    <div class="d-flex py-2">
                                        <div class="flex-shrink-0 me-3">
                                            <i class="bx bx-location-plus align-middle text-muted"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <p class="mb-0">Istanbul, Turkey</p>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4">

                                <div>
                                    <div class="d-flex">
                                        <div class="flex-grow-1">
                                            <h5 class="font-size-11 text-muted text-uppercase">Media</h5>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <a href="#" class="font-size-12 d-block mb-2">Show all</a>
                                        </div>
                                    </div>
                                    <div class="profile-media-img">
                                        <div class="media-img-list">
                                            <a href="#">
                                                <img src="assets/images/small/img-1.jpg" alt="media img" class="img-fluid">
                                            </a>
                                        </div>
                                        <div class="media-img-list">
                                            <a href="#">
                                                <img src="assets/images/small/img-2.jpg" alt="media img" class="img-fluid">
                                            </a>
                                        </div>
                                        <div class="media-img-list">
                                            <a href="#">
                                                <img src="assets/images/small/img-4.jpg" alt="media img" class="img-fluid">
                                                <div class="bg-overlay">+ 15</div>
                                            </a>
                                        </div>
                                    </div>
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
                        <!-- End profile content -->
                    </div> 
                    <!-- End Profile tab-pane -->

                    <!-- Start chats tab-pane -->
                    <div class="tab-pane hide active" id="pills-chat" role="tabpanel" aria-labelledby="pills-chat-tab">
                        <!-- Start chats content -->
                        <div>
                            <div class="px-4 pt-4">
                                <div class="d-flex align-items-start">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-4">Chats</h4>
                                    </div>
                                    <div class="flex-shrink-0">
                                            <!--- bildirim --->
                                            <cfquery name="get_" datasource="next_destekportal">
                                                SELECT   MM.MANAGER_NAME + ' ' + MM.MANAGER_SURNAME AS NAME_ , *
                                                FROM CHATS
                                                LEFT JOIN MANAGERS MM ON MM.MANAGER_ID = CHATS.SENDER_ID
                                                WHERE 
                                                    IS_VIEW  IS NULL AND
                                                    RECEIVER_ID = 5
                                                ORDER BY SEND_DATE ASC
                                            </cfquery>
                                            <cfif get_.recordcount>
                                                <div class="d-flex align-items-end">
                                                    <div class="flex-grow-1">
                                                        <audio controls autoplay   style="display:none" >
                                                            <source src="/Documentation/bildirim3.mp3" type="audio/mpeg" id="vid">
                                                        </audio>
                                                    </div>
                                                </div>
                                            </cfif>
                                       <!---     
                                            <li class="dropdown dropdown-notification nav-item"><a class="nav-link nav-link-label" href="#" data-toggle="dropdown"> <i class='bx bxs-notification' title="notification" style="cursor:pointer"></i><span class="badge badge-pill badge-danger badge-up"><cfoutput>#get_.recordcount#</cfoutput></span></a>
                                                <ul class="dropdown-menu dropdown-menu-media dropdown-menu-right">
                                                    <li class="dropdown-menu-header">
                                                        <h6 class="dropdown-header m-0"><span class="grey darken-2">Okunmamış Mesajlar</span><span class="notification-tag badge badge-danger float-right m-0"><cfoutput>#get_.recordcount#</cfoutput></span></h6>
                                                    </li>
                                                    <li class="scrollable-container media-list ps">
                                                        <cfoutput query="get_"><!--- 
                                                            <a href="#request.self#?fuseaction=projeonline.work_detail&id=#id#"> --->
                                                                <div class="media">
                                                                    <div class="media-left align-self-center"><i class="feather icon-plus-square icon-bg-circle bg-cyan"></i></div>
                                                                    <div class="media-body">
                                                                        <h6 class="media-heading">#NAME_#</h6>
                                                                        <p class="notification-text font-small-3 text-muted">#Left(message,100)#</p><small>
                                                                        <time class="media-meta text-muted">#DateFormat(send_date,'dd/mm/yyyy')# #TimeFormat(send_date,'HH:mm')#</time></small>
                                                                    </div>
                                                                </div>
                                                          <!---   </a> --->
                                                        </cfoutput>
                                                </ul>
                                            </li> --->
                                            
 
                                    </div>  
                                 </div>
                                <form>
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control bg-light border-0 pe-0" id="serachChatUser" onkeyup="searchUser()" placeholder="Search here.." 
                                        aria-label="Example text with button addon" aria-describedby="searchbtn-addon" autocomplete="off">
                                        <button class="btn btn-light" type="button" id="searchbtn-addon"><i class='bx bx-search align-middle'></i></button>
                                    </div>
                                </form>

                            </div> <!-- .p-4 -->

                            <div class="chat-room-list" data-simplebar>
                                <!-- Start chat-message-list -->
                                <h5 class="mb-3 px-4 mt-4 font-size-11 text-muted text-uppercase">Sohbetler</h5>
                                    <div class="chat-message-list">
                                        <ul class="list-unstyled chat-list chat-user-list" id="favourite-users">
                                        
                                            <cfquery name="managers" datasource="next_destekportal">
                                                 SELECT MANAGER_ID
                                                    ,MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_
                                                    ,MANAGER_PHOTO
                                                    ,NOT_VIEW_COUNT.PIECE AS IS_NOT_VIEW_COUNT
                                                    ,END_MESSAGE.SEND_DATE AS END_MESSAGE_DATE
                                                    ,END_MESSAGE.MESSAGE AS END_MESSAGE
                                                    ,END_MESSAGE.PHOTO_FILE AS PHOTO_FILE
                                                    ,END_MESSAGE.ID AS END_ID
                                                    FROM MANAGERS
                                                    OUTER APPLY
                                                    (
                                                        SELECT  TOP 1
                                                            MESSAGE,SEND_DATE,ID,PHOTO_FILE                                  
                                                        FROM 
                                                            CHATS C   
                                                        WHERE 
                                                                                                
                                                        (C.SENDER_ID = #manager_id_# AND RECEIVER_ID =MANAGER_ID) OR  (C.SENDER_ID =MANAGER_ID AND RECEIVER_ID=#manager_id_#)

                                                        ORDER BY SEND_DATE DESC
                                                    ) AS END_MESSAGE
                                                    OUTER APPLY
                                                    (
                                                        SELECT COUNT(ID) AS PIECE FROM CHATS WHERE RECEIVER_ID = #manager_id_# AND SENDER_ID = MANAGER_ID AND IS_VIEW IS NULL
                                                    ) AS NOT_VIEW_COUNT
                                                    WHERE IS_SOLVED IS NULL
                                                    ORDER BY END_MESSAGE_DATE DESC 
                                            </cfquery>
                                            <cfoutput query="managers">
                                                <cfif len(END_MESSAGE)>
                                                <li id="contact-id-#manager_id#" data-name="favorite" class="remove_class" onclick="message_button(#manager_id#)">             
                                                    <a href="javascript: void(0);" class="unread-msg-user">                  
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
                                                                    <cfif photo_file eq 1>
                                                                        <i class="fa fa-image"></i> Görüntü
                                                                    <cfelseif photo_file eq 2>
                                                                        <i class="fa fa-file"></i> Dosya
                                                                    <cfelse>
                                                                         #END_MESSAGE#
                                                                    </cfif> 
                                                                    </p> 
                                                                    <span class="end_message_id d-none" >#END_ID#</span>  <span class="end_manager_id d-none" >#MANAGER_ID#</span>      
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
                                        </ul>
                                    </div>

                                <div class="d-flex align-items-center px-4 mt-5 mb-2">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-0 font-size-11 text-muted text-uppercase">Kişiler</h4>
                                    </div>
                                    <div class="flex-shrink-0">
                                        <div data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="bottom" title="New Message">

                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-soft-primary btn-sm" data-bs-toggle="modal" data-bs-target=".contactModal">
                                                <i class="bx bx-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!--- <div class="chat-message-list">
            
                                    <ul class="list-unstyled chat-list chat-user-list" id="usersList"> 
                                        <cfquery name="managers2" datasource="next_destekportal">
                                            SELECT MANAGER_ID
                                               ,MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_
                                               ,MANAGER_PHOTO
                                               ,NOT_VIEW_COUNT.PIECE AS IS_NOT_VIEW_COUNT
                                               ,END_MESSAGE.SEND_DATE AS END_MESSAGE_DATE
                                               ,END_MESSAGE.MESSAGE AS END_MESSAGE
                                               FROM MANAGERS
                                               OUTER APPLY
                                                (
                                                    SELECT  TOP 1
                                                        MESSAGE,SEND_DATE                                   
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
                                               WHERE END_MESSAGE.MESSAGE IS NULL AND IS_SOLVED IS NULL
                                               ORDER BY END_MESSAGE_DATE DESC 
                                       </cfquery>
                                       <cfoutput query="managers2">
                                           <li id="contact-id-#manager_id#" data-name="favorite" class="remove_class" onclick="message_button(#manager_id#)">             
                                               <a href="javascript: void(0);" class="unread-msg-user">                  
                                                   <div class="d-flex align-items-center">            
                                                       <div class="chat-user-img online align-self-center me-2 ms-0">       
                                                          <cfif len(MANAGER_PHOTO)>
                                                               <img src="assets/images/users/#MANAGER_PHOTO#" class="rounded-circle avatar-xs" alt="">
                                                          <cfelse>
                                                               <img src="assets/images/users/user-dummy-img.jpg" class="rounded-circle avatar-xs" alt="">
                                                           </cfif>
                                                           <span class="user-status"></span>                   
                                                       </div>            
                                                       <div class="row d-flex align-items-center">       
                                                               <p class="text-truncate mb-0 manager_name_rename#manager_id#">#NAME_# </p> 
                                                               <p class="text-truncate mb-0 text-muted" id="end-message-#manager_id#">
                                                                  
                                                               </p>        
                                                       </div>   
                                                          
                                                       <div class="ms-auto"> 
                                                           <span class="right font-size-11" style="float: right;" id="end-message-date-#manager_id#"> 
                                                             
                                                           </span> <br>
                                                           <span class="badge badge-soft-primary text-dark rounded p-1" id="end-message-view_count-#manager_id#" style="float: right;"></span>
                                                       </div> 
                                                     
                                                   </div>            
                                               </a>           
                                           </li> 
                                        </cfoutput>
                                    </ul>
                                </div> --->

                             <!---    <div class="d-flex align-items-center px-4 mt-5 mb-2">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-0 font-size-11 text-muted text-uppercase">Channels</h4>
                                    </div>
                                    <div class="flex-shrink-0">
                                        <div data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="bottom" title="Create group">

                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-soft-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addgroup-exampleModal">
                                                <i class="bx bx-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="chat-message-list">
            
                                    <ul class="list-unstyled chat-list chat-user-list mb-3" id="channelList">
                
                                    </ul>
                                </div> --->
                                <!-- End chat-message-list -->
                            </div>

                        </div>
                        <!-- Start chats content -->

                        <!-- Start add group Modal -->
                        <div class="modal fade" id="addgroup-exampleModal" tabindex="-1" role="dialog" aria-labelledby="addgroup-exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content modal-header-colored shadow-lg border-0">
                                    <div class="modal-header">
                                        <h5 class="modal-title text-white font-size-16" id="addgroup-exampleModalLabel">Create New Group</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close">
                                        </button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <form>
                                            <div class="mb-4">
                                                <label for="addgroupname-input" class="form-label">Group Name</label>
                                                <input type="text" class="form-control" id="addgroupname-input" placeholder="Enter Group Name">
                                            </div>
                                            <div class="mb-4">
                                                <label class="form-label">Group Members</label>
                                                <div class="mb-3">
                                                    <button class="btn btn-light btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#groupmembercollapse" aria-expanded="false" aria-controls="groupmembercollapse">
                                                        Select Members
                                                    </button>
                                                </div>

                                                <div class="collapse" id="groupmembercollapse">
                                                    <div class="card border">
                                                        <div class="card-header">
                                                            <h5 class="font-size-15 mb-0">Contacts</h5>
                                                        </div>
                                                        <div class="card-body p-2">
                                                            <div data-simplebar style="max-height: 150px;">
                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        A
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck1" checked>
                                                                                <label class="form-check-label" for="memberCheck1">Albert Rodarte</label>
                                                                            </div>
                                                                        </li>

                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck2">
                                                                                <label class="form-check-label" for="memberCheck2">Allison Etter</label>
                                                                            </div>
                                                                        </li>
                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        C
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck3">
                                                                                <label class="form-check-label" for="memberCheck3">Craig Smiley</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        D
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck4">
                                                                                <label class="form-check-label" for="memberCheck4">Daniel Clay</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        I
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck5">
                                                                                <label class="form-check-label" for="memberCheck5">Iris Wells</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        J
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck6">
                                                                                <label class="form-check-label" for="memberCheck6">Juan Flakes</label>
                                                                            </div>
                                                                        </li>

                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck7">
                                                                                <label class="form-check-label" for="memberCheck7">John Hall</label>
                                                                            </div>
                                                                        </li>

                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck8">
                                                                                <label class="form-check-label" for="memberCheck8">Joy Southern</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        M
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck9">
                                                                                <label class="form-check-label" for="memberCheck9">Michael Hinton</label>
                                                                            </div>
                                                                        </li>

                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck10">
                                                                                <label class="form-check-label" for="memberCheck10">Mary Farmer</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        P
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck11">
                                                                                <label class="form-check-label" for="memberCheck11">Phillis Griffin</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        R
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck12">
                                                                                <label class="form-check-label" for="memberCheck12">Rocky Jackson</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>

                                                                <div>
                                                                    <div class="contact-list-title">
                                                                        S
                                                                    </div>

                                                                    <ul class="list-unstyled contact-list">
                                                                        <li>
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="memberCheck13">
                                                                                <label class="form-check-label" for="memberCheck13">Simon Velez</label>
                                                                            </div>
                                                                        </li>

                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="addgroupdescription-input" class="form-label">Description</label>
                                                <textarea class="form-control" id="addgroupdescription-input" rows="3" placeholder="Enter Description"></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Create Groups</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End add group Modal -->
                    </div>
                    <!-- End chats tab-pane -->

                    <!-- Start contacts tab-pane -->
                    <div class="tab-pane" id="pills-contacts" role="tabpanel" aria-labelledby="pills-contacts-tab">
                        <!-- Start Contact content -->
                        <div class="position-relative">
	<div class="px-4 pt-4">
		<div class="d-flex align-items-start">
			<div class="flex-grow-1"><h4 class="mb-4">Contacts</h4></div>
			<div class="flex-shrink-0">
				<div id="add-contact-button">
					<button type="button" class="btn btn-soft-primary btn-sm btn btn-primary"><i class="bx bx-plus"></i></button>
				</div>
			</div>
		</div>
		<form class="">
			<div class="input-group mb-4">
				<input placeholder="Search Contacts.." aria-label="Search Contacts..." aria-describedby="button-searchcontactsaddon" type="text" class="form-control bg-light border-0 pe-0 form-control" value="" />
				<button class="btn btn-light" type="button" id="button-searchcontactsaddon"><i class="bx bx-search align-middle"></i></button>
			</div>
		</form>
	</div>
	<div data-simplebar="init" class="chat-message-list chat-group-list">
		<div class="simplebar-wrapper" style="margin: 0px;">
			<div class="simplebar-height-auto-observer-wrapper"><div class="simplebar-height-auto-observer"></div></div>
			<div class="simplebar-mask">
				<div class="simplebar-offset" style="right: 0px; bottom: 0px;">
					<div class="simplebar-content-wrapper" tabindex="0" role="region" aria-label="scrollable content" style="height: 100%; overflow: hidden scroll;">
						<div class="simplebar-content" style="padding: 0px;">
							<div>
								<div class="">
									<div class="contact-list-title">A</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-pink">AL</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Alvarez Luna</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">C</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs">
														<img
															src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAA8AAD/4QMpaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo3OUY5NUE0OTYxRkMxMUVCOTQ4MEY1RUQwQjFGMUU2OCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo3OUY5NUE0QTYxRkMxMUVCOTQ4MEY1RUQwQjFGMUU2OCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjc5Rjk1QTQ3NjFGQzExRUI5NDgwRjVFRDBCMUYxRTY4IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjc5Rjk1QTQ4NjFGQzExRUI5NDgwRjVFRDBCMUYxRTY4Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggL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"
															alt=""
															class="img-fluid rounded-circle"
														/>
													</div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Carla Serrano</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">D</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-purple">DV</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Dean Vargas</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs">
														<img
															src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAA8AAD/4QMpaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo0QkFCMzE5MjYxRkUxMUVCOTlBRjgzNERGRjcyQjg5NiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo0QkFCMzE5MzYxRkUxMUVCOTlBRjgzNERGRjcyQjg5NiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjRCQUIzMTkwNjFGRTExRUI5OUFGODM0REZGNzJCODk2IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjRCQUIzMTkxNjFGRTExRUI5OUFGODM0REZGNzJCODk2Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggL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"
															alt=""
															class="img-fluid rounded-circle"
														/>
													</div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Donaldson Riddle</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-secondary">DW</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Daniels Webster</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">E</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><img src="/static/media/avatar-5.364c1f11.jpg" alt="" class="img-fluid rounded-circle" /></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Earnestine Sears</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">F</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><img src="/static/media/avatar-5.364c1f11.jpg" alt="" class="img-fluid rounded-circle" /></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Faulkner Benjamin</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">H</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-primary">HJ</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Heath Jarvis</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs">
														<img
															src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAA8AAD/4QMpaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozQzA0OThBNDYxRkUxMUVCQjIyQkE0Nzc5NkY0NDlBMCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozQzA0OThBNTYxRkUxMUVCQjIyQkE0Nzc5NkY0NDlBMCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjNDMDQ5OEEyNjFGRTExRUJCMjJCQTQ3Nzk2RjQ0OUEwIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjNDMDQ5OEEzNjFGRTExRUJCMjJCQTQ3Nzk2RjQ0OUEwIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggL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"
															alt=""
															class="img-fluid rounded-circle"
														/>
													</div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Hendrix Martin</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">J</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><img src="/static/media/avatar-7.81ae8bca.jpg" alt="" class="img-fluid rounded-circle" /></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Jennifer Ramirez</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">K</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><img src="/static/media/avatar-3.bd68c38c.jpg" alt="" class="img-fluid rounded-circle" /></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Katrina Winters</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-danger">KC</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Kitty Cannon</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">M</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs">
														<img
															src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAA8AAD/4QMpaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpDREM3MjY0RTYxRkMxMUVCOUJDRTgwOUUxM0JCQ0UwOSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpDREM3MjY0RjYxRkMxMUVCOUJDRTgwOUUxM0JCQ0UwOSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkNEQzcyNjRDNjFGQzExRUI5QkNFODA5RTEzQkJDRTA5IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkNEQzcyNjRENjFGQzExRUI5QkNFODA5RTEzQkJDRTA5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggL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"
															alt=""
															class="img-fluid rounded-circle"
														/>
													</div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Marguerite Campbell</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-danger">MV</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Miranda Valentine</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-danger">MM</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Melody Montoya</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">N</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><img src="/static/media/avatar-2.0fdabd61.jpg" alt="" class="img-fluid rounded-circle" /></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Norris Decker</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">S</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-danger">SP</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Sanford Phelps</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-warning">SW</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Shawna Wright</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">T</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs">
														<img
															src="data:image/jpeg;base64,/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAA8AAD/4QMpaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozMzNFNEU4QjYxRkUxMUVCOTZGNkU3RThCRDFBMkE1MiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozMzNFNEU4QzYxRkUxMUVCOTZGNkU3RThCRDFBMkE1MiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjMzM0U0RTg5NjFGRTExRUI5NkY2RTdFOEJEMUEyQTUyIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjMzM0U0RThBNjFGRTExRUI5NkY2RTdFOEJEMUEyQTUyIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggL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"
															alt=""
															class="img-fluid rounded-circle"
														/>
													</div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Tonia Clay</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">W</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><img src="/static/media/avatar-6.5e8ef3d6.jpg" alt="" class="img-fluid rounded-circle" /></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Wallace Lane</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="mt-3">
									<div class="contact-list-title">Z</div>
									<ul class="list-unstyled contact-list">
										<li>
											<div class="d-flex align-items-center">
												<div class="flex-shrink-0 me-2">
													<div class="avatar-xs"><span class="avatar-title rounded-circle font-size-10 text-uppercase bg-secondary">ZL</span></div>
												</div>
												<div class="flex-grow-1"><h5 class="font-size-14 m-0">Zimmerman Langley</h5></div>
												<div class="flex-shrink-0">
													<div class="dropdown">
														<a aria-haspopup="true" class="text-mute" aria-expanded="false"><i class="bx bx-dots-vertical-rounded align-middle"></i></a>
														<div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-end dropdown-menu">
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Block <i class="bx bx-block ms-2 text-muted"></i></a>
															<a href="#" tabindex="0" role="menuitem" class="d-flex align-items-center justify-content-between dropdown-item">Remove <i class="bx bx-trash ms-2 text-muted"></i></a>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="simplebar-placeholder" style="width: auto; height: 1585px;"></div>
		</div>
		<div class="simplebar-track simplebar-horizontal" style="visibility: hidden;"><div class="simplebar-scrollbar" style="width: 0px; display: none;"></div></div>
		<div class="simplebar-track simplebar-vertical" style="visibility: visible;"><div class="simplebar-scrollbar" style="height: 93px; display: block; transform: translate3d(0px, 0px, 0px);"></div></div>
	</div>
</div>

                  <!---       <div>
                            <div class="px-4 pt-4">
                                <div class="d-flex align-items-start">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-4">Contacts</h4>
                                    </div>
                                    <div class="flex-shrink-0">
                                        <div data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="bottom" title="Add Contact">

                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-soft-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addContact-exampleModal">
                                                <i class="bx bx-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <form>
                                    <div class="input-group mb-4">
                                        <input type="text" class="form-control bg-light border-0 pe-0" id="searchContact" onkeyup="searchContacts()" placeholder="Search Contacts.." aria-label="Search Contacts..." 
                                        aria-describedby="button-searchcontactsaddon" autocomplete="off">
                                        <button class="btn btn-light" type="button" id="button-searchcontactsaddon"><i class='bx bx-search align-middle'></i></button>
                                    </div>
                                </form>
                            </div>
                            <!-- end p-4 -->

                            <div class="chat-message-list chat-group-list" data-simplebar >
                                <div class="sort-contact">            
                                </div>
                            </div>
                            <!-- end contact lists -->
                        </div> --->
                        <!-- Start Contact content -->
                    </div>
                    <!-- End contacts tab-pane -->

                    <!-- Start calls tab-pane -->
                    <div class="tab-pane" id="pills-calls" role="tabpanel" aria-labelledby="pills-calls-tab">
                        <!-- Start Contact content -->
                        <div>
                            <div class="px-4 pt-4">
                                <div class="d-flex align-items-start">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-3">Calls</h4>
                                    </div>
                                </div>
                            </div>
                            <!-- end p-4 -->

                            <!-- Start contact lists -->
                            <div class="chat-message-list chat-call-list" data-simplebar>
                                <ul class="list-unstyled chat-list" id="callList">      
                  
                                </ul>
                            </div>
                            <!-- end contact lists -->
                        </div>
                        <!-- Start Contact content -->
                    </div>
                    <!-- End calls tab-pane -->

                    <!-- Start bookmark tab-pane -->
                    <div class="tab-pane" id="pills-bookmark" role="tabpanel" aria-labelledby="pills-bookmark-tab">
                        <!-- Start Contact content -->
                        <div>
                            <div class="px-4 pt-4">
                                <div class="d-flex align-items-start">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-3">Kapanan Sohbetler</h4>
                                    </div>
                                </div>
                            </div>
                            <!-- end p-4 -->

                            <!-- Start contact lists -->
                             <div class="chat-message-list chat-a-list" data-simplebar>
                                <h5 class="mb-3 px-4 mt-4 font-size-11 text-muted text-uppercase">Sohbetler</h5>
                                <ul class="list-unstyled chat-list" id="closed_chats_loading">
                                    
                                 
                                </ul>
                            </div>
                            
                            <!-- end contact lists -->
                        </div>
                        <!-- Start Contact content -->
                    </div>
                    <!-- End bookmark tab-pane -->

                     <!-- Start Wait Managers tab-pane -->
                    <div class="tab-pane" id="pills-waitman" role="tabpanel" aria-labelledby="pills-waitman-tab">
                        <!-- Start Contact content -->
                        <div>
                            <div class="px-4 pt-4">
                                <div class="d-flex align-items-start">
                                    <div class="flex-grow-1">
                                        <h4 class="mb-3">Onay Bekleyen Kullanıcılar</h4>
                                    </div>
                                </div>
                            </div>
                            <!-- end p-4 -->

                            <!-- Start contact lists -->
                            <div class="chat-message-list chat-a-list" data-simplebar>
                                <h5 class="mb-3 px-4 mt-4 font-size-11 text-muted text-uppercase">Kullanıcılar </h5>
                                <cfquery name="get_w" datasource="next_destekportal">
                                    SELECT MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_, * FROM MANAGERS WHERE IS_CHECK =1
                                </cfquery>

                                <ul class="list-unstyled chat-list list-group">
                                    <cfoutput query="get_w">
                                        <li class="list-group-item">
                                            <div>
                                                <h5 class="font-size-14 m-0" >#NAME_#
                                                <div class="action_none">
                                                    <input type="radio" onclick="manager_success(#manager_id#,1)" class="btn-check btn-successs" name="options-outlined" id="success-outlined" autocomplete="off">
                                                    <label class="btn btn-outline-success btn-successs" for="success-outlined">Onay</label>
                                                    
                                                    <input type="radio" onclick="manager_success(#manager_id#,0)" class="btn-check btn-dangerr" name="options-outlined" id="danger-outlined" autocomplete="off">
                                                    <label class="btn btn-outline-danger btn-dangerr" for="danger-outlined">Red</label>
                                                </div>
                                                </h5> 
                                            </div>
                                        </li>
                                    </cfoutput>
                                </ul>
                            </div>
                            <script>
                                function manager_success(manager_id,durum)
                                {
                                    $.ajax({
                                    type: "POST",
                                    url: `cfc/add_message.cfc?method=wait_manager_success&returnformat=json&manager_id=${manager_id}&durum=${durum}`,
                                        success: function (status) {  
                                                console.log(durum);
                                                if(durum == 1)
                                                {
                                                    $("#btn-dangerr").hide();
                                                    $('.btn-outline-success').html('Onaylandı');
                                                    $('.btn-outline-danger').html('Red');
                                                                                                        
                                                }
                                                else
                                                {
                                                    $("#btn-successs").hide();
                                                    $('.btn-outline-danger').html('Reddeildi');
                                                    $('.btn-outline-success').html('Onay');
                                                }
                                        }
                                    })
                                        
                                }
                            </script>
                            <!-- end contact lists -->
                        </div>
                        <!-- Start Contact content -->
                    </div>
                    <!-- End Wait Managers tab-pane -->
                    <!-- Start settings tab-pane -->
                    <div class="tab-pane" id="pills-setting" role="tabpanel" aria-labelledby="pills-setting-tab">
                        <!-- Start Settings content -->
                        <div>
                            <div class="user-profile-img">
                                <img src="assets/images/small/img-4.jpg" class="profile-img profile-foreground-img" style="height: 160px;" alt="">
                                <div class="overlay-content">
                                    <div>
                                        <div class="user-chat-nav p-3">
                    
                                            <div class="d-flex w-100 align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="text-white mb-0">Settings</h5>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <div class="avatar-xs p-0 rounded-circle profile-photo-edit" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="bottom" title="Change Background">
                                                        <input id="profile-foreground-img-file-input" type="file" class="profile-foreground-img-file-input" >
                                                        <label for="profile-foreground-img-file-input" class="profile-photo-edit avatar-xs">
                                                            <span class="avatar-title rounded-circle bg-light text-body">
                                                                <i class="bx bxs-pencil"></i>
                                                            </span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center p-3 p-lg-4 border-bottom pt-2 pt-lg-2 mt-n5 position-relative">
                                <div class="mb-3 profile-user">
                                    <img src="assets/images/users/avatar-1.jpg" class="rounded-circle avatar-lg img-thumbnail user-profile-image" alt="user-profile-image">
                                    <div class="avatar-xs p-0 rounded-circle profile-photo-edit">
                                        <input id="profile-img-file-input" type="file" class="profile-img-file-input" >
                                        <label for="profile-img-file-input" class="profile-photo-edit avatar-xs">
                                            <span class="avatar-title rounded-circle bg-light text-body">
                                                <i class="bx bxs-camera"></i>
                                            </span>
                                        </label>
                                    </div>
                                </div>

                                <h5 class="font-size-16 mb-1 text-truncate"></h5>
        
                                <div class="dropdown d-inline-block">
                                    <a class="text-muted dropdown-toggle d-block" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="bx bxs-circle text-success font-size-10 align-middle"></i> Active <i class="mdi mdi-chevron-down"></i>
                                    </a>
          
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="#"><i class="bx bxs-circle text-success font-size-10 me-1 align-middle"></i> Active</a>
                                        <a class="dropdown-item" href="#"><i class="bx bxs-circle text-warning font-size-10 me-1 align-middle"></i> Away</a>
                                        <a class="dropdown-item" href="#"><i class="bx bxs-circle text-danger font-size-10 me-1 align-middle"></i> Do not disturb</a>
                                    </div>
                                </div>

        
                            </div>
                            <!-- End profile user -->

                            <!-- Start User profile description -->
                            <div class="user-setting" data-simplebar>
                                <div id="settingprofile" class="accordion accordion-flush">
                                    <div class="accordion-item">
                                        <div class="accordion-header" id="headerpersonalinfo">
                                            <button class="accordion-button font-size-14 fw-medium" type="button" data-bs-toggle="collapse" data-bs-target="#personalinfo" aria-expanded="true" aria-controls="personalinfo">
                                                <i class="bx bxs-user text-muted me-3"></i> Personal Info
                                            </button>
                                        </div>
                                        <div id="personalinfo" class="accordion-collapse collapse show" aria-labelledby="headerpersonalinfo" data-bs-parent="#settingprofile">
                                            <div class="accordion-body">
                                                <div class="float-end">
                                                    <button type="button" class="btn btn-soft-primary btn-sm"><i class="bx bxs-pencil align-middle"></i></button>
                                                </div>

                                                <div>
                                                    <p class="text-muted mb-1">Name</p>
                                                    <h5 class="font-size-14">UMUT DEMİRCİ</h5>
                                                </div>

                                                <div class="mt-4">
                                                    <p class="text-muted mb-1">Email</p>
                                                    <h5 class="font-size-14">umut.demirci@nextstation.com.tr</h5>
                                                </div>

                                                <div class="mt-4">
                                                    <p class="text-muted mb-1">Location</p>
                                                    <h5 class="font-size-14 mb-0">Istanbul ,TURKEY</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end personal info card -->

                                   <!---  <div class="accordion-item">
                                        <div class="accordion-header" id="headerthemes">
                                            <button class="accordion-button font-size-14 fw-medium collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapsethemes" aria-expanded="false" aria-controls="collapsethemes">
                                                <i class="bx bxs-adjust-alt text-muted me-3"></i> Themes
                                            </button>
                                        </div>
                                        <div id="collapsethemes" class="accordion-collapse collapse" aria-labelledby="headerthemes" data-bs-parent="#settingprofile">
                                            <div class="accordion-body">
                                                <div>
                                                    <h5 class="mb-3 font-size-11 text-muted text-uppercase">Choose Theme Color :</h5>
                                                    <div class="d-flex align-items-center flex-wrap gap-2 theme-btn-list theme-color-list">
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="0" name="bgcolor-radio" id="bgcolor-radio1" >
                                                            <label class="form-check-label avatar-xs" for="bgcolor-radio1">
                                                                <span class="avatar-title bg-primary-custom rounded-circle theme-btn bgcolor-radio1"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="1" name="bgcolor-radio" id="bgcolor-radio2">
                                                            <label class="form-check-label avatar-xs" for="bgcolor-radio2">
                                                                <span class="avatar-title bg-info rounded-circle theme-btn bgcolor-radio2"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="2" name="bgcolor-radio" id="bgcolor-radio4">
                                                            <label class="form-check-label avatar-xs" for="bgcolor-radio4">
                                                                <span class="avatar-title bg-purple rounded-circle theme-btn bgcolor-radio4"></span>
                                                            </label>
                                                        </div>
                                
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="3" name="bgcolor-radio" id="bgcolor-radio5">
                                                            <label class="form-check-label avatar-xs" for="bgcolor-radio5">
                                                                <span class="avatar-title bg-pink rounded-circle theme-btn bgcolor-radio5"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="4" name="bgcolor-radio" id="bgcolor-radio6">
                                                            <label class="form-check-label avatar-xs" for="bgcolor-radio6">
                                                                <span class="avatar-title bg-danger rounded-circle theme-btn bgcolor-radio6"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="5" name="bgcolor-radio" id="bgcolor-radio7">
                                                            <label class="form-check-label avatar-xs" for="bgcolor-radio7">
                                                                <span class="avatar-title bg-secondary rounded-circle theme-btn bgcolor-radio7"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-color" type="radio" value="6" name="bgcolor-radio" id="bgcolor-radio8" checked>
                                                            <label class="form-check-label avatar-xs light-background" for="bgcolor-radio8">
                                                                <span class="avatar-title bg-light rounded-circle theme-btn bgcolor-radio8"></span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="mt-4 pt-2">
                                                    <h5 class="mb-3 font-size-11 text-muted text-uppercase">Choose Theme Image :</h5>
                                                    <div class="d-flex align-items-center flex-wrap gap-2 theme-btn-list theme-btn-list-img">
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio1">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio1">
                                                                <span class="avatar-title bg-pattern-1 rounded-circle theme-btn bgimg-radio1"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio2">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio2">
                                                                <span class="avatar-title bg-pattern-2 rounded-circle theme-btn bgimg-radio2"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio3">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio3">
                                                                <span class="avatar-title bg-pattern-3 rounded-circle theme-btn bgimg-radio3"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio4">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio4">
                                                                <span class="avatar-title bg-pattern-4 rounded-circle theme-btn bgimg-radio4"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio5" checked>
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio5">
                                                                <span class="avatar-title bg-pattern-5 rounded-circle theme-btn bgimg-radio5"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio6">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio6">
                                                                <span class="avatar-title bg-pattern-6 rounded-circle theme-btn bgimg-radio6"></span>
                                                            </label>
                                                        </div>
                                
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio7">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio7">
                                                                <span class="avatar-title bg-pattern-7 rounded-circle theme-btn bgimg-radio7"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio8">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio8">
                                                                <span class="avatar-title bg-pattern-8 rounded-circle theme-btn bgimg-radio8"></span>
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input theme-img" type="radio" name="bgimg-radio" id="bgimg-radio9">
                                                            <label class="form-check-label avatar-xs" for="bgimg-radio9">
                                                                <span class="avatar-title bg-pattern-9 rounded-circle theme-btn bgimg-radio9"></span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> --->

                                    <div class="accordion-item">
                                        <div class="accordion-header" id="privacy1">
                                            <button class="accordion-button font-size-14 fw-medium collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#privacy" aria-expanded="false" aria-controls="privacy">
                                                <i class="bx bxs-lock text-muted me-3"></i>Privacy
                                            </button>
                                        </div>
                                        <div id="privacy" class="accordion-collapse collapse" aria-labelledby="privacy1" data-bs-parent="#settingprofile">
                                            <div class="accordion-body">
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item py-3 px-0 pt-0">
                                                        <div class="d-flex align-items-center">
                                                            <div class="flex-grow-1 overflow-hidden">
                                                                <h5 class="font-size-13 mb-0 text-truncate">Profile photo</h5>
                                                            </div>
                                                            <div class="flex-shrink-0 ms-2">
                                                                <select class="form-select form-select-sm">
                                                                    <option value="Everyone" selected>Everyone</option>
                                                                    <option value="Selected">Selected</option>
                                                                    <option value="Nobody">Nobody</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="list-group-item py-3 px-0">
                                                        <div class="d-flex align-items-center">
                                                            <div class="flex-grow-1 overflow-hidden">
                                                                <h5 class="font-size-13 mb-0 text-truncate">Last seen</h5>
    
                                                            </div>
                                                            <div class="flex-shrink-0 ms-2">
                                                                <div class="form-check form-switch">
                                                                    <input type="checkbox" class="form-check-input" id="privacy-lastseenSwitch" checked>
                                                                    <label class="form-check-label" for="privacy-lastseenSwitch"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="list-group-item py-3 px-0">
                                                        <div class="d-flex align-items-center">
                                                            <div class="flex-grow-1 overflow-hidden">
                                                                <h5 class="font-size-13 mb-0 text-truncate">Status</h5>
                                                            </div>
                                                            <div class="flex-shrink-0 ms-2">
                                                                <select class="form-select form-select-sm">
                                                                    <option value="Everyone" selected>Everyone</option>
                                                                    <option value="Selected">Selected</option>
                                                                    <option value="Nobody">Nobody</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="list-group-item py-3 px-0">
                                                        <div class="d-flex align-items-center">
                                                            <div class="flex-grow-1 overflow-hidden">
                                                                <h5 class="font-size-13 mb-0 text-truncate">Read receipts</h5>
                                                            </div>
                                                            <div class="flex-shrink-0 ms-2">
                                                                <div class="form-check form-switch">
                                                                    <input type="checkbox" class="form-check-input" id="privacy-readreceiptSwitch" checked>
                                                                    <label class="form-check-label" for="privacy-readreceiptSwitch"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="list-group-item py-3 px-0 pb-0">
                                                        <div class="d-flex align-items-center">
                                                            <div class="flex-grow-1 overflow-hidden">
                                                                <h5 class="font-size-13 mb-0 text-truncate">Groups</h5>
    
                                                            </div>
                                                            <div class="flex-shrink-0 ms-2">
                                                                <select class="form-select form-select-sm">
                                                                    <option value="Everyone" selected>Everyone</option>
                                                                    <option value="Selected">Selected</option>
                                                                    <option value="Nobody">Nobody</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end privacy card -->

                                    <div class="accordion-item">
                                        <div class="accordion-header" id="headersecurity">
                                            <button class="accordion-button font-size-14 fw-medium collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapsesecurity" aria-expanded="false" aria-controls="collapsesecurity">
                                                <i class="bx bxs-check-shield text-muted me-3"></i> Security
                                            </button>
                                        </div>
                                        <div id="collapsesecurity" class="accordion-collapse collapse" aria-labelledby="headersecurity" data-bs-parent="#settingprofile">
                                            <div class="accordion-body">
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item p-0">
                                                        <div class="d-flex align-items-center">
                                                            <div class="flex-grow-1 overflow-hidden">
                                                                <h5 class="font-size-13 mb-0 text-truncate">Show security notification</h5>
        
                                                            </div>
                                                            <div class="flex-shrink-0 ms-2">
                                                                <div class="form-check form-switch">
                                                                    <input type="checkbox" class="form-check-input" id="security-notificationswitch">
                                                                    <label class="form-check-label" for="security-notificationswitch"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end security card -->

            

                                    <div class="accordion-item">
                                        <div class="accordion-header" id="headerhelp">
                                            <button class="accordion-button font-size-14 fw-medium collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapsehelp" aria-expanded="false" aria-controls="collapsehelp">
                                                <i class="bx bxs-help-circle text-muted me-3"></i> Help
                                            </button>
                                        </div>
                                        <div id="collapsehelp" class="accordion-collapse collapse" aria-labelledby="headerhelp" data-bs-parent="#settingprofile">
                                            <div class="accordion-body">
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item py-3 px-0 pt-0">
                                                        <h5 class="font-size-13 mb-0"><a href="#" class="text-body d-block">FAQs</a></h5>
                                                    </li>
                                                    <li class="list-group-item py-3 px-0">
                                                        <h5 class="font-size-13 mb-0"><a href="#" class="text-body d-block">Contact</a></h5>
                                                    </li>
                                                    <li class="list-group-item py-3 px-0 pb-0">
                                                        <h5 class="font-size-13 mb-0"><a href="#" class="text-body d-block">Terms & Privacy policy</a></h5>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end profile-setting-accordion -->
                            </div>
                            <!-- End User profile description -->
                        </div>
                        <!-- Start Settings content -->
                    </div>
                    <!-- End settings tab-pane -->
                </div>
                <!-- end tab content -->
            </div>
            <!-- end chat-leftsidebar -->

            <!-- Start User chat --> 
            <div class="user-chat w-100 overflow-hidden user_chat_add d-none" >
          
        
            </div>
            
            <div class="user-chat w-100 overflow-hidden" id="user-chat-dnone" style='background-image: url("https://doot-light.react.themesbrand.com/static/media/pattern-05.ffd181cd.png");'>
             <div class="chat-content d-lg-flex">
                <div class="chat-welcome-section">
                    <div class="w-100 justify-content-center row">
                        <div xxl="5" class="col-md-7">
                            <div class="p-4 text-center">
                                <div class="avatar-xl mx-auto mb-4">
                                    <div class="avatar-title bg-soft-warning rounded-circle"><i class="bx bxs-message-alt-detail display-4 text-warning m-0"></i></div>
                                </div>
                                <h4>DestekPortal Paneline Hoş Geldiniz.</h4>
                                <p class="text-muted mb-4">Telefonunuzu çevrimiçi tutmadan panel üzerinden mesaj gönderebilir ve alabilirsiniz.</p>
                                <button type="button" class="btn btn-warning w-lg btn btn-secondary text-danger">Kullanmaya Başla</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
             <!-- End User chat -->

            <!-- Start Add contact Modal -->
            <div class="modal fade" id="addContact-exampleModal" tabindex="-1" role="dialog" aria-labelledby="addContact-exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content modal-header-colored shadow-lg border-0">
                        <div class="modal-header">
                            <h5 class="modal-title text-white font-size-16" id="addContact-exampleModalLabel">Create Contact</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close">
                            </button>
                        </div>
                        <div class="modal-body p-4">
                            <form>
                                <div class="mb-3">
                                    <label for="addcontactemail-input" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="addcontactemail-input" placeholder="Enter Email">
                                </div>
                                <div class="mb-3">
                                    <label for="addcontactname-input" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="addcontactname-input" placeholder="Enter Name">
                                </div>
                                <div class="mb-0">
                                    <label for="addcontact-invitemessage-input" class="form-label">Invatation Message</label>
                                    <textarea class="form-control" id="addcontact-invitemessage-input" rows="3" placeholder="Enter Message"></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-link" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Invite</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Add contact Modal -->

         
            <!-- Start Add pinned tab Modal -->
            <div class="modal fade pinnedtabModal" tabindex="-1" role="dialog" aria-labelledby="pinnedtabModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content modal-header-colored shadow-lg border-0">
                        <div class="modal-header">
                            <h5 class="modal-title text-white font-size-16" id="pinnedtabModalLabel">Bookmark</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close">
                            </button>
                        </div>
                        <div class="modal-body p-4">
                            <div class="d-flex align-items-center mb-3">
                                <div class="flex-grow-1">
                                    <div>
                                        <h5 class="font-size-16 mb-0">10 Pinned tabs</h5>
                                    </div>
                                </div>
                                <div class="flex-shrink-0">
                                    <div>
                                        <button type="button" class="btn btn-sm btn-soft-primary"><i class="bx bx-plus"></i> Pin</button>
                                    </div>
                                </div>
                            </div>
                            <div class="chat-bookmark-list mx-n4" data-simplebar style="max-height: 299px;">
                                <ul class="list-unstyled chat-list">
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-file"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">design-phase-1-approved.pdf</a></h5>
                                                <p class="text-muted font-size-13 mb-0">12.5 MB</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-pin"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">Bg Pattern</a></h5>
                                                <p class="text-muted font-size-13 mb-0">https://bgpattern.com/</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-image"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">Image-001.jpg</a></h5>
                                                <p class="text-muted font-size-13 mb-0">4.2 MB</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-pin"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">Images</a></h5>
                                                <p class="text-muted font-size-13 mb-0">https://images123.com/</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-pin"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">Bg Gradient</a></h5>
                                                <p class="text-muted font-size-13 mb-0">https://bggradient.com/</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-image"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">Image-012.jpg</a></h5>
                                                <p class="text-muted font-size-13 mb-0">3.1 MB</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 avatar-xs me-3">
                                                <div class="avatar-title bg-soft-primary text-primary rounded-circle">
                                                    <i class="bx bx-file"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 overflow-hidden">
                                                <h5 class="font-size-14 text-truncate mb-1"><a href="#" class="p-0">analytics dashboard.zip</a></h5>
                                                <p class="text-muted font-size-13 mb-0">6.7 MB</p>
                                            </div>

                                            <div class="flex-shrink-0 ms-3">
                                                <div class="dropdown">
                                                    <a class="dropdown-toggle font-size-18 text-muted px-1" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="bx bx-dots-horizontal-rounded"></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Open <i class="bx bx-folder-open ms-2 text-muted"></i></a>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Edit <i class="bx bx-pencil ms-2 text-muted"></i></a>
                                                        <div class="dropdown-divider"></div>
                                                        <a class="dropdown-item d-flex align-items-center justify-content-between" href="#">Delete <i class="bx bx-trash ms-2 text-muted"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Add pinned tab Modal -->

            <!-- forward Modal -->
           <!---  <div class="modal fade forwardModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content modal-header-colored shadow-lg border-top-0">
                        <div class="modal-header">
                            <h5 class="modal-title text-white font-size-16">Share this Message</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                        <div class="modal-body p-4">
                            <div>
                                <div class="replymessage-block mb-2">
                                    <h5 class="conversation-name">Jean Berwick</h5>
                                    <p class="mb-0">Yeah everything is fine. Our next meeting tomorrow at 10.00 AM</p>
                                </div>
                                <textarea class="form-control" placeholder="Type your message..." rows="2"></textarea>
                            </div>
                            <hr class="my-4">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control bg-light border-0 pe-0" placeholder="Search here.." 
                                aria-label="Example text with button addon" aria-describedby="forwardSearchbtn-addon">
                                <button class="btn btn-light" type="button" id="forwardSearchbtn-addon"><i class='bx bx-search align-middle'></i></button>
                            </div>

                            <div class="d-flex align-items-center px-1">
                                <div class="flex-grow-1">
                                    <h4 class="mb-0 font-size-11 text-muted text-uppercase">Contacts</h4>
                                </div>
                                <div class="flex-shrink-0">
                                    <button type="button" class="btn btn-sm btn-primary">Share All</button>
                                </div>
                            </div>
                            <div data-simplebar style="max-height: 150px;" class="mx-n4 px-1">
                                <div>
                                    <div class="contact-list-title">
                                        A
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Albert Rodarte</h5>
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Allison Etter</h5>                        
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <!-- end contact list A -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        C
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Craig Smiley</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <!-- end contact list C -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        D
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Daniel Clay</h5>  
                                                </div>
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Doris Brown</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                                <!-- end contact list D -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        I
                                    </div>

                                    <ul class="list-unstyled contact-list">
                
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Iris Wells</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <!-- end contact list I -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        J
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Juan Flakes</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">John Hall</h5>
                                                </div>                                                
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Joy Southern</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <!-- end contact list J -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        M
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Mary Farmer</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Mark Messer</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Michael Hinton</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                                <!-- end contact list M -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        O
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Ossie Wilson</h5>
                                                </div>                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                                <!-- end contact list O -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        P
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Phillis Griffin</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Paul Haynes</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                                <!-- end contact list P -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        R
                                    </div>

                                    <ul class="list-unstyled contact-list">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Rocky Jackson</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                                <!-- end contact list R -->

                                <div class="mt-3">
                                    <div class="contact-list-title">
                                        S
                                    </div>

                                    <ul class="list-unstyled contact-list mb-0">
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Sara Muller</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Simon Velez</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <h5 class="font-size-14 m-0">Steve Walker</h5>
                                                </div>
                        
                                                <div class="flex-shrink-0">
                                                    <button type="button" class="btn btn-sm btn-primary">Send</button>
                                                </div>
                                            </div>
                                        </li>

                                    </ul>
                                </div>
                                <!-- end contact list S -->
                            </div>
                        </div>                        
                    </div>
                </div>
            </div> --->
            <!-- forward Modal -->

            <!-- contactModal -->
            <div class="modal fade contactModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content modal-header-colored shadow-lg border-0">
                        <div class="modal-header">
                            <h5 class="modal-title text-white font-size-16">Kişiler</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                        <div class="modal-body p-4">
                            
                            <div class="input-group mb-4">
                                <input type="text" class="form-control bg-light border-0 pe-0" placeholder="Search here.." id="searchContactModal" onkeyup="searchContactOnModal()" 
                                aria-label="Example text with button addon" aria-describedby="contactSearchbtn-addon">
                                <button class="btn btn-light" type="button" id="contactSearchbtn-addon"><i class='bx bx-search align-middle'></i></button>
                            </div>

                            <div class="d-flex align-items-center px-1">
                                <div class="flex-grow-1">
                                    <h4 class=" font-size-11 text-muted text-uppercase">Kişiler</h4>
                                </div>
                            </div>
                            <div class="contact-modal-list mx-n4 px-1" data-simplebar style="max-height: 200px;">
                                <div class="mt-3">
                                <cfquery name="managers_all" datasource="next_destekportal">
                                            SELECT MANAGER_ID
                                            ,MANAGER_NAME + ' ' + MANAGER_SURNAME AS NAME_
                                    
                                            FROM MANAGERS
                                            ORDER BY MANAGER_NAME ASC 
                                    </cfquery>
                                  
                                <cfoutput query="managers_all">
                                     <ul class="list-unstyled contact-list contact_message_hover" onclick="message_button(#manager_id#)">
                                         <li>
                                            <div>
                                                <h5 class="font-size-14 m-0 manager_name_rename#manager_id#" >#NAME_#</h5>
                                            </div>
                                        </li>
                                    </ul>
                                </cfoutput>
                                </div>
                                <!-- end contact list A -->
                            </div>
                        </div>       
                        <div class="modal-footer">
                            <button type="button" class="btn btn-link" data-bs-dismiss="modal">Kapat</button>
                        </div>                 
                    </div>
                </div>
            </div>
            <!-- contactModal -->

            <!-- CANNED_ANSWER_MODAL -->
           <div class="modal fade cannedmodal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content modal-header-colored shadow-lg border-0">
                        <div class="modal-header">
                            <h5 class="modal-title text-white font-size-16">Hazır Cevap Ekle</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-4">
                            <div class="d-flex align-items-center px-1">
                                <div class="flex-grow-1">
                                    <h4 class=" font-size-11 text-muted text-uppercase">Hazır Cevap</h4>
                                </div>
                            </div>
                            <div class="d-flex align-items-center px-1">
                                 <div class="flex-grow-1">
                                    <div class="canned-answer-feedback d-none .text-danger">
                                        Lütfen Geçerli Bir Cevap Giriniz
                                    </div>
                                    <input type="text" name="canned_answer" id="canned_answer" class="form-control" required>
                                </div>
                            </div>
                        </div>       
                        <div class="modal-footer">
                            <button type="button" class="btn btn-link" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" id="submit-btn-canned-answer"><i class="bx bxs-send align-middle"></i></button>
                        </div>                 
                    </div>
                </div>
            </div>
            <!-- CANNED_ANSWER_MODAL -->

            <!-- GALLERY MODAL -->  
                <div class="modal modal-fullscreen gallerymodal"  tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                             
                               <!---  <div class="row card" style="text-align:center">
                                    <div class="col-md-12 round" style="height:600px" >
                                             <img id="change_image" src="assets/chat_images/#get_photos.MESSAGE#" width="100%" height="100%">
                                     </div>
                                    <div class="col-md-12 list-group list-group-horizontal overflow-auto owerflow-hidden"> 
                                        <cfloop query="get_photos">
                                            <div class="col-md-2" >
                                                <input type="hidden" id="open_image_#get_photos.id#" value="#get_photos.MESSAGE#">
                                                <img onclick="open_image(#get_photos.id#)" class="remove_class_img_#get_photos.id#  round remove_class_img list-group-item list-group-item-action "   src="assets/chat_images/#get_photos.MESSAGE#" width="100%" height="100%">
                                            </div> 
                                        </cfloop> 
                                    </div>  
                                </div>    ---> 
                            </div>  
                        </div> 
                </div>
         
            <!---  <script>
                function open_image(id)
                {
                   $('.close_gallery').addClass('d-none');  
                   $('.open_gallery').removeClass('d-none');  
                }
            </script> --->
           
            <!-- GALLERY MODAL -->
            <!-- <video id="video" autoplay="true">

            </video>     -->
        </div>
        <!-- end  layout wrapper -->

        <!-- JAVASCRIPT -->
        <script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/libs/simplebar/simplebar.min.js"></script>
        <script src="assets/libs/node-waves/waves.min.js"></script>
        
        <!-- glightbox js -->
        <script src="assets/libs/glightbox/js/glightbox.min.js"></script>

        <!-- Swiper JS -->
        <script src="assets/libs/swiper/swiper-bundle.min.js"></script>

        <!-- fg-emoji-picker JS -->
        <script src="assets/libs/fg-emoji-picker/fgEmojiPicker.js"></script>

        <!-- page init --> 
        <script src="assets/js/pages/index.init.js"></script>  

        <script src="assets/js/app.js"></script>
    </body>
</html> 

  
<!--- START CHAT LIST AJAX UD.--->

<script language="javascript" type="text/javascript">

        function open_image(id){
            $('.remove_class_img').removeClass("bg-dark" );
            $(`.remove_class_img_${id}`).addClass( "bg-dark");
            var photo= $(`#open_image_${id}`).val();

            $(`#change_image`).attr("src", "assets/chat_images/"+photo);
            
            }

        var timeout = setInterval(reloadChat2, 1000); 
        
        const end_man_ids =[];

         $(".end_manager_id" ).each(function( index ) {
            end_man_ids.push( parseInt($( this ).text()));
         });

        const end_ids =[];

         $(".end_message_id" ).each(function( index ) {
            end_ids.push( parseInt($( this ).text()));
         });
   
         
 

     
 
        function reloadChat2 () {
            const end_man_ids =[];

            $(".end_manager_id" ).each(function( index ) {
                end_man_ids.push( parseInt($( this ).text()));
            });

            const end_ids =[];

            $(".end_message_id" ).each(function( index ) {
                end_ids.push( parseInt($( this ).text()));
            });
            var sender_id=$(`#manager_id_`).val();
           
            
            $.ajax({
                type: "POST",
                url: `cfc/add_message.cfc?method=loading_chats&returnformat=json&sender_id=${sender_id}&end_ids=${end_ids}`,
                success: function (status) { 
                var json_parse = JSON.parse(status);
                var json_parse = json_parse.sizelist;
                const length = Object.keys(json_parse).length;
               
                for (let i = 0; i < length; i++) {
                    var kisi = json_parse[i].MANAGER_ID; 
                    var returnn =  end_man_ids.indexOf(kisi);     
                    var photo_file = parseInt(json_parse[i].PHOTO_FILE);
                    
                     
                        if(returnn == -1)
                        {
                            end_man_ids.push(kisi);
                                            
                                            $("#favourite-users").prepend(`
                                            <li id="contact-id-${json_parse[i].MANAGER_ID}" data-name="favorite" class="remove_class active" onclick="message_button(${json_parse[i].MANAGER_ID})">             
                                                    <a href="javascript: void(0);" class="unread-msg-user">                  
                                                        <div class="d-flex align-items-center">            
                                                            <div class="chat-user-img online align-self-center me-2 ms-0">       
                                                                    <img src="assets/images/users/${json_parse[i].MANAGER_PHOTO}" class="rounded-circle avatar-xs" alt="">
                                                                <span class="user-status"></span>                   
                                                            </div>            
                                                            <div class="row d-flex align-items-center end_id_top${json_parse[i].MANAGER_ID}">       
                                                                    <p class="text-truncate mb-0 manager_name_rename${json_parse[i].MANAGER_ID}" > ${json_parse[i].NAME_}</p> 
                                                                    <p class="text-truncate mb-0" id="end-message-${json_parse[i].MANAGER_ID}" style="width:10rem;word-wrap: break-word;">
                                                                        ${json_parse[i].MESSAGE}
                                                                    </p> 
                                                                    <span class="end_message_id d-none" >12</span>  <span class="end_manager_id d-none" >${json_parse[i].MANAGER_ID}</span>      
                                                            </div>   
                                                               
                                                            <div class="ms-auto"> 
                                                                <span class="right font-size-11" style="float: right;" id="end-message-date-${json_parse[i].MANAGER_ID}">
                                                                        ${json_parse[i].SEND_DATE}
                                                                  </span> 
                                                                 <br>
                                                                <span class="badge badge-soft-primary text-dark rounded p-1" id="end-message-view_count-${json_parse[i].MANAGER_ID}" style="float: right;"></span>
                                                            </div> 
                                                        </div>            
                                                    </a>           
                                            </li>`);
                        }
                       
                        else
                        {
                            
                            $(`#contact-id-${json_parse[i].MANAGER_ID}`).prependTo("#favourite-users").fadeIn();
                            if (photo_file == 1){
                                 $(`#end-message-${json_parse[i].MANAGER_ID}`).html(` <i class="fa fa-image"></i> Görüntü`);
                            } 
                            else if (photo_file == 2){
                                 $(`#end-message-${json_parse[i].MANAGER_ID}`).html(` <i class="fa fa-file"></i> Dosya`);
                            }
                            else{
                            $(`#end-message-${json_parse[i].MANAGER_ID}`).html(`${json_parse[i].MESSAGE}`);
                            }
                            $(`#end-message-date-${json_parse[i].MANAGER_ID}`).html(`${json_parse[i].SEND_DATE}`);
                            if(json_parse[i].VIEW_COUNT !=0){
                                     $(`#end-message-view_count-${json_parse[i].MANAGER_ID}`).html(`${json_parse[i].VIEW_COUNT}`);
                                }
                            $(`.end_id_top${json_parse[i].MANAGER_ID} > .end_message_id`).html(`${json_parse[i].ID},`);
                        }
                         
                        
                   } 
                    
                 }
                });   
        }
    </script>
<!--- END CHAT LIST AJAX UD.



 $("#favourite-users").prepend(`
                asd
     `)
---> 
 
<script>
  $(".nav-item").click(function (){
    $(`#user-chat-dnone`).removeClass("d-none");
    $(`.user_chat_add`).addClass("d-none");
    $(`.remove_class`).removeClass("active" );
  })
        $("#submit-btn-canned-answer").click(function (){
                var ans = $("#canned_answer").val();
                if($('#canned_answer').val() == '')
                {
                    $('.canned-answer-feedback').removeClass("d-none");
                    return false;
                }
                else   {
                    $('.canned-answer-feedback').addClass("d-none");
                    $.ajax({
                        type: "POST",
                        url: `cfc/add_message.cfc?method=add_canned_message&returnformat=json&ans=${ans}`,
                        success: function (status) {   
                        var json_parse = JSON.parse(status);  
                            $('.cannedmodal').modal('toggle');
                            $('#canned_answer_prepend').append(`<li class="list-group-item" style="cursor:pointer" id="hazir_cevap_${json_parse.DATA[0][0]}">${json_parse.DATA[0][1]}</li>`);
                        }
                    });
                }
        })
        $("#closed_chats").click(function ()
        {   
             var solved_id = $("#message_manager_id").val();
             
                    url_ = 'https://destekportal.com/destekportal/dist/loading_closed_chats.cfm';
                    $.ajax({
                        type: "POST",
                        url: url_,
                        data: {manager_id:solved_id}, 
                        success: function(data){  
                            $(`#closed_chats_loading`).html(data); 
                             
                        /*   $('.nav-link').removeClass('active');
                             $('#pills-chat-tab').addClass('active'); */
                        }
                    }); 
        })
        $(document).on('click', '.list-group-item', function() {
            $("#hazir_cevap").collapse("toggle");
            $(".chat-input").val($(this).text())
        });

        function message_button(manager_id){
            /*   $('.chat-conversation').html("123");
            alert("assd"); */
            var sender_id=$(`#manager_id_`).val();
             $(`.remove_class`).removeClass("active" );
            $(`#contact-id-${manager_id}`).addClass( "active" );
            $(`.contactModal`).modal("hide");
            $("#message_manager_id").val(manager_id);
            $(".user_chat_add").addClass("user-chat-show");
                url_ = 'https://destekportal.com/destekportal/dist/loading_messages.cfm';
                $.ajax({
                    type: "POST",
                    url: url_,
                    data: {manager_id:manager_id,manager_id_:sender_id}, 
                
                    success: function(data){  
                        $(`#user-chat-dnone`).addClass("d-none");
                        $(`.user_chat_add`).removeClass("d-none");
                        $(`.user_chat_add`).html(data);
                        $(`#end-message-view_count-${manager_id}`).html(``);
                            $("#message_manager_id").keypress(function() {
                              console.log( "Handler for .keypress() called." );
                            });
                    }
                });
        }  
        function close_message_button(manager_id){
            const chat_id_ = 1;
             $(".user_chat_add").addClass("user-chat-show");
                url_ = 'https://destekportal.com/destekportal/dist/loading_messages.cfm';
                $.ajax({
                    type: "POST",
                    url: url_,
                    data: {manager_id:manager_id,chat_id_:chat_id_}, 
                
                    success: function(data){  
                        $(`.remove_class`).removeClass("active" );
                        $(`#contact-id-close-${manager_id}`).addClass( "active" );
                        $(`#user-chat-dnone`).addClass("d-none");
                        $(`.user_chat_add`).removeClass("d-none");
                        $(`.user_chat_add`).html(data);
                     }
                });
        } 
 </script> 
    