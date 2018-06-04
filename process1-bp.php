<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
    <!--====== USEFULL META ======-->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Transportation & Agency Template is a simple Smooth transportation and Agency Based Template" />
    <meta name="keywords" content="Portfolio, Agency, Onepage, Html, Business, Blog, Parallax" />

    <!--====== TITLE TAG ======-->
    <title>QuietRent</title>

    <!--====== FAVICON ICON =======-->
    <link rel="shortcut icon" type="image/ico" href="img/favicon.png" />

    <!--====== STYLESHEETS ======-->
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/stellarnav.min.css">
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">

    <!--====== MAIN STYLESHEETS ======-->
    <link href="style.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">

    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
    <!--[if lt IE 9]>
        <script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>

<body class="single-page">

    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <!-- - PRELOADER -->
    <div class="preeloader">
        <div class="preloader-spinner"></div>
    </div>

    <!--SCROLL TO TOP-->
    <a href="#home" class="scrolltotop"><i class="fa fa-long-arrow-up"></i></a>

    <!--START TOP AREA-->
    <header class="top-area single-page" id="home" style="min-height:50px;height:100px;">
        <div class="header-top-area">
          <!--MAINMENU AREA-->
          <div class="mainmenu-area" id="mainmenu-area">
              <div class="mainmenu-area-bg"></div>
              <nav class="navbar">
                  <div class="container">
                      <div class="navbar-header">
                          <a href="index.html" class="navbar-brand"><img src="img/logo.png" alt="logo"></a>
                      </div>
                      <div id="main-nav" class="stellarnav">
                          <ul id="nav" class="nav navbar-nav">
                              <li><a href="index.html">Acceuil</a>
          <!--                                    <ul>
                                      <li><a href="index.html">Home Version 1</a></li>
                                      <li><a href="index-2.html">Home Version 2</a></li>
                                      <li><a href="index-3.html">Home Version 3</a></li>
                                      <li><a href="index-4.html">Home Version 4</a></li>
                                  </ul>
          -->
                              </li>
                              <li><a href="about-company-profile.html">À Propos</a>
                                  <ul>
                                      <li><a href="about-company-profile.html">La Société</a></li>
                                      <li><a href="about-company-history.html">Notre histoire</a></li>
                                      <li><a href="about-team.html">L'équipe</a></li>

                                  </ul>
                              </li>
                              <li><a href="index.html#service" >Service</a>
                                  <ul>
                                      <li><a href="service.html">SCORING GLI</a></li>
                                      <li><a href="service-2.html">CAUTION GAPD</a></li>
          <!--                                        <li><a href="service-3.html">Service Version 3</a></li>
                                      <li><a href="single-service.html">Service Details</a></li>
          -->                                 </ul>
                              </li>

                              <li><a href="#contact">Contact</a>
                              </li>
                          </ul>
                      </div>
                  </div>
              </nav>
          </div>
          <!--END MAINMENU AREA END-->
        </div>
    </header>
    <!--END TOP AREA-->

    <!--FORM AREA-->
    <section class="section-padding gray-bg">
        <div class="section-padding gray-bg">
            <div class="container">
                    <h2>Merci pour votre demande, elle sera traité dans les plus brefs délais.</h2>
                    <p> le détails ici : <br><br>

                      <?php

                      echo
                      "adresse ".$_POST['adresse']." -<br> ".
                      "demandeur ".$_POST['demandeur']." -<br> ".
                      "adresse_d ".$_POST['adresse_d']." -<br> ".
                      "naissance ".$_POST['naissance']." -<br> ".
                      "lieu ".$_POST['lieu']." -<br> ".
                      "montant ".$_POST['montant']." -<br> ".
                      "duree ".$_POST['duree']." -<br> ".
                      "date_effet ".$_POST['date_effet']." -<br> ".
                      "objet ".$_POST['objet']." -<br> ".
                      "nom ".$_POST['nom']." -<br> ".
                      "prenom ".$_POST['prenom']." -<br> ".
                      "adresse_b ".$_POST['adresse_b'];
                      ?>
                    </p>
            </div>
        </div>
    </section>
    <!--FORM AREA END-->

    <!--FOOER AREA-->
    <div class="footer-area dark-bg">
        <div class="footer-area-bg"></div>
        <div class="footer-top-area wow fadeIn">
            <div class="container">
                <div id="contact" class="row">
                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                        <div class="subscribe-content">
                            <h2>POUR UNE PRISE DE CONTACT RAPIDE, RENTREZ SIMPLEMENT VOTRE MAIL !</h2>
                            <p>Vous souhaitez nous contacter ? Déposez votre adresse mail et nous communiquerons dans les plus brefs délais.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                        <div class="subscriber-form-area">
<!-- PENSER AU MAILTO DANS LE FORM QUAND DEPOT SUR SERVEUR -->
                            <form action="#" class="subsriber-form">
                                <label for="subscriber-mail"><i class="fa fa-envelope-o"></i></label>
                                <input type="email" name="subscriber-mail" id="subscriber-mail" placeholder="Enter Your Mail">
                                <button type="submit">Envoyer</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="footer-border"> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom-area wow fadeIn">
            <div class="container">
                <div id="contact" class="row">
                    <div class="col-md-3 col-lg-3 col-sm-6 col-xs-12">
                        <div class="single-footer-widget footer-about">
                            <h3>À propos</h3>
                            <p></p>
                            <ul>
                              <li><i class="fa fa-user"></i> M. ELLOUK David</li>
                              <li><i class="fa fa-clipboard"></i>Consultant</li>
                              <li><i class="fa fa-at"></i>Contact@quietrent.com</li>
                              <li><i class="fa fa-phone"></i>06.59.01.51.83 </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="footer-border"> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-copyright-area">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                        <div class="footer-copyright wow fadeIn">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            <p>Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a></p>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--FOOER AREA END-->

    <!--====== SCRIPTS JS ======-->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>

    <!--====== PLUGINS JS ======-->
    <script src="js/vendor/jquery.easing.1.3.js"></script>
    <script src="js/vendor/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/vendor/jquery.appear.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/stellar.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/stellarnav.min.js"></script>
    <script src="js/contact-form.js"></script>
    <script src="js/jquery.sticky.js"></script>

    <!--===== ACTIVE JS=====-->
    <script src="js/main.js"></script>
</body>

</html>
