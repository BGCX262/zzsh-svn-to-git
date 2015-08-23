package com.common.demo;

import java.io.File;
import java.security.*;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

import jxl.Workbook;
/**
* encrypt from des
* @author Liudong
*/
public class Encrypt {

    private static final String PASSWORD_CRYPT_KEY = "ilovethisgame";
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
//        	return new String(decrypt(data.getBytes(),PASSWORD_CRYPT_KEY.getBytes()));
            return new String(decrypt(hex2byte(data.getBytes()),PASSWORD_CRYPT_KEY.getBytes()),"UTF-8");
        } catch (Exception e) {
        	try {
				throw new Exception(e);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
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
	    	String en = et.encrypt("<LEFTDAYS>-1</LEFTDAYS><ProductNo>CQOL5eDYhVvyfgZNqT6guuaTDcIEJEnO</ProductNo><UPGRADETYPE>2</UPGRADETYPE><LOCKNO>64153</LOCKNO><FIRSTDATE>2011-12-19</FIRSTDATE><CurDatabasePlat>1</CurDatabasePlat><VER>50</VER><GRP_BPS_BASIC>10</GRP_BPS_BASIC><BAMA>1</BAMA><RSYD>1</RSYD><HTGL>1</HTGL><SAMA>1</SAMA><BXFL>1</BXFL><BBGL>1</BBGL><BGGJ>1</BGGJ><CGZS>0</CGZS><GZZD>1</GZZD><FZJC>1</FZJC><GRP_BPS_BUSSINESS>10</GRP_BPS_BUSSINESS><REMA>1</REMA><PRMA>1</PRMA><WBOC>0</WBOC><MBO>1</MBO><TRMA>1</TRMA><ATMA>1</ATMA><RMGL>1</RMGL><DAGL>1</DAGL><BSGZ>0</BSGZ><ZCZM>10</ZCZM><GZRZ>1</GZRZ><YDHW>1</YDHW><DTGH>1</DTGH><GRP_ESS_EBASIC>10</GRP_ESS_EBASIC><GRP_ESS_MBASIC>10</GRP_ESS_MBASIC><SELFSEVICEFLAG>2</SELFSEVICEFLAG><EMSS>10</EMSS><MASS>10</MASS><TRSS>1</TRSS><PRSS>1</PRSS><RESS>1</RESS><ATSS>1</ATSS><EATSS>1</EATSS><ZPMH>1</ZPMH>");
	    	String de = et.decrypt(en);
	    	System.out.println(en);
	    	System.out.println(de);
	    	
	    	try {
				String test = "ilrD8l0aEO+6tI/BHs8FwFSDd6PAtvKlmWLxsitm2tzXVxkqxx328hnE2PfuT3ORROt91VKx9MLty1wTt2ppWaU41pd0+BXfcJoqtl0xyO/KnUXdDLYvPuZvIMjbE2u5fjlpDSH7jhNDfERPSdCgjAoaKDx2DHxzo9cksoGfSguGFH5Uv2Wbkw2eyJRiEo0oSsmY9HS6fgSHmQkmGVKJGU9RcgBAZMVpLWmtS/HmmqkDmYFrGzQaLr5dGkMhDL9kb4Ow07pEhA94W4Ms6JqKYWnuAAW4CKeUHtPMix7St2c9zTU7Ijk1EycrDqrExzDA3oemiWiyAWseWIQwdKE19qYk7NG8qsQL4nznpGWenZ94a0UTnDhYlZWex8RKmSchHjC+7s2u4W9VJ82Gx9l9Jl42YRW4jUB5s6MnKRLRtyEnAu3UZE/z8ASb9uCIa5DFEs1dPzUb+hioG3/xkv3BhvKFtAlqUQcC83O5oQlt51Sc/G8fnBZUfLEVs0aVsm+vHT0Sr34lj64HCCc++GLbNd6qWYmslEoBBIcavcVOE3Egj3iyM4jfYaxqhgBcCTIb48o2AuvqDKNkMujhtE2yNUR2n8c+A8v3NWwErVudBZz5Cot8SOmrgbFud7lD3XrvAslZwCWYELBXMdq6ZYPSagylohzZ55Pkoq1ItKz77jcD9RMHnq5hEpsTDO9ZHh3RVoAVtxpGcHz0hOjU52UmlKPdMxMso+r5fSMRTam2xC7F1EjNFqX1bL5Bf9WoLFl8HFGCxEjZ2mwu8WRq8fjkQBcWlRWgm75O+Kxksom/uXH8g1ew07x1kNKa/5SiRqd7NYD9iNUOY4SCVmm670g8TYP6fbMiVrleXHLsAGQhBIK3Rv096TAIsdbLo9UYsBbhXIVRHo6w83slblpasIw6SXPvyVfFzSN97Ldn9gK69KiplPxoDqsCCEtmV8nxAJCfqJHgAcJ1MYhZ5czGro1F8SmBD03TYaCi6+Ujpg+poPGIf4x4Ke1P0QMSJEAh+fefjwLhpZT/5j1kQLCXwDL0+sUqk618BEsq82jq4PPnZ9IT5ChN81C3zKx8FU+exPtvsagzSrUeKO7xR/MuGhfPwY/HBu3wHlpdj9RyaePHZLT0dksOm0D7NuYplquCit7/uWc2A21/j2IRFA3QJZm8pS5bOPO5xyn01o6MqMHIsgtBjeaRqHLIhUc8PjLHQdKGEsa7AvDqhWRyJm50t6y2tvcEj1GgAu3JwUMGx//aEaBoC0vT6tR7XsGChKDqMzx5MpQ+qmuFhF8SdtgAG+Vh4hYU3lyu9bORhTp2D2FK1f8W8SG+rX8Txtb2BMkUEtC/6P2f5cmsOMPALFEZnwwMt7pGI5PMRD3Wls4NdqKQXPuaPvapKOnTThYVTr6TAkVJ26qoxRbT0J35NORWqftzR3nv/h7qxI96z00VQwlUMmPlFgUrtJACReXgW1os7pS/5qVY2D5reERcG6tPIgwQKxJeJxSGHExdcW3pYmH/rnc0mty05miKENM74bsCcFqEn2Bh3h5bC/s=";
				
				System.out.println(hex2byte(test.getBytes()));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	
	}           
           
}

