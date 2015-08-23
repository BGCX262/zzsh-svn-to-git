package com.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.common.utils.MacTool;

/**
 * @author lzy
 */
public class Des {
	private ArrayList ar = new ArrayList();

	private final byte[][] subKey = new byte[16][6];

	final byte dmEncry = 0;

	final byte dmDecry = 1;

	// 初始值置IP
	final byte[] BitIP = { 57, 49, 41, 33, 25, 17, 9, 1, 59, 51, 43, 35, 27,
			19, 11, 3, 61, 53, 45, 37, 29, 21, 13, 5, 63, 55, 47, 39, 31, 23,
			15, 7, 56, 48, 40, 32, 24, 16, 8, 0, 58, 50, 42, 34, 26, 18, 10, 2,
			60, 52, 44, 36, 28, 20, 12, 4, 62, 54, 46, 38, 30, 22, 14, 6 };

	// 逆初始置IP-1
	final byte[] BitCP = { 39, 7, 47, 15, 55, 23, 63, 31, 38, 6, 46, 14, 54,
			22, 62, 30, 37, 5, 45, 13, 53, 21, 61, 29, 36, 4, 44, 12, 52, 20,
			60, 28, 35, 3, 43, 11, 51, 19, 59, 27, 34, 2, 42, 10, 50, 18, 58,
			26, 33, 1, 41, 9, 49, 17, 57, 25, 32, 0, 40, 8, 48, 16, 56, 24 };

	// 位选择函数E
	final byte[] BitExp = { 31, 0, 1, 2, 3, 4, 3, 4, 5, 6, 7, 8, 7, 8, 9, 10,
			11, 12, 11, 12, 13, 14, 15, 16, 15, 16, 17, 18, 19, 20, 19, 20, 21,
			22, 23, 24, 23, 24, 25, 26, 27, 28, 27, 28, 29, 30, 31, 0 };

	// 置换函数P
	final byte[] BitPM = { 15, 6, 19, 20, 28, 11, 27, 16, 0, 14, 22, 25, 4, 17,
			30, 9, 1, 7, 23, 13, 31, 26, 2, 8, 18, 12, 29, 5, 21, 10, 3, 24 };

	// S盒
	final byte[][] sBox = {
			{ 14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7, 0, 15, 7,
					4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8, 4, 1, 14, 8,
					13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0, 15, 12, 8, 2, 4,
					9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13 },
			{ 15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10, 3, 13, 4,
					7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5, 0, 14, 7, 11,
					10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15, 13, 8, 10, 1, 3,
					15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9 },
			{ 10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8, 13, 7, 0,
					9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1, 13, 6, 4, 9, 8,
					15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7, 1, 10, 13, 0, 6, 9,
					8, 7, 4, 15, 14, 3, 11, 5, 2, 12 },
			{ 7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15, 13, 8, 11,
					5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9, 10, 6, 9, 0, 12,
					11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4, 3, 15, 0, 6, 10, 1,
					13, 8, 9, 4, 5, 11, 12, 7, 2, 14 },
			{ 2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9, 14, 11, 2,
					12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6, 4, 2, 1, 11, 10,
					13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14, 11, 8, 12, 7, 1, 14,
					2, 13, 6, 15, 0, 9, 10, 4, 5, 3 },
			{ 12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11, 10, 15, 4,
					2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8, 9, 14, 15, 5, 2,
					8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6, 4, 3, 2, 12, 9, 5, 15,
					10, 11, 14, 1, 7, 6, 0, 8, 13 },
			{ 4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1, 13, 0, 11,
					7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6, 1, 4, 11, 13,
					12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2, 6, 11, 13, 8, 1, 4,
					10, 7, 9, 5, 0, 15, 14, 2, 3, 12 },
			{ 13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7, 1, 15, 13,
					8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2, 7, 11, 4, 1, 9,
					12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8, 2, 1, 14, 7, 4, 10,
					8, 13, 15, 12, 9, 0, 3, 5, 6, 11 } };

	// 选择置换PC-1
	final byte[] BitPMC1 = { 56, 48, 40, 32, 24, 16, 8, 0, 57, 49, 41, 33, 25,
			17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 62, 54,
			46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 60, 52, 44,
			36, 28, 20, 12, 4, 27, 19, 11, 3 };

