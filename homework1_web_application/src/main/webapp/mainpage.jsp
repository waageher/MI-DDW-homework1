<%-- 
    Document   : mainpage
    Created on : Mar 31, 2016, 11:42:13 AM
    Author     : Bc. Herbert Waage
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        <li class="active"><a href="<%=request.getContextPath()%>/index"><span class="glyphicon glyphicon-star" aria-hidden="true"></span> Hodnocení</a></li>
                        <li><a href="<%=request.getContextPath()%>/technologies"><span class="glyphicon glyphicon-education" aria-hidden="true"></span> Použité technologie</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </nav>
        <div class="container theme-showcase" role="main">
            <h1>Hodnocení recenzí</h1>
            <div class="row">
                <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">Recenze</h2>
                        </div>
                        <div class="panel-body">
                            <form action="" method="POST" class="reviewForm">
                                <div class="form-group">
                                    <textarea required name="review" class="form-control" rows="11" placeholder="If you haven't read The Hobbit and/or if you like the first two movies: I envy you of sorts... 
If someone had told me some years ago that I would consider walking out from a Tolkien movie opening night, I would have slapped them with a cod. Or a salmon. The Hobbit trilogy is crap.
It's little more than a long list of invented battles and love stories to attract a widest possible audience, as well as loads of idiotic storyline to make the story slide into the Lord of the Rings movies as smooth as an Elven ass. 
I understand that some adaption is required from book to screen, but when dealing with a book more or less only surpassed by the Bible and the IKEA catalogue, one should tread carefully.
Do yourself a favor. Read the book. Let your mind be the big screen."><c:out value="${review}"/></textarea>
                                </div>
                                <button type="submit" class="btn btn-success submit">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    Ohodnotit
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2 class="panel-title">Hodnocení</h2>
                        </div>
                        <div class="panel-body">
                            Hodnocení je vypočítáno pomocí machine learning s využitím datasetu <a href="http://ai.stanford.edu/~amaas/data/sentiment/" target="_blank">Large Movie Review Dataset <span class="glyphicon glyphicon-new-window" aria-hidden="true"></span></a>.
                        </div>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Hodnocení</th>
                                    <th>Pravděpodobnost</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty score}">
                                        <tr>
                                            <c:choose>
                                                <c:when test="${score.getRating()=='-1'}">
                                                    <td colspan="2" class="centered">Při výpočtu hodnocení nastala chyba!</td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td>
                                                        <c:forEach var="i" begin="1" end="${score.getRating()}">
                                                            <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                                        </c:forEach>
                                                        <c:forEach var="j" begin="${score.getRating() + 1}" end="10">
                                                            <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                                        </c:forEach>
                                                    </td>
                                                    <td><c:out value="${score.getPercentage()}"/>%</td>
                                                </c:otherwise>
                                            </c:choose>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="2" class="centered">Musíte zadat nějakou recenzi k ohodnocení.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
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