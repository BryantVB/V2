<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>Consulta Grupo</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="consultaGrupo" method="post">
			<p class="title">
				<b>Consulta Grupo</b>
			</p>
			<table>
					<tr>
						<th><input type="text" id="grupo" 
						name="grupo" placeholder="Nome do Grupo"></th>
						
						<th><input type="submit" id="botao" 
						name="botao" value="Pesquisar"></th>
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
	<div align="center">
		<table>
			<thead>
				<tr>
					<th><b>Time</b></th>
					<th><b>numJogos</b></th>
					<th><b>Vitórias</b></th>
					<th><b>Empates</b></th>
					<th><b>Derrotas</b></th>
					<th><b>Gols_Marcados</b></th>
					<th><b>Gols_Sofridos</b></th>
					<th><b>Saldo_Gols</b></th>
					<th><b>Pontos</b></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogosInf }" var="jf">
					<tr>
						<td><c:out value="${jf.time }"></c:out></td>
						<td><c:out value="${jf.numJogos }"></c:out></td>
						<td><c:out value="${jf.vitorias }"></c:out></td>
						<td><c:out value="${jf.empates }"></c:out></td>
						<td><c:out value="${jf.derrotas }"></c:out></td>
						<td><c:out value="${jf.gols_Marcados }"></c:out></td>
						<td><c:out value="${jf.gols_Sofridos }"></c:out></td>
						<td><c:out value="${jf.saldo_Gols }"></c:out></td>
						<td><c:out value="${jf.pontos }"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>