	// 选择置换PC-2
	final byte[] BitPMC2 = { 13, 16, 10, 23, 0, 4, 2, 27, 14, 5, 20, 9, 22, 18,
			11, 3, 25, 7, 15, 6, 26, 19, 12, 1, 40, 51, 30, 36, 46, 54, 29, 39,
			50, 44, 32, 47, 43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31 };

	private void initPermutation(byte[] inData) {
		byte[] newData = { 0, 0, 0, 0, 0, 0, 0, 0 };
		int i = 0;
		for (i = 0; i <= 63; i++)
			if ((inData[mend(BitIP[i]) >>> 3] & (1 << (7 - (BitIP[i] & 0x07)))) != 0) {
				newData[i >> 3] = (byte) (newData[i >> 3] | (1 << (7 - (i & 0x07))));
			}
		for (i = 0; i <= 7; i++)
			inData[i] = newData[i];

	}

	private void permutation(byte[] inData) {
		byte[] newData = { 0, 0, 0, 0 };
		int i = 0;
		for (i = 0; i <= 31; i++)
			if ((inData[BitPM[i] >> 3] & (1 << (7 - (BitPM[i] & 0x07)))) != 0)
				newData[i >> 3] = (byte) (newData[i >> 3] | (1 << (7 - (i & 0x07))));
		for (i = 0; i <= 3; i++)
			inData[i] = newData[i];

	}

	private byte si(byte s, byte inByte) {
		byte c = 0;
		c = (byte) ((inByte & 0x20) | (mend((byte) (inByte & 0x1e)) >>> 1) | ((inByte & 0x01) << 4));
		return (byte) (sBox[s][c] & 0x0f);
	}

	private int mend(byte myByte) {
		int b = myByte;
		if (myByte < 0) {
			b = 256 + myByte;
		}
		return b;
	}

	private void permutationChoose1(byte[] inData, byte[] outData) {
		for (int i = 0; i <= 6; i++) {
			outData[i] = 0;
		}
		for (int i = 0; i <= 55; i++)
			if ((inData[BitPMC1[i] >> 3] & (1 << (7 - (BitPMC1[i] & 0x07)))) != 0) {
				outData[i >> 3] = (byte) (mend(outData[i >>> 3]) | (1 << (7 - (i & 0x07))));
			}

	}

	private void conversePermutation(byte[] inData) {
		byte[] newData = { 0, 0, 0, 0, 0, 0, 0, 0 };
		int i = 0;
		for (i = 0; i <= 63; i++)
			if ((inData[BitCP[i] >> 3] & (1 << (7 - (BitCP[i] & 0x07)))) != 0)
				newData[i >> 3] = (byte) (mend(newData[i >> 3]) | (1 << (7 - (i & 0x07))));
		for (i = 0; i <= 7; i++)
			inData[i] = newData[i];

	}

	private void permutationChoose2(byte[] inData, byte[] outData) {
		for (int i = 0; i < 6; i++) {
			outData[i] = 0;
		}
		for (int i = 0; i <= 47; i++)
			if ((inData[BitPMC2[i] >> 3] & (1 << (7 - (BitPMC2[i] & 0x07)))) != 0)
				outData[i >> 3] = (byte) (mend(outData[i >> 3]) | (1 << (7 - (i & 0x07))));
	}

	private void cycleMove(byte[] inData, byte bitMove) {
		for (int i = 0; i <= bitMove - 1; i++) {
			inData[0] = (byte) ((inData[0] << 1) | (mend(inData[1]) >>> 7));
			inData[1] = (byte) ((inData[1] << 1) | (mend(inData[2]) >>> 7));
			inData[2] = (byte) ((inData[2] << 1) | (mend(inData[3]) >>> 7));
			inData[3] = (byte) ((inData[3] << 1) | (mend((byte) (inData[0] & 0x10)) >>> 4));
			inData[0] = (byte) ((inData[0] & 0x0f));
		}
	}

