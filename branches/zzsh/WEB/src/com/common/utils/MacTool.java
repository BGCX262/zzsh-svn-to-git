/**
 * 
 */
package com.common.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.text.ParseException;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

/**
 * @author Administrator
 *
 */
public class MacTool {
	private boolean bVista=false;
	public String getMacAddress()
	{
	String mac = "";
	String os = System.getProperty("os.name");
	//System.out.println("--->"+os);
	try
		{
		if(os.startsWith("Windows"))
			{
			if(os.startsWith("Windows Vista")||os.startsWith("Windows 2008"))
				bVista=true;
			mac = windowsParseMacAddress(windowsRunIpConfigCommand());
			}
		else if(os.startsWith("Linux"))
			{
			mac = linuxParseMacAddress(linuxRunIfConfigCommand());
			}
		else if(os.startsWith("Mac OS X"))
			{
			mac = osxParseMacAddress(osxRunIfConfigCommand());
			}
		else if(os.startsWith("AIX"))
		{
			mac=aixParseNetstatMax(aiXRunIfConfigCommand());
		}
		//HP-UX
		else if(os.startsWith("HP-UX"))
		{
			mac=hpUxParseNetstatMax(hpUxRunIfConfigCommand());
		}
		}
	catch(Exception ex)
		{
		ex.printStackTrace();
		}
	return mac.replaceAll("-",":");
	}
	
