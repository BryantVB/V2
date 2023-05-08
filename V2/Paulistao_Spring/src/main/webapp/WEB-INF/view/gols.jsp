<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/teste.css" />'>
<title>Marcar Gols</title>
</head>
<body>
	<div>
         <jsp:include page="menu.jsp"></jsp:include>
     </div>
     <br />
     <br />
     <div align="center" class="container">
          <form action="gols" method="post">
               <table>
                 <tr>
                 <td><select id="timeA" name="timeA">
                            <option value="0">Time 1</option>
                            <c:if test="${not empty times }">
                                <c:forEach items="${times }" var="ta">
                                          <option><c:out value="${ta.nome }"></c:out></option>
                                </c:forEach>
                            </c:if>           
                     </select>
                 </td> 
                          
                 <td><select id="timeB" name="timeB">
                            <option value="0">Time 2</option>
                            <c:if test="${not empty times }">
                                <c:forEach items="${times }" var="tb">
                                          <option><c:out value="${tb.nome }"></c:out></option>
                                </c:forEach>
                            </c:if>           
                     </select>
                 </td>                 
                 <td><input type="date" id="data_jogo" name="data_jogo"><td>
                 <td><input type="submit" id="botao" name="botao" value="Atualizar"><td>
                 </tr>
                 
                 <tr>
                 <td><input type="number" step="1" min="0" id="golsA" name="golsA" placeholder="Gols Time A"></td>
                 <td><input type="number" step="1" min="0" id="golsB" name="golsB" placeholder="Gols Time B"></td>
                 </tr>
               </table>
          </form>
     </div>
     <br />
     <br />
	  <div align="center">
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
</body>
</html>