	private void expand(byte[] inData, byte[] outData) {
		int i = 0;
		for (i = 0; i <= 5; i++) {
			outData[i] = 0;
		}
		for (i = 0; i <= 47; i++)
			if ((inData[BitExp[i] >> 3] & (1 << (7 - (BitExp[i] & 0x07)))) != 0)
				outData[i >> 3] = (byte) (mend(outData[i >> 3]) | (1 << (7 - (i & 0x07))));
	}

	private void makeKey(byte[] inkey, byte[][] outKey) {
		final byte[] bitDisplace = { 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2,
				2, 1 };
		byte[] outData56 = new byte[7];
		byte[] key28l = new byte[4];
		byte[] key28r = new byte[4];
		byte[] key56o = new byte[7];
		int i = 0;
		permutationChoose1(inkey, outData56);
		key28l[0] = (byte) (outData56[0] >> 4);

		key28l[1] = (byte) ((outData56[0] << 4) | (mend(outData56[1]) >>> 4));

		key28l[2] = (byte) ((outData56[1] << 4) | (mend(outData56[2]) >>> 4));

		key28l[3] = (byte) ((outData56[2] << 4) | (mend(outData56[3]) >>> 4));

		key28r[0] = (byte) (outData56[3] & 0x0f);

		key28r[1] = outData56[4];
		key28r[2] = outData56[5];
		key28r[3] = outData56[6];

		for (i = 0; i <= 15; i++) {
			cycleMove(key28l, bitDisplace[i]);
			cycleMove(key28r, bitDisplace[i]);
			key56o[0] = (byte) ((key28l[0] << 4) | (mend(key28l[1]) >>> 4));

			key56o[1] = (byte) ((key28l[1] << 4) | (mend(key28l[2]) >>> 4));

			key56o[2] = (byte) ((key28l[2] << 4) | (mend(key28l[3]) >>> 4));

			key56o[3] = (byte) ((key28l[3] << 4) | (key28r[0]));

			key56o[4] = key28r[1];

			key56o[5] = key28r[2];
			key56o[6] = key28r[3];
			permutationChoose2(key56o, outKey[i]);

		}
	}

	private void encry(byte[] inData, byte[] subKey, byte[] outData) {

		byte[] outBuf = new byte[6];
		byte[] buf = new byte[8];
		int i = 0;

		expand(inData, outBuf);
		for (i = 0; i <= 5; i++)
			outBuf[i] = (byte) (outBuf[i] ^ subKey[i]);
		buf[0] = (byte) (mend(outBuf[0]) >>> 2);
		buf[1] = (byte) (((outBuf[0] & 0x03) << 4) | (mend(outBuf[1]) >>> 4));
		buf[2] = (byte) (((outBuf[1] & 0x0f) << 2) | (mend(outBuf[2]) >>> 6));
		buf[3] = (byte) (outBuf[2] & 0x3f);
		buf[4] = (byte) (mend(outBuf[3]) >>> 2);
		buf[5] = (byte) (((outBuf[3] & 0x03) << 4) | (mend(outBuf[4]) >>> 4));
		buf[6] = (byte) (((outBuf[4] & 0x0f) << 2) | (mend(outBuf[5]) >>> 6));
		buf[7] = (byte) (outBuf[5] & 0x3f);
		for (i = 0; i <= 7; i++)
			buf[i] = si((byte) i, buf[i]);
		for (i = 0; i <= 3; i++)
			outBuf[i] = (byte) ((buf[i * 2] << 4) | buf[i * 2 + 1]);
		permutation(outBuf);
		for (i = 0; i <= 3; i++)
			outData[i] = outBuf[i];
	}

