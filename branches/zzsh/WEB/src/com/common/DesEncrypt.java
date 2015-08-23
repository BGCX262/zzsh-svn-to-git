/*
 * DesEncrypt.java
 * 
 * Created on 2007-9-20, 16:10:47
 * 
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

//思路： 因为   任意一个字符串，都是由若干字节表示的，每个字节实质就是一个
//              有8位的进进制数，
//      又因为   一个8位二进制数，可用两位16进制字符串表示.
//        因此   任意一个字符串可以由两位16进制字符串表示。
//          而   DES是对8位二进制数进行加密，解密。
//        所以   用DES加密解密时，可以把加密所得的8位进进制数，转成
//               两位16进制数进行保存，传输。
//    具体方法：1 把一个字符串转成8位二进制数，用DES加密，得到8位二进制数的
//                密文
//              2 然后把（由1）所得的密文转成两位十六进制字符串
//              3 解密时，把（由2)所得的两位十六进制字符串，转换成8位二进制
//                数的密文
//              4 把子3所得的密文，用DES进行解密，得到8位二进制数形式的明文，
//                并强制转换成字符串。
// 思考：为什么要通过两位16进制数字符串保存密文呢？
//       原因是：一个字符串加密后所得的8位二进制数，通常不再时字符串了，如果
//              直接把这种密文所得的8位二进制数强制转成字符串，有许多信息因为异
//              常而丢失，导制解密失败。因制要把这个8位二制数，直接以数的形式
//              保存下来，而通常是用两位十六进制数表示。
package com.common;

import java.security.Key;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;

/**
 * 
 * 使用DES加密与解密,可对byte[],String类型进行加密与解密 密文可使用String,byte[]存储.
 * 
 * 方法: void getKey(String strKey)从strKey的字条生成一个Key
 * 
 * String getEncString(String strMing)对strMing进行加密,返回String密文 String
 * getDesString(String strMi)对strMin进行解密,返回String明文
 * 
 * byte[] getEncCode(byte[] byteS)byte[]型的加密 byte[] getDesCode(byte[]
 * byteD)byte[]型的解密
 */

public class DesEncrypt {
	Key key;

	/**
	 * 根据参数生成KEY
	 * 
	 * @param strKey
	 */
	public void getKey(String strKey) {
		try {
			KeyGenerator _generator = KeyGenerator.getInstance("DES");
			_generator.init(new SecureRandom(strKey.getBytes()));
			this.key = _generator.generateKey();
			_generator = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 加密String明文输入,String密文输出
	 * 
	 * @param strMing
	 * @return
	 */
	public String getEncString(String strMing) {
		byte[] byteMi = null;
		byte[] byteMing = null;
		String strMi = "";
		try {
			return byte2hex(getEncCode(strMing.getBytes()));

			// byteMing = strMing.getBytes("UTF8");
			// byteMi = this.getEncCode(byteMing);
			// strMi = new String( byteMi,"UTF8");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			byteMing = null;
			byteMi = null;
		}
		return strMi;
	}

	/**
	 * 解密 以String密文输入,String明文输出
	 * 
	 * @param strMi
	 * @return
	 */
	public String getDesString(String strMi) {
		byte[] byteMing = null;
		byte[] byteMi = null;
		String strMing = "";
		try {
			return new String(getDesCode(hex2byte(strMi.getBytes())));

			// byteMing = this.getDesCode(byteMi);
			// strMing = new String(byteMing,"UTF8");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			byteMing = null;
			byteMi = null;
		}
		return strMing;
	}

	/**
	 * 加密以byte[]明文输入,byte[]密文输出
	 * 
	 * @param byteS
	 * @return
	 */
	private byte[] getEncCode(byte[] byteS) {
		byte[] byteFina = null;
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byteFina = cipher.doFinal(byteS);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cipher = null;
		}
		return byteFina;
	}

	/**
	 * 解密以byte[]密文输入,以byte[]明文输出
	 * 
	 * @param byteD
	 * @return
	 */
	private byte[] getDesCode(byte[] byteD) {
		Cipher cipher;
		byte[] byteFina = null;
		try {
			cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.DECRYPT_MODE, key);
			byteFina = cipher.doFinal(byteD);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cipher = null;
		}
		return byteFina;
	}

