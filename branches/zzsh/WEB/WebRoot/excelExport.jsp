<%@ page contentType="text/html; charset=GBK" %>
<% response.setContentType("application/msexcel;charset=UTF-8"); %>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head><title>Test</title></head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String title = ( (request.getParameter("title")!=null) || (request.getParameter("title")!="") )?request.getParameter("title"):"excel" ;
response.setHeader("Content-disposition","attachment; filename="+title+".xls");
String str = request.getParameter("htmltable");
out.print(str);
%>
</body>
</HTML>