	private void desData(byte desMode, byte[] inData, byte[] outData) {
		int i = 0;
		int j = 0;
		byte[] temp = new byte[4];
		byte[] buf = new byte[4];
		for (i = 0; i <= 7; i++)
			outData[i] = inData[i];
		initPermutation(outData);
		if (desMode == dmEncry) {
			for (i = 0; i <= 15; i++) {
				for (j = 0; j <= 3; j++)
					temp[j] = outData[j];
				for (j = 0; j <= 3; j++)
					outData[j] = outData[j + 4]; // Ln+1 = Rn
				encry(outData, subKey[i], buf); // Rn
				for (j = 0; j <= 3; j++)
					outData[j + 4] = (byte) (temp[j] ^ buf[j]); // Rn+1 = Ln^buf
			}
			for (j = 0; j <= 3; j++)
				temp[j] = outData[j + 4];
			for (j = 0; j <= 3; j++)
				outData[j + 4] = outData[j];
			for (j = 0; j <= 3; j++)
				outData[j] = temp[j];
		} else if (desMode == dmDecry) {
			for (i = 15; i >= 0; i--) {
				for (j = 0; j <= 3; j++)
					temp[j] = outData[j];
				for (j = 0; j <= 3; j++)
					outData[j] = outData[j + 4];
				encry(outData, subKey[i], buf);
				for (j = 0; j <= 3; j++)
					outData[j + 4] = (byte) (temp[j] ^ buf[j]);
			}
			for (j = 0; j <= 3; j++)
				temp[j] = outData[j + 4];
			for (j = 0; j <= 3; j++)
				outData[j + 4] = outData[j];
			for (j = 0; j <= 3; j++)
				outData[j] = temp[j];
		}
		conversePermutation(outData);
	}

