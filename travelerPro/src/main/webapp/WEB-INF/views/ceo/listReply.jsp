<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class='table table-borderless reply-list'>
		<tr class='list-header'>
			<td width='50%'>
				<span class='bold'>답변내용</span>
			</td>
			<td width='50%' align='right'>
				<span>${dto.reg_date}</span>
			</td>
		</tr>
		<tr>
			<td colspan='2' valign='top'>${dto.content}</td>
		</tr>
</table>