<%@ page contentType="text/html; charset=utf-8" language="java"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统参数设置--基层党支部组织生活管理系统安装向导</title>
<link href="img/style.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript">
	function formSubmit() {

		if (document.getElementById('dbHost').value == '') {
			alert("您没有填写数据库主机!");
			return false;
		}	

		if (document.getElementById('dbName').value == '') {
			alert("您没有填写数据库名称!");
			return false;
		}			

		if (document.getElementById('dbUser').value == '') {
			alert("您没有填写数据库用户!");
			return false;
		}			
		

		if (document.getElementById('dbPassword').value == '') {
			if (!confirm("您没有填写数据库密码，您确定数据库密码为空吗？")) {
				return false;
			}
		}

		if (document.getElementById('adminUser').value == '') {
			alert("您没有填写管理员用户!");
			return false;
		}	

		if (document.getElementById('adminPassword').value == '') {
			alert("您没有填写管理员密码!");
			return false;
		}					
		
		if (document.getElementById('adminName').value == '') {
			alert("您没有填写组织名称!");
			return false;
		}				
		
		document.getElementById('beforeSubmit').style.display = "none";
		document.getElementById('afterSubmit').style.display = "";
	}
</script>
</head>

<body>
<div class="regist-header box">
  <div class="rgheader box">
         <div class="brand fl">
            <h1 style="margin:0px;"><a href="${base}/"> ${site.name}</a></h1>
         </div>
     </div>
</div>
<form action="install_setup.svl" method="post"
	onsubmit="return formSubmit();">
	
	<div class="main">
  <table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="rg-tbg">
    <tr>
      <td height="76" align="center"><h2>2、系统参数设置（环境要求：jdk1.5或以上、tomcat5.5或以上、mysql5.0或以上）</h2>
	  <span style="color:#016dd0;">设置系统相关参数</span></td>
    </tr>
    <tr>
      <td>
	  <table width="600" border="0" align="center" cellpadding="0" cellspacing="0"
	>
	
	<tr>
		<td align="center" valign="top">
		  <table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0" style="border:1px solid #b5b5b5;">
			<tr>
				<td width="30%" height="30" align="right">数据库主机：</td>
				<td width="22%" align="left"><input name="dbHost" type="text"
					class="input" id="dbHost" value="127.0.0.1" /></td>
				<td align="left">数据库的ip地址，如果是本机无需改动</td>
			</tr>
			<tr>
				<td width="30%" height="30" align="right">数据库端口号：</td>
				<td width="22%" align="left"><input name="dbPort" type="text"
					class="input" id="dbPort" value="3306" /></td>
				<td align="left">数据库的端口号，一般无需改动</td>
			</tr>
			<tr>
				<td height="30" align="right">数据库名称：</td>
				<td align="left"><input name="dbName" type="text" class="input"
					id="dbName" value="partycommittee" /></td>
				<td align="left">注意:重新安装将会清除数据库数据.</td>
			</tr>
			<tr>
				<td height="30" align="right">数据库用户：</td>
				<td align="left"><input name="dbUser" type="text" class="input"
					id="dbUser" value="root" /></td>
				<td align="left">&nbsp;</td>
			</tr>
			<tr>
				<td height="30" align="right">数据库密码：</td>
				<td align="left"><input name="dbPassword" type="text"
					class="input" id="dbPassword" /></td>
				<td align="left">安装数据库时输入的密码</td>
			</tr>
			<tr>
				<td height="30" align="right">是否安装演示数据：</td>
				<td align="left"><input type="radio" name="isSampleData"
					value="true"  />是 <input type="radio"
					name="isSampleData" value="false"  checked="checked"/>否</td>
				<td align="left"></td>
			</tr>
		</table>	  
		</td>
	</tr>
	
    <tr>
      <td height="76" align="center"><h2>初始化数据</h2>
	  <span style="color:#016dd0;"></span></td>
    </tr>	
	
	<tr>
		<td align="center" valign="top">
		  <table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0" style="border:1px solid #b5b5b5;">
			<tr>
				<td width="30%" height="30" align="right">管理员用户名：</td>
				<td width="22%" align="left"><input name="adminUser" type="text"
					class="input" id="adminUser" value="admin" /></td>
				<td align="left">只能用'0-9'、'a-z'、'A-Z'、'.'、'@'、'_'、'-'、'!'以内范围的字符</td>
			</tr>
			<tr>
				<td width="30%" height="30" align="right">管理员密码：</td>
				<td width="22%" align="left"><input name="adminPassword" type="text"
					class="input" id="adminPassword" value="admin" /></td>
				<td align="left"></td>
			</tr>
			<tr>
				<td height="30" align="right">组织名称：</td>
				<td align="left"><input name="adminName" type="text" class="input"
					id="adminName" value="" /></td>
				<td align="left">作为组织管理根节点.例如:北京市公安局</td>
			</tr>
		</table>	  
		</td>
	</tr>	
	
	<tr>
		<td height="30" align="center"><span
			id="beforeSubmit">
		  <input type="submit" class="regist-submit"
			value=" 提 交 " />
</span> <span id="afterSubmit"
			style="display: none; color: red;">安装需要十几秒的时间，请您耐心等待...</span></td>
	</tr>
</table>
	  </td>
    </tr>
  </table>
</div>

<input type="hidden" name="dbFileName"	value="/install/db/zzsh.sql" />
<input type="hidden" name="dbProcFileName"	value="/install/db/procedure_stat.sql" />  
<input type="hidden" name="sampleFileName" value="/install/db/sample_data.sql" />
</form>
</body>
</html>
