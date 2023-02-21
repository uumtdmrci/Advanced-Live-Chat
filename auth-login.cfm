<!doctype html>
<html lang="en">

    <head>
        <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>

        <meta charset="utf-8" />
        <title>Log in | DestekPortal - Responsive Bootstrap 5 Chat App</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="DestekPortal - Responsive Chat App Template in HTML. A fully featured HTML chat messenger template in Bootstrap 5" name="description" />
        <meta name="keywords" content="DestekPortal chat template, chat, web chat template, chat status, chat template, communication, discussion, group chat, message, messenger template, status"/>
        <meta content="Umut DEMİRCİ" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico" id="tabIcon">

        
        <!-- Bootstrap Css -->
        <link href="assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />


    </head>
     <body>
        <div class="auth-bg">
            <div class="container-fluid p-0">
                <div class="row g-0">
                    <div class="col-xl-3 col-lg-4">
                        <div class="p-4 pb-0 p-lg-5 pb-lg-0 auth-logo-section">
                            <div class="text-white-50">
                                <h3><a href="" class="text-white"><i class="bx bxs-message-alt-detail align-middle text-white h3 mb-1 me-2"></i> DestekPortal</a></h5>
                             </div>
                            <div class="mt-auto">
                                <img src="assets/images/auth-img.png" alt="" class="auth-img">
                            </div>
                        </div>
                    </div>
                    <!-- end col -->
                    <div class="col-xl-9 col-lg-8">
                        <div class="authentication-page-content">
                            <div class="d-flex flex-column h-100 px-4 pt-4">
                                <div class="row justify-content-center my-auto">
                                    <div class="col-sm-8 col-lg-6 col-xl-5 col-xxl-4">
                                        
                                        <div class="py-md-5 py-4">
                                            
                                            <div class="text-center mb-5">
                                                <h3>Welcome Back !</h3>
                                                <p class="text-muted">Sign in to continue to DestekPortal.</p>
                                            </div>
                                            <form action="" id="target">
                                                <div class="mb-3">
                                                    <label for="phone" class="form-label">Phone Number</label>
                                                    <input type="number" class="form-control" maxlength="10" onkeyup="check_button()" id="phone" placeholder="Enter Phone Number">
                                                </div>
                                                <input type="hidden" name="sender_code" id="sender_code" value="">
 
                                                <div class="mb-3 d-none confirm_code">
                                                    <label for="code" class="form-label">Confirmation Code</label>
                                                    <input type="number" class="form-control" onkeyup="check_button()" id="code" placeholder="Enter Code">
                                                </div>
                                               <!---  <div class="mb-3">
                                                    <div class="float-end">
                                                        <a href="auth-recoverpw.cfm" class="text-muted">Forgot password?</a>
                                                    </div>
                                                    <label for="userpassword" class="form-label">Password</label>
                                                    <div class="position-relative auth-pass-inputgroup mb-3">
                                                        <input type="password" class="form-control pe-5" placeholder="Enter Password" id="password-input">
                                                        <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted" type="button" id="password-addon"><i class="ri-eye-fill align-middle"></i></button>
                                                    </div>
                                                </div> --->
            
                                               <!---  <div class="form-check form-check-info font-size-16">
                                                    <input class="form-check-input" type="checkbox" id="remember-check">
                                                    <label class="form-check-label font-size-14" for="remember-check">
                                                        Remember me
                                                    </label>
                                                </div> --->
            
                                                <div class="text-center mt-4">
                                                    <button class="btn btn-primary w-100 d-none" type="button" id="submit_btn">Log In</button>
                                                </div>
                                                <div class="mt-4 text-center">
                                                    <div class="signin-other-title">
                                                        <h5 class="font-size-14 mb-4 title">Sign in with</h5>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div>
                                                                <button type="button" class="btn btn-light w-100" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Facebook"><i class="mdi mdi-facebook text-indigo"></i></button>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div>
                                                                <button type="button" class="btn btn-light w-100" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Google"><i class="mdi mdi-google text-danger"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form><!-- end form -->
            
                                            <div class="mt-5 text-center text-muted">
                                                <p>Don't have an account ? <a href="auth-register.html" class="fw-medium text-decoration-underline"> Register</a></p>
                                            </div>
                                        </div>
                                    </div><!-- end col -->
                                </div><!-- end row -->
            
                                <div class="row">
                                    <div class="col-xl-12">
                                        <div class="text-center text-muted p-4">
                                            <p class="mb-0">&copy; <script>document.write(new Date().getFullYear())</script> DestekPortal. Crafted with <i class="mdi mdi-heart text-danger"></i> by Umut DEMİRCİ</p>
                                        </div>
                                    </div><!-- end col -->
                                </div><!-- end row -->
            
                            </div>
                        </div>
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container-fluid -->
        </div>
        <!-- end auth bg -->

        <!-- JAVASCRIPT -->
        <script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/libs/simplebar/simplebar.min.js"></script>
        <script src="assets/libs/node-waves/waves.min.js"></script>
        <!-- password addon -->
        <script src="assets/js/pages/password-addon.init.js"></script>

        <!-- theme-style init -->
        <script src="assets/js/pages/theme-style.init.js"></script>
        
        <script src="assets/js/app.js"></script>
        <script>
                function check_button(){
                    var number= $("#phone").val();
                    var length=number.length;
                    
                    if(length == 10)
                    {
                        $("#submit_btn").removeClass("d-none") 
                     }
                    else{
                        $("#submit_btn").addClass("d-none") 
                     }
                    
                }
                $("#submit_btn").click(function () {
                    var number= $("#phone").val();
                        $.ajax({
                            type: "POST",
                            url: `cfc/add_message.cfc?method=manager_check_login&returnformat=json&number=${number}`,
                            success: function (status) {  
                              
                                 if(status == 1)
                                    {
                                    if($("#sender_code").val() == '')
                                        {           
                                            var code = Math.floor(1000 + Math.random() * 9000);
                                            url_ = 'https://destekportal.com/destekportal/dist/sms/login_confirmation_code_sms.cfm';
                                            $.ajax({
                                            type: "POST",
                                            url: url_,
                                            data: {number:number,code:code}, 
                                                success: function(data){  
                                                    $(".confirm_code").removeClass("d-none");
                                                    $("#sender_code").val(code);
                                                     }
                                            });
                                        }   
                                        else{ 
                                        var code_= $("#code").val();
                                        var code= $("#sender_code").val();
                                            if(code_ == code )
                                                {
                                                    window.location.href = `https://destekportal.com/destekportal/dist/index.cfm?&sender_code=${code}&number=${number}`;
                                                 }
                                            else{
                                                    alert("Giriş Başarısız Tekrar Deneyiniz.")
                                                    location.reload();
                                                }
                                        }
                                    }
                                    else
                                    {
                                        alert("Giriş Başarısız , Kullanıcı Bulunamadı.")
                                    }
                            }
                        });
                           
                })

        </script>
    </body>
</html>
