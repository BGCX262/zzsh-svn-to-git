<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%
	response.setContentType("application/msword;charset=UTF-8");
	String title = ((request.getParameter("title") != null) || (request.getParameter("title") != "")) ? request.getParameter("title") : "word";
	//title = URLDecoder.decode(title, "utf-8");
	response.setHeader("Content-disposition", "attachment; filename="+ title + ".docx");
	String filename = "";
	if (request.getParameter("filename") != null) {
		filename = request.getParameter("filename");
	}
	
	String realpath = getServletContext().getRealPath("tmp/" + filename);
	File file = new File(realpath);
	
	BufferedInputStream bis = null;
	BufferedOutputStream bos = null;
	OutputStream o = response.getOutputStream();
	try {

		bis = new BufferedInputStream(new FileInputStream(file));
		bos = new BufferedOutputStream(o);


		
		byte[] buff = new byte[2048];
		int bytesRead;

		while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
			bos.write(buff, 0, bytesRead);
		}
		
		bos.flush();

        out.clear();
        out = pageContext.pushBody();

		
	} catch (final IOException e) {
		System.out.println("IOException." + e);
	} catch (IllegalStateException ee) {
		System.out.println("IllegalStateException." + ee);
	} finally {
		if (bis != null)
			bis.close();
		if (bos != null)
			bos.close();
		file.deleteOnExit();
		file.delete();
	}
%>