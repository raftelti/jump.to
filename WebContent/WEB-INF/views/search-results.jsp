<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="global" class="to.jump.Global" />

<t:narrow_layout title="Resultados de busca">
	<link href="assets/css/search-results.css" rel="stylesheet">

	<div class="container">
		<h2>Resultados da busca: "${query}"</h2>
		<br>
		<c:choose>
			<c:when test="${empty results}">
				<h3>Sua busca n�o retornou nada!</h3>
			</c:when>
			<c:otherwise>
				<section class="col-xs-12 col-sm-6 col-md-12">
					<c:forEach var="link" items="${results}">
						<article class="search-result row">
							<div class="col-xs-12 col-sm-12 col-md-3">
								<a href="${link.shortUrl}" title="${link.title}" class="thumbnail" target="_blank"><img
									src="http://free.pagepeeker.com/v2/thumbs.php?size=x&url=${link.longUrl}"
									alt="${link.title}" /></a>
							</div>
							<div class="col-xs-12 col-sm-12 col-md-3">
								<ul class="meta-search">
									<li><i class="glyphicon glyphicon-calendar"></i> <span><fmt:formatDate
												value="${link.createTime}" pattern="dd/MM/yyyy" /></span></li>
									<li><i class="glyphicon glyphicon-time"></i> <span><fmt:formatDate
												value="${link.createTime}" pattern="HH:mm" /></span></li>
									<c:if test="${not empty link.tags}">
										<li><i class="glyphicon glyphicon-tags"></i> <span class="tags">${link.tags}</span></li>
									</c:if>
								</ul>
							</div>
							<div class="col-xs-12 col-sm-12 col-md-6 excerpet">
								<h3>
									<a href="${link.shortUrl}" title="${link.title}">${link.title}</a>
								</h3>
								<p>${link.description}</p>
								<hr>
								<p>Clicks: ${link.clicks}
								
								<c:if test="${not empty user && link.userId == user.id}">
									<a href="${link.statisticsUrl}" class="text-default pull-right">
										<span class="glyphicon glyphicon-stats" aria-hidden="true"></span>
									</a>
								</c:if>
								</p>
							</div>
							<span class="clearfix borda"></span>
						</article>
					</c:forEach>
				</section>
			</c:otherwise>
		</c:choose>
	</div>
	
	<script>
	$(".tags").each(function(index) {
		  var text = $(this).text();
		  var words = text.trim().split(/[\s,]+/);

		  $(this).empty();
		  var that = this;
		  words.forEach(function(word) {
		    $(that).append('<a href="search?q='+word+'">' + word + '</a> ');
		  });
		});
	</script>
</t:narrow_layout>