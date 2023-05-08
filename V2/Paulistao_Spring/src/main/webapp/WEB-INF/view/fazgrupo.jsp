<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>FORMAR GRUPOS</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="fazgrupo" method="post">
			<p class="title">
				<b>Gerar Grupos</b>
			</p>
			<table>
					<tr>
						<th colspan="2"><input type="submit" id="botao" 
						name="botao" value="Gerar"></th>
					</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro } ">
			<H2><c:out value="${erro }"  /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida } ">
			<H3><c:out value="${saida }"  /></H3>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center" class="container">
		<table>
			<thead>
				<tr>
					<th><b>Nome</b></th>
					<th><b>Grupo</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${grupos }" var="g">
					<tr>
						<td><c:out value="${g.times }"></c:out></td>
						<td><c:out value="${g.grupos }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>