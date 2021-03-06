<%@tag pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@attribute name="title"%>
<jsp:useBean id="global" class="to.jump.Global" />

<t:base_layout title="${title}">
	<jsp:attribute name="head">
    <link href="assets/css/jumbotron-narrow.css" rel="stylesheet">
	<link
			href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
			rel="stylesheet">
</jsp:attribute>
	<jsp:body>
	<div class="container">
      <div class="header clearfix">
        <h3 class="text-muted pull-left">
			<a href="/"><img width="24" src="assets/imgs/small_logo.png"> ${global.siteName}</a>
		</h3>
        <nav>
          <form class="nav navbar-form pull-right" action="search" method="get">
          	<div class="input-group">
	            <input type="text" class="form-control" placeholder="Busca..." name="q">
	            <div class="input-group-btn">
	                <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
	            </div>
        	</div>
    
			<c:choose>
				<c:when test="${empty sessionScope.user}">
            		<a class="btn btn-success" href="/login">Login</a>
				</c:when>
				<c:otherwise>
            		<a class="btn btn-danger" href="/logout">Logout</a>
				</c:otherwise>
			</c:choose> 
          </form>
        </nav>
      </div>
      
		<c:if test="${not empty error && error.notShown()}">
			<div class="alert alert-danger" role="alert">
				<strong>Ops...</strong> ${error}
			</div>
		</c:if>
      
      <jsp:doBody />
      
      <footer class="footer">
        <p>Feito por <a href="#">Alexsandro</a>, <a href="#">Leandro</a> e <a
						href="#">Rafael</a> para a UFABC.</p>
      </footer>

    </div>
    
    <script>
					function shortenUrl() {
						$('#shortenUrlForm').submit();
					}
				</script>
    </jsp:body>
</t:base_layout>