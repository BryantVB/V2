<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>Procurar jogo</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="dataJogo" method="post">
			<p class="title">
				<b>Procurar Jogos</b>
			</p>
			<table>
					<tr>
						<th><input type="date" id="data" 
						name="data"></th>
					</tr>
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
				<c:forEach items="${jogos }" var="jf">
					<tr>
						<td><c:out value="${jf.timeA }"></c:out></td>
						<td><c:out value="${jf.timeB }"></c:out></td>
						<td><c:out value="${jf.dta }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	
</body>
</html>