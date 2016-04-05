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
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">GATE Embedded</h2>
                        </div>
                        <div class="panel-body">
                            <p>
                                Pro získání znalostí z dat jsem použil software 
                                <a href="https://gate.ac.uk/" target="_blank"><abbr title="General Architecture for Text Engineering">GATE</abbr> <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>
                                a jeho možnost využít ho v aplikacích na bázi Javy (GATE Embedded).</p>
                            <p>
                                V zadání úkolu bylo využít nějaké z mnoha pluginů, které poskytuje právě GATE nebo jemu podobný nástroj a zkombinovat je, aby vznikla smysluplná aplikace.
                                Při tvorbě aplikace jsem vycházel z přednášky
                                <a href="https://gate.ac.uk/sale/talks/gate-course-may10/track-3/module-11-ml-adv/module-11-sentiment.pdf" target="_blank">Sentiment Analys (Opinion Mining) with Machine Learning in GATE <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>,
                                ale pročetl jsem i přednášky na stejné téma od University of Sheffield a to přednášky
                                <a href="https://gate.ac.uk/sale/talks/gate-course-jun15/module-4-opinion-mining/module-4-opinion-mining.pdf" target="_blank">Opinion Mining <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a> a
                                <a href="https://gate.ac.uk/sale/talks/gate-course-may11/track-3/module-11-machine-learning/module-11.pdf" target="_blank">Machine Learning <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>. 
                            </p>
                            <p>
                                Při integraci GATE Embedded do webové aplikace se mi značně hodila <a href="https://gate.ac.uk/sale/tao/splitch7.html#chap:api" target="_blank">dokumentace <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>,
                                obzvláště při nastavování parametrů pro jednotlivé pluginy.
                            </p>
                            <p>
                                Jaké pluginy jsem použil a v jakém pořadí je vyobrazeno na obrázku. Rozdělení flow na 2 větve značí trai/test fázi. Nastavení každého pluginu vychází z výše zmíněné přednášky.
                            </p>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">Machine learning dataset</h2>
                        </div>
                        <div class="panel-body">
                            <p>
                                Pro učící fázi jsem použil <a href="http://ai.stanford.edu/~amaas/data/sentiment/" target="_blank">Large Movie Review Dataset <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>,
                                který jsem ale musel před použitím nejprve ztransformovat do podoby, kteou GATE akceptoval (pro tento účel jsem napsal transformaci dat v Javě, která je také přiložena na serveru
                                <a href="https://github.com/waageher/MI-DDW-homework1" target="_blank">Github <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>).
                            </p>
                            <p>
                                Výše zmíněný dataset obsahuje 25000 anotovaných recenzí na účicí fázi a 25000 na trénovací fázi. Můj prvotní záměr byl využít všechny tyto data, aby byl výsledek co nejpřesnější.
                                Nicméně můj notebook na to nestačil ani při výpočtu trvajícím 3 dny. Hlavní problém, na který jsem narazil byl nedostatek paměti. GATE totiž pro uložení všech anotací potřebných
                                pro machine learning spotřebuje enormní množství paměti. Desktopová verze GATE se zvládla naučit maximálně z 1000 recenzí (při čemž úspěšnost správného ohodnocení byla 36%). Při
                                integraci GATE Embedded jsem se dokázal naučit z 2000 recenzí. Poté již došla pamět a swapování na disk je neúnosně pomalé. 
                            </p>
                            <p>
                                Další zajímavý poznatek je, že dataset obsahuje pouze hodnocení 0-4<span class="glyphicon glyphicon-star" aria-hidden="true"></span> a 7-10<span class="glyphicon glyphicon-star" aria-hidden="true"></span>,
                                tudíž pokud se zadá hodnocení například 6 hvězdiček, tak ho to ohodnotí například na 4<span class="glyphicon glyphicon-star" aria-hidden="true"></span>, ale nikdy ne na 6<span class="glyphicon glyphicon-star" aria-hidden="true"></span>.
                            </p>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">Webová aplikace</h2>
                        </div>
                        <div class="panel-body">
                            <p>Pro vývoj samotné webové aplikace jsem použil Netbeans a Javu. Co se týče view vrstvy, tak jsem využil <abbr title="HyperText Markup Language">HTML</abbr>5 
                                (<abbr title="Scalable Vector Graphics">SVG</abbr> tag pro zobrazení flow informací v <abbr title="General Architecture for Text Engineering">GATE</abbr>) a 
                                <abbr title="Cascading Style Sheets">CSS</abbr> (Boostrap).</p>
                            <p>Nejtěžší překážkou při tvorbě byla moje neznalost vývoje klasikých webových aplikací v Javě, protože jsem to nikdy nedělal. 
                                Předmět <abbr title="Webové služby a middleware">MI-MDW</abbr> jsem sice absolvoval, ale tam se kladl důraz spíše na middleware (jak již název napovídá).</p>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">GATE plugins</h2>
                        </div>
                        <div class="panel-body">
                            <svg viewBox="0 0 550 670">
                            <rect class="svg_group_1" width="200" height="50" x="160" y="10" rx="5" ry="5"/>
                            <text class="svg_group_1" x="207" y="39">Document Reset</text>

                            <text x="75" y="55">test</text>
                            <path d="M 160 35 q -52 0 -50 75" />
                            <polygon points="105,100 110,110 115,100"/>
                            <rect class="svg_group_2" width="200" height="50" x="10" y="110" rx="5" ry="5"/>
                            <text class="svg_group_2" x="52" y="139">JAPE Transducer</text>

                            <text x="425" y="55">train</text>
                            <path d="M 360 35 q 52 0 50 75" />
                            <polygon points="405,100 410,110 415,100"/>
                            <rect class="svg_group_3" width="200" height="50" x="310" y="110" rx="5" ry="5"/>
                            <text class="svg_group_3" x="340" y="139">Annotation Set Transfer</text>

                            <path d="M 110 160 q 0 80 50 75" />
                            <polygon points="160,235 150,230 150,240"/>
                            <path d="M 410 160 q 0 80 -50 75" />
                            <polygon points="360,235 370,230 370,240"/>
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

                            <text x="75" y="555">test</text>
                            <path d="M 160 535 q -52 0 -50 75" />
                            <polygon points="105,600 110,610 115,600"/>
                            <rect class="svg_group_9" width="200" height="50" x="10" y="610" rx="5" ry="5"/>
                            <text class="svg_group_9" x="49" y="639">Test Batch Learning</text>

                            <text x="425" y="555">train</text>
                            <path d="M 360 535 q 52 0 50 75" />
                            <polygon points="405,600 410,610 415,600"/>
                            <rect class="svg_group_8" width="200" height="50" x="310" y="610" rx="5" ry="5"/>
                            <text class="svg_group_8" x="345" y="639">Train Batch Learning</text>
                            </svg>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">Výsledek</h2>
                        </div>
                        <div class="panel-body">
                            <p>
                                Výsledkem je tedy webová aplikace, která ohodnotí zadanou recenzi v anglickém jazyce počtem <span class="glyphicon glyphicon-star" aria-hidden="true"></span>, jaký by mu hodnotící
                                uživatel pravděpodobně dal. V extrémních případech (1 nebo 10<span class="glyphicon glyphicon-star" aria-hidden="true"></span>) často ohodnotí přesně, v ostatních případech 
                                se stává, že neohodnotí přesně jako uživatel, ale většinou pozitivitu/negativitu odhadne správně.
                            </p>
                            <p>
                                Někdy se ovšem stane, že i 10<span class="glyphicon glyphicon-star" aria-hidden="true"></span>recenzi odhadne jako 1<span class="glyphicon glyphicon-star" aria-hidden="true"></span>, 
                                což je pravděpodobně způsobeno věcmi popsanými v přednáškách, které jsem zde uvedl. Jako nejzajímavější věc, která mě zaujala je rozpoznání ironie ("Tento film je skvělý, pokud jste 10ti leté dítě").
                            </p>
                        </div>
                    </div>
                </div>
            </div>
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