	/**
	 * 
	 * @param str
	 *            要加密的字符串
	 * @param key
	 *            密钥
	 * @param strByte
	 *            用来返回加密后的字节数组
	 * @return
	 * @throws Exception
	 */
	public byte[] EncryStr(String str, String key) throws Exception {
		byte[] StrByte = new byte[8];
		byte[] OutByte = new byte[8];
		byte[] KeyByte = new byte[8];
		ar.clear();
		String StrResult = "";
		int i = 0, j = 0;
		byte[] myByteArray = str.getBytes();
		if ((myByteArray.length > 0)
				&& ((byte) myByteArray[str.length() - 1] == 0))
			throw new Exception("Error: the last char is NULL char.");
		if (key.length() < 8)
			while (key.length() < 8) {
				key = key + (char) 0;
			}
		while (myByteArray.length % 8 != 0) {
			str = str + (char) 0;
			byte[] temp = new byte[myByteArray.length + 1];
			for (int k = 0; k < myByteArray.length; k++) {
				temp[k] = myByteArray[k];
			}
			temp[temp.length - 1] = 0;
			myByteArray = temp;
		}
		for (j = 0; j <= 7; j++)
			KeyByte[j] = (byte) key.charAt(j);
		makeKey(KeyByte, subKey);
		StrResult = "";
		for (i = 0; i <= (int) (myByteArray.length / 8) - 1; i++) {
			for (j = 0; j <= 7; j++)
				StrByte[j] = myByteArray[i * 8 + j];
			desData(dmEncry, StrByte, OutByte);
			for (j = 0; j <= 7; j++) {
				StrResult += (char) OutByte[j];
				ar.add(new Byte(OutByte[j]));
			}
		}
		byte[] mm = new byte[ar.size()];
		for (i = 0; i < mm.length; i++) {
			Byte b = (Byte) (ar.get(i));
			mm[i] = b.byteValue();
		}
		return mm;
	}
	/**
	 * 取得产品序列号
	 * @param flag=0 not  =1
	 * @return
	 */
	public String getProductSerialNo(int flag)
	{
		StringBuffer buf=new StringBuffer();
		MacTool mactool=new MacTool();
		String macaddr="";
		try
		{
			macaddr=mactool.getMacAddress();
			//System.out.println("--->="+macaddr);
			if(flag==1)
			{
				byte[]  macarr=EncryStr(macaddr,"ilovethisgame");
				BASE64Encoder encoder=null;
				encoder = new BASE64Encoder();
				macaddr = encoder.encode(macarr);	
			}
			buf.append(macaddr);
			//System.out.println("--->="+buf.toString());
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}		
		return buf.toString();
	}
	
	
	/**
	 * 口令加密
	 * @param str
	 * @return
	 */
	public String EncryPwdStr(String str)
	{
		if(str==null)
			str="";	
		String strpwd=str;
		try
		{
			byte[] pwd=EncryStr(str,"hjsj");
			BASE64Encoder encoder=null;
			encoder = new BASE64Encoder();
			strpwd = encoder.encode(pwd);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return strpwd;
	}
	
	public String EncryPwdStr(String str,String key)
	{
		if(str==null)
			str="";	
		String strpwd=str;
		try
		{
			byte[] pwd=EncryStr(str,key);
			BASE64Encoder encoder=null;
			encoder = new BASE64Encoder();
			strpwd = encoder.encode(pwd);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return strpwd;
	}	
	/**
	 * 口令脱密
	 * @param str
	 * @return
	 */
	public String DecryPwdStr(String str)
	{
		if(str==null)
			str="";		
		String strpwd=str;
		try
		{
		    BASE64Decoder decoder = new BASE64Decoder();
		    byte[] sourcearr =decoder.decodeBuffer(str);
		    strpwd=DecryStr(sourcearr,"hjsj");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return strpwd;
	}	
	
	public String DecryPwdStr(String str,String key)
	{
		if(str==null)
			str="";		
		String strpwd=str;
		try
		{
		    BASE64Decoder decoder = new BASE64Decoder();
		    byte[] sourcearr =decoder.decodeBuffer(str);
		    strpwd=DecryStr(sourcearr,key);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return strpwd;
	}		
	/**
	 * 解密
	 * @param srcStr
	 * @param key
	 * @return
	 */
	public String DecryStr(String srcStr, String key) {
		return DecryStr(srcStr.getBytes(),key);
	}
	
	public String DecryStr(byte[] Strbyte, String Key) {
		String Str = "";
		for (int i = 0; i < Str.length(); i++) {
			Str += "," + (byte) Str.charAt(i);
		}
		for (int i = 0; i < Strbyte.length; i++) {
			Str += (char) Strbyte[i];
		}
		ArrayList byteList = new ArrayList();
		byte[] StrByte = new byte[8];
		byte[] OutByte = new byte[8];
		byte[] keyByte = new byte[8];
		String StrResult = "";
		int i = 0, j = 0;
		if (Key.length() < 8)
			while (Key.length() < 8)
				Key = Key + (char) 0;

		for (j = 0; j <= 7; j++)
			keyByte[j] = (byte) Key.charAt(j);
		makeKey(keyByte, subKey);
		StrResult = "";
		for (i = 0; i <= (int) (Str.length() / 8) - 1; i++) {
			for (j = 0; j <= 7; j++)
				StrByte[j] = (byte) Str.charAt(i * 8 + j);
			desData(dmDecry, StrByte, OutByte);
			for (j = 0; j <= 7; j++) {
				byteList.add(new Byte(OutByte[j]));
			}
		}
		byte[] myByte = new byte[byteList.size()];
		for (i = 0; i < byteList.size(); i++) {
			Byte b = (Byte) (byteList.get(i));
			myByte[i] = b.byteValue();
		}
		/**
		 * cmq added 20121108
		 */
//		try
//		{
//			StrResult = new String(myByte,"UTF8");
//			System.out.println("--->"+StrResult);
//		}
//		catch(Exception ex)
//		{
//			ex.printStackTrace();
//		}
		//end.
		StrResult = new String(myByte);
		
		while (StrResult.length() > 0
				&& (byte) StrResult.charAt(StrResult.length() - 1) == 0) {
			StrResult = StrResult.substring(0, StrResult.length() - 1);
		}
		// Delete(StrResult, Length(StrResult), 1);
		return new String(StrResult);
	}

	public static void test() {
		System.out.println(new String("中".getBytes()));
	}

	public static void main(String[] args) {
		Des des = new Des();
		try 
		{

			String strEnc = des.EncryPwdStr("<root><productno>CQOL5eDYhVvyfgZNqT6guuaTDcIEJEnO</productno><locknodw>11</locknodw><locknozb>12</locknozb><firstdate>2012-01-01</firstdate><leftdays>-1</leftdays></root>", "hrpweb30");// 加密字符串,返回String的密文
			System.out.println(strEnc);			
			
			String xx=des.DecryPwdStr(strEnc, "hrpweb30");
			System.out.println(xx.toString());
			
			//System.out.println(des.getProductSerialNo(0));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}