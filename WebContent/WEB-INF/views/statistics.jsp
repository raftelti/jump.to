<%@page import="to.jump.utils.Browser"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="global" class="to.jump.Global" />
<t:narrow_layout>
	<link href="assets/css/share-buttons.css" rel="stylesheet">
	<link href="assets/css/chartist.min.css" rel="stylesheet">
	<script src="assets/js/qrcode.min.js"></script>
	<script src="assets/js/chartist.min.js"></script>
	<style>
	.ct-label.ct-horizontal.ct-end {
		font-size: 80%;
	}
	</style>

	<div class="container">
		<c:choose>
			<c:when test="${empty link.userId}">
				<div class="alert alert-warning" role="alert">
					<span>Essa URL curtinha n�o tem dono, suas estat�sticas podem
						ser visualizadas por qualquer um!</span>
				</div>
			</c:when>
			<c:otherwise>
				<c:if test="${empty user || link.userId != user.id}">
					<c:redirect url="/login" />
				</c:if>
			</c:otherwise>
		</c:choose>

		<div class="jumbotron">
			<h3><a href="${link.shortUrl}" target="_blank">${link.title}</a></h3>
			<h4>
				URL: <a href="${link.shortUrl}" target="_blank">${link.shortUrl}</a>
			</h4>
			<small>URL original:
				<a href="${link.longUrl}" target="_blank">${link.longUrl}</a>
			</small>
			<br>
			<br>
			<div class="ssb">
				<!-- Twitter -->
				<a href="#"
					onclick="window.open('https://twitter.com/intent/tweet?text=${link.shortUrl}&source=webclient', 'Twitter', 'WIDTH=700, HEIGHT=280');"
					title="Compartilhar no Twitter" target="_blank"
					class="btn btn-twitter"> <i class="fa fa-twitter"></i>Twitter
				</a>

				<!-- Facebook -->
				<a href="#"
					onclick="window.open('https://www.facebook.com/sharer/sharer.php?u=${link.shortUrl}', 'Facebook', 'WIDTH=700, HEIGHT=341');"
					title="Compartilhar no Facebook" target="_blank"
					class="btn btn-facebook"> <i class="fa fa-facebook"></i>Facebook
				</a>

				<!-- Google+ -->
				<a href="#"
					onclick="window.open('https://plus.google.com/share?url=${link.shortUrl}', 'Google+', 'WIDTH = 500, HEIGHT = 450');"
					title="Compartilhar no Google+" target="_blank"
					class="btn btn-googleplus"> <i class="fa fa-google-plus"></i>Google+
				</a>
			</div>
			<br>
			<div class="wrapper">
				<img
					src="http://free.pagepeeker.com/v2/thumbs.php?size=x&url=${link.longUrl}"
					style="border: 1px solid gray;">
			</div>
			<br>
			<br>
			<div class="well">			
				<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
				<p>Clicks at� agora: ${link.clicks}</p>
				<div class="row">
					<div class="col-lg-12">
						<h3>Clicks na �ltima semana</h3>
						<div class="ct-chart-clicks" style="height:200px"></div>
					</div>
					<div class="col-xs-12">
						<h3>Navegadores</h3>
						<div class="ct-chart-browsers" style="height:150px"></div>
					</div>
				</div>
			</div>
				
			<br>
			<p>QR Code do seu link.</p>
			<div id="qrcode" align="center"></div>
		
		</div>
		
		<button style="margin-bottom: 10px" class="btn btn-danger pull-right"
			type="button" onclick="removeLink(${link.id})">Remover Link</button>
		<a style="margin: 0 10px 10px 0" class="btn btn-default pull-right" href="${link.editUrl}">Editar Link</a>
	</div>

	<!-- removeLink -->
	<script>
        function removeLink(id) {
                if(confirm("Voc� deseja mesmo excluir esta URL?")) {
                        $.ajax('/removeLink', {
                                method: 'POST',
                                dataType: 'json',
                                data: {
                                        id: id
                                        }
                        }).done(function(data) {
                                if(data.error) {
                                        alert(data.msg);
                                } else {
                                        location.href = "/";
                                }
                        });
                }
        }
        </script>
	<!-- QR code -->
	<script>
        var qrcode = new QRCode("qrcode", {
            text: "${link.shortUrl}",
            colorDark : "#000000",
            colorLight : "#ffffff",
            height : 180,
            width : 180,
            correctLevel : QRCode.CorrectLevel.H,
        });
        </script>

	<!-- Gr�fico -->
	<script>
	new Chartist.Line('.ct-chart-clicks', {
		labels: ['6 dias atr�s','5 dias atr�s','4 dias atr�s','3 dias atr�s','2 dias atr�s','Ontem','Hoje'],
		series: [{
			name: 'clicks',
			data: ${linkDAO.getClicksChartData(link)}
		}
		]
	}, {
	  low: 0,
	  series: {
      	'clicks': {
      		lineSmooth: Chartist.Interpolation.simple()
      	}
	  }
	});
	
	new Chartist.Bar('.ct-chart-browsers', {
		labels: ${Browser.getBrowsersNames()},
		series: [${linkDAO.getBrowsersChartData(link)}]
		}
	);
    </script>
</t:narrow_layout>