<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>Mostrar Grupos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="grupos" method="post">
			<p class="title">
				<b>Mostrar Grupos</b>
			</p>
			<table>
					<tr>
						<th><input type="submit" id="botao" 
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
	<div align="center" class="grupoA">
		<table>
			<thead>
				<tr>
					<th><b>Nome</b></th>
					<th><b>Grupo</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${grupoA }" var="ga">
					<tr>
						<td><c:out value="${ga.times }"></c:out></td>
						<td><c:out value="${ga.grupos }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br />
	<br />
	<div align="center" class="grupoB">
		<table>
			<thead>
				<tr>
					<th><b>Nome</b></th>
					<th><b>Grupo</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${grupoB }" var="gb">
					<tr>
						<td><c:out value="${gb.times }"></c:out></td>
						<td><c:out value="${gb.grupos }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br />
	<br />
	<div align="center" class="grupoC">
		<table>
			<thead>
				<tr>
					<th><b>Nome</b></th>
					<th><b>Grupo</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${grupoC }" var="gc">
					<tr>
						<td><c:out value="${gc.times }"></c:out></td>
						<td><c:out value="${gc.grupos }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br />
	<br />
	<div align="center" class="grupoD">
		<table>
			<thead>
				<tr>
					<th><b>Nome</b></th>
					<th><b>Grupo</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${grupoD }" var="gd">
					<tr>
						<td><c:out value="${gd.times }"></c:out></td>
						<td><c:out value="${gd.grupos }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>