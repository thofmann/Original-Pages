<%
'REMOTE_ADDR server variable is not viable under cloudflare proxy, Request.ServerVariables("HTTP_CF_CONNECTING_IP") is used instead unless software is added to restore the REMOTE_ADDR.
'
If Request.ServerVariables("HTTP_CF_CONNECTING_IP") <> "63.148.2.42" Then
	Response.Write("Page Not Found")
Else
If Request.Form("Submit") = "Submit" Then
	dim conn, strMail, SQL, ConStr, content, myMail
	'scrub variable to prevent SQL injection attack.
	strMail = replace(Request.Form("emailaddress"), "'", "''")
	ConStr = "Provider=SQLOLEDB.1;Data Source=PACER2; Initial Catalog=PACER_WEB;Network=DBMSSOCN; User Id=pacer;Password=dataAccess"
	set conn = server.createobject("adodb.connection")
	SQL="DELETE FROM bullyNewsletter WHERE emailaddress = '" & strMail &"';"
	conn.open(ConStr)
	conn.execute SQL
	
	SQL="UPDATE bullyPetition SET contactbyEmail = 'no' WHERE email = '" & strMail & "';"
	conn.execute SQL
	
	conn.close
	set conn = nothing
	
End If
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="robots" content="noindex,nofollow" />

<title>National Bullying Prevention Center Newsletter Unsubscribe</title>
<link rel="icon" href="http://www.pacer.org/bullying/favicon.ico" />
<link href="/bullying/css/bullying.css" rel="stylesheet" type="text/css" />

</head>

<body>

<div class="container">
<a id="skiptocontent" href="#maincontent">Skip to main content</a>


<!--#include virtual="/bullying/dynamic-header.html"-->
<!--#include virtual="/bullying/topnav.html"-->
  <script type="text/javascript">
	var navId="none";
	if (document.getElementById(navId)){
		document.getElementById(navId).className = document.getElementById(navId).className+" active";
	}
</script>
  <div class="breadcrumb"> <a href="/bullying/">Home</a> / <a href="/bullying/newsletter/">Bullying Prevention E-News</a> /</div>

  <div class="content">
    <h1 id="maincontent">Admin - Opt Out - National Bullying Prevention Center Newsletter</h1>
<%
Dim showForm
showForm = true
If Request.Form("Submit") = "Submit" Then%>
<p><strong><%=strMail%>
</strong> has been deleted from the Bullying Prevention Mail List.</p>
<%End If%>

<%If showForm Then%>
<form name="unsubscribe" action="opt-out.asp" method="post">
<table cellspacing="10">
<tr><td colspan="2" align="center"><h3>Unsubscribe</h3></td></tr>
<tr><td align="right">
<label for="emailaddress">Email Address</label></td><td><input type="text" name="emailaddress" size="50" /></td></tr>
<tr><td>&nbsp;</td><td align="right"><input type="submit" name="Submit" value="Submit" /></td></tr></table>
</form>
<%End If%>

  <!-- end .content --></div>
<!--#include virtual="/bullying/footer.html"-->
  <!-- end .container --></div>
</body>
</html>
<%
End If
%>
