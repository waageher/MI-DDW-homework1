<%-- 
    Document   : technologies
    Created on : Mar 31, 2016, 3:32:12 PM
    Author     : Bc. Herbert Waage
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="cs">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Aplikace pro hodnocení recenzí podle textu pomocí Machine Learning a GATE Embedded.">
        <meta name="author" content="Herbert Waage">
        <link rel="icon" href="./resources/images/favicon.png">

        <title>MI-DDW - homework 1</title>

        <!-- Bootstrap core CSS -->
        <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap theme -->
        <link href="./resources/css/bootstrap-theme.min.css" rel="stylesheet">

        <link href="./resources/css/default.css" rel="stylesheet" type="text/css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body role="document">
        <!-- Fixed navbar -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="<%=request.getContextPath()%>/index">Hodnocení recenzí</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="<%=request.getContextPath()%>/index"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Hodnocení</a></li>
                        <li class="active"><a href="<%=request.getContextPath()%>/technologies"><span class="glyphicon glyphicon-education" aria-hidden="true"></span> Použité technologie</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </nav>
        <div class="container theme-showcase" role="main">
            <h1>Použité technologie</h1>
            <svg width="600" height="670">
            <rect class="svg_group_1" width="200" height="50" x="160" y="10" rx="5" ry="5"/>
            <text class="svg_group_1" x="207" y="39">Document Reset</text>
            
            <path d="M 160 35 q -52 50 -50 75" />
            <polygon points="105,100 110,110 115,100"/>
            <rect class="svg_group_2" width="200" height="50" x="10" y="110" rx="5" ry="5"/>
            <text class="svg_group_2" x="52" y="139">JAPE Transducer</text>
            
            <polygon points="405,100 410,110 415,100"/>
            <rect class="svg_group_3" width="200" height="50" x="310" y="110" rx="5" ry="5"/>
            <text class="svg_group_3" x="340" y="139">Annotation Set Transfer</text>
            
            <rect class="svg_group_4" width="200" height="50" x="160" y="210" rx="5" ry="5"/>
            <text class="svg_group_4" x="181" y="239">ANNIE English Tokeniser</text>
            
            <line x1="260" y1="260" x2="260" y2="310"/>
            <polygon points="255,300 260,310 265,300"/>
            <rect class="svg_group_5" width="200" height="50" x="160" y="310" rx="5" ry="5"/>
            <text class="svg_group_5" x="183" y="339">ANNIE Sentence Splitter</text>
            
            <line x1="260" y1="410" x2="260" y2="360"/>
            <polygon points="255,400 260,410 265,400"/>
            <rect class="svg_group_6" width="200" height="50" x="160" y="410" rx="5" ry="5"/>
            <text class="svg_group_6" x="197" y="439">ANNIE POS Tagger</text>
            
            <line x1="260" y1="510" x2="260" y2="460"/>
            <polygon points="255,500 260,510 265,500"/>
            <rect class="svg_group_7" width="200" height="50" x="160" y="510" rx="5" ry="5"/>
            <text class="svg_group_7" x="166" y="539">GATE Morphological analyser</text>
            
            <polygon points="105,600 110,610 115,600"/>
            <rect class="svg_group_9" width="200" height="50" x="10" y="610" rx="5" ry="5"/>
            <text class="svg_group_9" x="49" y="639">Test Batch Learning</text>
            
            <polygon points="405,600 410,610 415,600"/>
            <rect class="svg_group_8" width="200" height="50" x="310" y="610" rx="5" ry="5"/>
            <text class="svg_group_8" x="345" y="639">Train Batch Learning</text>
            </svg>
        </div>
        <footer class="footer">
            <div class="container">
                <p class="text-muted">© Bc. Herbert Waage</p>
            </div>
        </footer>
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="./resources/js/bootstrap.min.js"></script>
        <script src="./resources/js/default.js" type="text/javascript"></script>
    </body>
</html>