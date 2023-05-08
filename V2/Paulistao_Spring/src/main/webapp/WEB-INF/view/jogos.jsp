<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>Gerar Jogos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="jogos" method="post">
			<p class="title">
				<b>Gerar Jogos</b>
			</p>
			<table>
					<tr>
						<th><input type="submit" id="botao" 
						name="botao" value="Criar"></th>
						
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
	
	
	<div align="center" class="container">
		<table>
			<thead>
				<tr>
					<th><b>Time1</b></th>
					<th><b>Time2</b></th>
					<th><b>Data</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogos }" var="jo">
					<tr>
						<td><c:out value="${jo.timeA }"></c:out></td>
						<td><c:out value="${jo.timeB }"></c:out></td>
						<td><c:out value="${jo.dta }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	
</body>
</html>