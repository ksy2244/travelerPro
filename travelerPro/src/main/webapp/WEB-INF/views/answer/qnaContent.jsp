<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class='table table-borderless'>
	<tr>
		<td width="100%">
			<div class='answer'>A</div>
			<div class='content'>${dto.content}</div>
			<div class='date margin'>${dto.reg_date}</div>	
		</td>
</table>