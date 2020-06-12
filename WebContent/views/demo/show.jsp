<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/views/common/common-libs.jsp" />
<head>
<title>Spring MVC Demo</title>
</head>

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
	<div class="navbar-header">
		<a class="navbar-brand" href="#">Spring MVC Demo</a>
	</div>
  </div>
</nav>

<div class="jumbotron">
  <div class="container">
	<h1>${demo.title}</h1>
	<p>
		<c:if test="${not empty demo.name}">
			Hello <font color='red'>${demo.name}</font>
		</c:if>

		<c:if test="${empty demo.name}">
			Welcome Welcome!
		</c:if>
    </p>
    <p>
	<a class="btn btn-primary btn-lg" href="./demo/show" role="button">Home</a>
    </p>
  </div>
</div>

<div class="container">

  <div class="row">
	<div class="col-md-4">
		<h2>Heading</h2>
		<p>Totoro</p>
		<p>
		<a class="btn btn-default" href="./demo/show/Totoro" role="button">View details</a>
		</p>
	</div>
	<div class="col-md-4">
		<h2>Heading</h2>
		<p>Tome James</p>
		<p>
		<a class="btn btn-default" href="./demo/show/Tome James" role="button">View details</a>
		</p>
	</div>
	<div class="col-md-4">
		<h2>Heading</h2>
		<p>John Mohanmode</p>
		<p>
		<a class="btn btn-default" href="./demo/show/John Mohanmode" role="button">View details</a>
		</p>
	</div>
  </div>

  <hr>
  <footer>
	<p></p>
  </footer>
</div>
</body>
</html>