	public static void main(String[] args) {

		try
		{
		FileInputStream in=new FileInputStream("E:\\ipconfig.txt");
		InputStream stdoutStream = new BufferedInputStream(in);

		StringBuffer buffer= new StringBuffer();
		for (;;)
			{
			int c = stdoutStream.read();
			if (c == -1) break;
			buffer.append((char)c);
			}
		String outputText = buffer.toString();
		outputText=new String(outputText.getBytes("ISO-8859-1"),"GBK");
		stdoutStream.close();
		MacTool mac=new MacTool();
		String macstr = mac.linuxParseMacAddress(outputText); //mac.windowsParseMacAddress(outputText);//  mac.aixParseNetstatMax(outputText);
		
		//System.out.println("--->"+macstr);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
	}
/*
 * Linux stuff
 */
private String linuxParseMacAddress(String ipConfigResponse) throws ParseException
	{
	String localHost = null;
	try 
		{
		localHost = InetAddress.getLocalHost().getHostAddress();
		}
	catch(java.net.UnknownHostException ex)
		{
		ex.printStackTrace();
		throw new ParseException(ex.getMessage(), 0);
		}
	StringTokenizer tokenizer = new StringTokenizer(ipConfigResponse, "\n");
	String lastMacAddress = null;

	while(tokenizer.hasMoreTokens())
		{
		String line = tokenizer.nextToken().trim();
		boolean containsLocalHost = line.indexOf(localHost) >= 0;
		// see if line contains IP address
		if(containsLocalHost && lastMacAddress != null)
			{
			return lastMacAddress;
			}

		// see if line contains MAC address
		int macAddressPosition = line.indexOf("HWaddr");
		if(macAddressPosition <= 0) continue;

		String macAddressCandidate = line.substring(macAddressPosition + 6).trim();
		if(linuxIsMacAddress(macAddressCandidate))
			{
			lastMacAddress = macAddressCandidate;
			continue;
			}
		}

	ParseException ex = new ParseException("cannot read MAC address for " + localHost + " from [" + ipConfigResponse + "]", 0);
	ex.printStackTrace();
	throw ex;
	}


private boolean linuxIsMacAddress(String macAddressCandidate)
	{
	Pattern macPattern = Pattern.compile("[0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0 -9a-fA-F]{2}[-:][0-9a-fA-F]{2}");
	Matcher m = macPattern.matcher(macAddressCandidate);
	return m.matches();
	}


private String linuxRunIfConfigCommand() throws IOException
	{
	Process p = Runtime.getRuntime().exec("ifconfig");
	InputStream stdoutStream = new BufferedInputStream(p.getInputStream());

	StringBuffer buffer= new StringBuffer();
	for (;;)
		{
		int c = stdoutStream.read();
		if (c == -1) break;
		buffer.append((char)c);
		}
	String outputText = buffer.toString();
	stdoutStream.close();
	return outputText;
	}

/*
 * Windows stuff
 */
private String windowsParseMacAddress(String ipConfigResponse) throws ParseException
	{
	String localHost = null;
	try
		{
		localHost = InetAddress.getLocalHost().getHostAddress();
		//if(bVista)
		//	localHost=localHost+"(��ѡ)";
		}
	catch(java.net.UnknownHostException ex)
		{
		ex.printStackTrace();
		throw new ParseException(ex.getMessage(), 0);
		}

	StringTokenizer tokenizer = new StringTokenizer(ipConfigResponse, "\n");
	String lastMacAddress = null;

	while(tokenizer.hasMoreTokens())
		{
		String line = tokenizer.nextToken().trim();
		
		// see if line contains IP address
		if((line.endsWith(localHost)||line.endsWith(localHost+"(��ѡ)")) && lastMacAddress != null)
			{
			return lastMacAddress;
			}

		// see if line contains MAC address
		int macAddressPosition = line.indexOf(":");
		if(macAddressPosition <= 0) continue;

		String macAddressCandidate = line.substring(macAddressPosition + 1).trim();
		if(windowsIsMacAddress(macAddressCandidate))
			{
			lastMacAddress = macAddressCandidate;
			continue;
			}
		}
	ParseException ex = new ParseException("cannot read MAC address from [" + ipConfigResponse + "]", 0);
	ex.printStackTrace();
	throw ex;
	}


private boolean windowsIsMacAddress(String macAddressCandidate)
	{
	Pattern macPattern = Pattern.compile("[0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0 -9a-fA-F]{2}[-:][0-9a-fA-F]{2}");
	Matcher m = macPattern.matcher(macAddressCandidate);
	return m.matches();
	}

private String windowsRunIpConfigCommand() throws IOException
	{
	Process p = Runtime.getRuntime().exec("ipconfig /all");
	InputStream stdoutStream = new BufferedInputStream(p.getInputStream());

	StringBuffer buffer= new StringBuffer();
	for (;;)
		{
		int c = stdoutStream.read();
		if (c == -1) break;
		buffer.append((char)c);
		}
	String outputText = buffer.toString();
	outputText=new String(outputText.getBytes("ISO-8859-1"),"GBK");
	stdoutStream.close();
	return outputText;
	}

/*
 * Mac OS X Stuff
 */
 private String osxParseMacAddress(String ipConfigResponse) throws ParseException
 	{
	String localHost = null;

	try
		{
		localHost = InetAddress.getLocalHost().getHostAddress();
		}
	catch(java.net.UnknownHostException ex)
		{
		ex.printStackTrace();
		throw new ParseException(ex.getMessage(), 0);
		}
	StringTokenizer tokenizer = new StringTokenizer(ipConfigResponse, "\n");
	while(tokenizer.hasMoreTokens())
		{
		String line = tokenizer.nextToken().trim();
		// see if line contains MAC address
		int macAddressPosition = line.indexOf("ether");
		if(macAddressPosition != 0) continue;
		String macAddressCandidate = line.substring(macAddressPosition + 6).trim();
		if(osxIsMacAddress(macAddressCandidate))
			{
			return macAddressCandidate;
			}
		}

	ParseException ex = new ParseException("cannot read MAC address for " + localHost + " from [" + ipConfigResponse + "]", 0);
	ex.printStackTrace();
	throw ex;
 	}

private boolean osxIsMacAddress(String macAddressCandidate)
	{
	Pattern macPattern = Pattern.compile("[0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0-9a-fA-F]{2}[-:][0 -9a-fA-F]{2}[-:][0-9a-fA-F]{2}");
	Matcher m = macPattern.matcher(macAddressCandidate);
	return m.matches();
	}


private String osxRunIfConfigCommand() throws IOException
	{
	Process p = Runtime.getRuntime().exec("ifconfig");
	InputStream stdoutStream = new BufferedInputStream(p.getInputStream());
	StringBuffer buffer= new StringBuffer();
	for (;;)
		{
		int c = stdoutStream.read();
		if (c == -1) break;
		buffer.append((char)c);
		}
	String outputText = buffer.toString();
	stdoutStream.close();
	return outputText;
	}
/**
 * �����ַ�ȡ�ö�Ӧ�ĵ�ַ��
 * @param content
 * @return
 */
private String aixParseNetstatMax(String netConfigResponse)throws ParseException
{
	StringTokenizer tokenizer = new StringTokenizer(netConfigResponse, "\n");
	while(tokenizer.hasMoreTokens())
	{
		String line = tokenizer.nextToken().trim();
		// see if line contains MAC address
		int macAddressPosition = line.indexOf("en");
		if(macAddressPosition != 0) 
			continue;
		String[] conarr=StringUtils.split(line," ");
		String macaddr=conarr[3];
		String linkstr=conarr[2];
		if(linkstr.startsWith("link#"))
		{
			String[] arr=StringUtils.split(macaddr, ".");
			StringBuffer buf=new StringBuffer();
			for(int i=0;i<arr.length;i++)
			{
				String tmp=arr[i];
				if(tmp.length()==1)
				{
					tmp="0"+arr[i];
				}
				buf.append(tmp);
				buf.append("-");
			}
			buf.setLength(buf.length()-1);
			macaddr=buf.toString();
			return macaddr;
		}
	}
	
	ParseException ex = new ParseException("cannot read MAC address from [" + netConfigResponse + "]", 0);
	ex.printStackTrace();
	throw ex;
}
/**
 * aix
 * @return
 * @throws IOException
 */
private String aiXRunIfConfigCommand() throws IOException
{
Process p = Runtime.getRuntime().exec("netstat -in");
InputStream stdoutStream = new BufferedInputStream(p.getInputStream());
StringBuffer buffer= new StringBuffer();
for (;;)
	{
	int c = stdoutStream.read();
	if (c == -1) break;
	buffer.append((char)c);
	}
String outputText = buffer.toString();
stdoutStream.close();
return outputText;
}

private String hpUxRunIfConfigCommand() throws IOException
{
Process p = Runtime.getRuntime().exec("lanscan");
InputStream stdoutStream = new BufferedInputStream(p.getInputStream());
StringBuffer buffer= new StringBuffer();
for (;;)
	{
	int c = stdoutStream.read();
	if (c == -1) break;
	buffer.append((char)c);
	}
String outputText = buffer.toString();
stdoutStream.close();
return outputText;
}

private String hpUxParseNetstatMax(String netConfigResponse)throws ParseException
{
	StringTokenizer tokenizer = new StringTokenizer(netConfigResponse, "\n");
	while(tokenizer.hasMoreTokens())
	{
		String line = tokenizer.nextToken().trim();
		// see if line contains MAC address
		int macAddressPosition = line.indexOf("lan0");
		if(macAddressPosition ==-1) 
			continue;
		String[] conarr=StringUtils.split(line," ");
		String macaddr=conarr[1];
		if(macaddr.length()>2)
		{
			macaddr=macaddr.substring(2);
		}
		macaddr=macaddr.substring(0, 2)+"-"+macaddr.substring(2, 4)+"-"+macaddr.substring(4, 6)+"-"+macaddr.substring(6, 8)+"-"+
				macaddr.substring(8,10)+"-"+macaddr.substring(10);

		return macaddr;
	}
	
	ParseException ex = new ParseException("cannot read MAC address from [" + netConfigResponse + "]", 0);
	ex.printStackTrace();
	throw ex;
}
}


