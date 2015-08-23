package com.common.demo;

import java.io.File;
import java.security.*;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import jxl.Workbook;
/**
* encrypt from des
* @author Liudong
*/
public class Encrypt {

    private static final String PASSWORD_CRYPT_KEY = "hrpweb30";
    private final static String DES = "DES";

    /**
     * 加密
     * @param src 数据源
     * @param key 密钥，长度必须是8的倍数
     * @return 返回加密后的数据
     * @throws Exception
     */
    public static byte[] encrypt(byte[] src, byte[] key) throws Exception {
//DES算法要求有一个可信任的随机数源
        SecureRandom sr = new SecureRandom();
// 从原始密匙数据创建DESKeySpec对象
        DESKeySpec dks = new DESKeySpec(key);
// 创建一个密匙工厂，然后用它把DESKeySpec转换成
// 一个SecretKey对象
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
        SecretKey securekey = keyFactory.generateSecret(dks);
// Cipher对象实际完成加密操作
        Cipher cipher = Cipher.getInstance(DES);
// 用密匙初始化Cipher对象
        cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);
// 现在，获取数据并加密
// 正式执行加密操作
        return cipher.doFinal(src);
    }

    /**
     * 解密
     * @param src 数据源
     * @param key 密钥，长度必须是8的倍数
     * @return 返回解密后的原始数据
     * @throws Exception
     */
    public static byte[] decrypt(byte[] src, byte[] key) throws Exception {
// DES算法要求有一个可信任的随机数源
        SecureRandom sr = new SecureRandom();
// 从原始密匙数据创建一个DESKeySpec对象
        DESKeySpec dks = new DESKeySpec(key);
// 创建一个密匙工厂，然后用它把DESKeySpec对象转换成
// 一个SecretKey对象
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
        SecretKey securekey = keyFactory.generateSecret(dks);
// Cipher对象实际完成解密操作
        Cipher cipher = Cipher.getInstance(DES);
// 用密匙初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, securekey, sr);
// 现在，获取数据并解密
// 正式执行解密操作
        return cipher.doFinal(src);
    }

    /**
     * 密码解密
     * @param data
     * @return
     * @throws Exception
     */
    public final static String decrypt(String data) {
        try {
//            return new String(decrypt(hex2byte(data.getBytes()),PASSWORD_CRYPT_KEY.getBytes()));
        	return new String(decrypt(data.getBytes(),PASSWORD_CRYPT_KEY.getBytes()));
            //return new String(decrypt(hex2byte(data.getBytes()),PASSWORD_CRYPT_KEY.getBytes()),"GB2312");
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * 密码加密
     * @param password
     * @return
     * @throws Exception
     */
    public final static String encrypt(String password) {
        try {
            String strc=password;
            strc=new String(strc.getBytes("GB2312"));
            return byte2hex(encrypt(password.getBytes(),PASSWORD_CRYPT_KEY.getBytes()));
            //return byte2hex(encrypt(strc.getBytes(),PASSWORD_CRYPT_KEY.getBytes()));
        } catch (Exception e) {
        }
        return null;
    }

    public static String byte2hex(byte[] b) {

         String hs = "";

         String stmp = "";

         for (int n = 0; n < b.length; n++) {

             stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));

             if (stmp.length() == 1)

                 hs = hs + "0" + stmp;

             else

                 hs = hs + stmp;

         }

         return hs.toUpperCase();

     }



	 public static byte[] hex2byte(byte[] b) {
	
	       if ((b.length % 2) != 0)
	
	           throw new IllegalArgumentException("长度不是偶数");
	
	       byte[] b2 = new byte[b.length / 2];
	
	       for (int n = 0; n < b.length; n += 2) {
	
	           String item = new String(b, n, 2);
	
	           b2[n / 2] = (byte) Integer.parseInt(item, 16);
	
	       }
	
	       return b2;
	 }
           
           
   	public static void main(String[] arges){

	    	Encrypt et=new Encrypt();
	    	String en = et.encrypt("<LEFTDAYS>-1</LEFTDAYS><ProductNo>CQOL5eDYhVvyfgZNqT6guuaTDcIEJEnO</ProductNo><UPGRADETYPE>2</UPGRADETYPE><LOCKNO>64168</LOCKNO><FIRSTDATE>2012-04-13</FIRSTDATE><CurDatabasePlat>1</CurDatabasePlat><VER>60</VER><VER_S>1</VER_S><GRP_BPS_BASIC>1</GRP_BPS_BASIC><BAMA>1</BAMA><RSYD>1</RSYD><HTGL>1</HTGL><SAMA>1</SAMA><BXFL>1</BXFL><BBGL>1</BBGL><BGGJ>1</BGGJ><CGZS>1</CGZS><GZZD>1</GZZD><FZJC>1</FZJC><JXGL>1</JXGL><GXGL>1</GXGL><GRP_BPS_BUSSINESS>1</GRP_BPS_BUSSINESS><REMA>1</REMA><PRMA>1</PRMA><WBOC>1</WBOC><CC>1</CC><MBO>1</MBO><TRMA>1</TRMA><ATMA>1</ATMA><RMGL>1</RMGL><DAGL>1</DAGL><BSGZ>0</BSGZ><ZCZM>1</ZCZM><GZRZ>1</GZRZ><YDHW>1</YDHW><DTGH>1</DTGH><COMP>1</COMP><ZXXX>1</ZXXX><ZXKS>1</ZXKS><GRP_ESS_EBASIC>1</GRP_ESS_EBASIC><GRP_ESS_MBASIC>1</GRP_ESS_MBASIC><SELFSEVICEFLAG>2</SELFSEVICEFLAG><GRP_ESS_EBASIC>1</GRP_ESS_EBASIC><EMSS>1</EMSS><GRP_ESS_MBASIC>1</GRP_ESS_MBASIC><MASS>1</MASS><TRSS>1</TRSS><PRSS>1</PRSS><RESS>1</RESS><ATSS>1</ATSS><EATSS>1</EATSS><ZPMH>1</ZPMH>");
	    	String de = et.decrypt(en);
	    	System.out.println(en);
	    	System.out.println(de);
	}           
           
}

