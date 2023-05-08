<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>Times que irão participar</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="times" method="post">
			<p class="title">
				<b>Times</b>
			</p>
			<table>
					<tr>
						<th colspan="4"><input type="submit" id="botao" 
						name="botao" value="Listar"></th>
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
					<th><b>Cidade</b></th>
					<th><b>Estadio</b></th>
					<th><b>Material</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${times }" var="t">
					<tr>
						<td><c:out value="${t.nome }"></c:out></td>
						<td><c:out value="${t.cidade }"></c:out></td>
						<td><c:out value="${t.estadio }"></c:out></td>
						<td><c:out value="${t.material }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>