	/**
	 * 二行制转字符串
	 * 
	 * @param b
	 * @return
	 */
	public static String byte2hex(byte[] b) { // 一个字节的数，
		// 转成16进制字符串
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			// 整数转成十六进制表示
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
		}
		return hs.toUpperCase(); // 转成大写
	}

	public static byte[] hex2byte(byte[] b) {
		if ((b.length % 2) != 0)
			throw new IllegalArgumentException("长度不是偶数");
		byte[] b2 = new byte[b.length / 2];
		for (int n = 0; n < b.length; n += 2) {
			String item = new String(b, n, 2);
			// 两位一组，表示一个字节,把这样表示的16进制字符串，还原成一个进制字节
			b2[n / 2] = (byte) Integer.parseInt(item, 16);
		}

		return b2;
	}

	public static void main(String[] args) {

		System.out.println("hello");
		DesEncrypt des = new DesEncrypt();// 实例化一个对像
		des.getKey("hrpweb30");// 生成密匙

		String strEnc = des
				.getEncString("<root><productno>CQOL5eDYhVvyfgZNqT6guuaTDcIEJEnO</productno><locknodw>10</locknodw><locknozb>10</locknozb><firstdate>2012-01-01</firstdate><leftdays>-1</leftdays></root>");// 加密字符串,返回String的密文
		System.out.println(strEnc);

		// strEnc =
		// "4BEF4EE35DD47B8FD844F06EE8400D6A9F8D93A79F9D92E3100808071CF43A9DDB231326002A147AEF5CC740E13DD4085FD152B37FD05AFC42CB52E63DE34BA6DB22034F093CCC0F43D046CA6EB894E309310A2C1A3BE2046DD569D77DDC6EF071D051E250F027B334113D09221435B332E95AE062F64FB4C087A180B465D11260F449E242F02758A995A896BF8AD93F5CE46BE86DC560BC331414171C05244BA0B680B35EB59BCF74BD52C340C073EC7E9AAAAB90DA7CC20521F0150106054B80B857C84AED48ADC27DC970D771C22A5FD96AD65AFA2FBD21371A26221D0061F02C18241C0B39ABDD46EB3B0A2EE31E51E76BD770D247A4341E1C1F092E0D53AC87B783B29681F10059E767DE45F0010F23072AF45CF81965FC3DE04DF451BE37E359D563F14C48A09C91AD9CBD7387E44EFE400B5FD0215EF744F044F9225DABB482C173AE96D1203404360A33137783DA6FC17EAF8FF80B3AF34EFB48E62557F64CE652EB4DA732ED5EFF4B1F0074FE3A0A360A01394EBC85B392AE6CA4DB2A0E26F04CEA4B4FBB82BA65D879D5215BDB51ED5BE94440BA7BB08CBD9C81EA022616370456FF6B82A696A29E9587D52810110035EF2147A086B97DA780D32362C166C651F6254B9AB478BB78A490E60A35014DE84BFA0F7DC671D054FC285AA88CAE71C96ECE335FE645E742E647B03812132613213F5D84AE8FA297B69BED1C25133202203C4BA882A391B594A1DD10370733F0261161AF88B6959E9580F20155E449E146E62B57EE42E643E1424DAF94A985B480DE3DBF65DE5BEE4EF00178AC98B982D47B8FE65BEB58ED240950BE86B0AF86BC66F30256C276A791ADED1A21093CE14AEA146BAD72BC8DDB7A9AD144E44FFA52C93DB565D173D86DA4DB1403331F140D364DBB84B291A293B8324014250426133357A3BA8FAE8CB995E20D0D171F2A3E1874FE3FE54EFB5DD51D58C370D179CD4A91EC281420100735A7DC58D949F959F87FF854E062E97CA1C021E85CDF44C66E83F4201B2E1B321B5E9E95A88BA96CDB2D5ED951E454E07F9DD44FED3DF52C1D4FAC86B579B59DB9C62A0721171D073FBBCE7CB08CBA67C7CA370E1328032C1D519788B98EA38AA9C332063FE145C1658BEE26192B1B0B364AB881CF8EA29183D1271217063C1B3EA2DB77C774CE79AE315FF847063CEC2246B498AD70B772D51A5DD450E253C36F818FA896B58BB86BF90F0A2FFE3B183BBD3712222E0C28195FADB680DF5AFE30B0DE73B578BC75D1305CE34AEC37EF4CBB3CE648EB5DEB4A4AAA949598A1B8699DC07CC889B284B4CA2EE95AE65FD648A8D660EE6ED848F97E8CA097A88BBB6D98F95EFF350130E10674D841E158C566A4D068B071C977D7";
		//strEnc = "D40CDA0D763DC2291118380E8581D213BE71E510AEA0254F31DC7EE03BE68F847B79885747675F6A495D9BDEAE9454B2224C6407BB9F012AE9533B26DA05E45AA119357B85E1EDB285D0DECFC5E83CB09EEBEBA9A26FD630263810BB2F2EA73274EC9BA3045E669C2F87AB3518C47262A8F076433219E6E248BFFE950529954E2611D43F6D27FD1B";
		String strDes = des.getDesString(strEnc);// 把String 类型的密文解密
		System.out.println(strDes);
	}

}
