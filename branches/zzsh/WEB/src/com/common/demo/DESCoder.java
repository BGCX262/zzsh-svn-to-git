package com.common.demo;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;

import java.math.BigInteger;
import java.security.Key;  
import java.security.SecureRandom;  
  
import javax.crypto.Cipher;  
import javax.crypto.KeyGenerator;  
import javax.crypto.SecretKey;  
import javax.crypto.SecretKeyFactory;  
import javax.crypto.spec.DESKeySpec;  
  
  
/** 
 * DES安全编码组件 
 *  
 * <pre> 
 * 支持 DES、DESede(TripleDES,就是3DES)、AES、Blowfish、RC2、RC4(ARCFOUR) 
 * DES                  key size must be equal to 56 
 * DESede(TripleDES)    key size must be equal to 112 or 168 
 * AES                  key size must be equal to 128, 192 or 256,but 192 and 256 bits may not be available 
 * Blowfish             key size must be multiple of 8, and can only range from 32 to 448 (inclusive) 
 * RC2                  key size must be between 40 and 1024 bits 
 * RC4(ARCFOUR)         key size must be between 40 and 1024 bits 
 * 具体内容 需要关注 JDK Document http://.../docs/technotes/guides/security/SunProviders.html 
 * </pre> 
 *  
 * @author 梁栋 
 * @version 1.0 
 * @since 1.0 
 */  
public abstract class DESCoder extends Coder {  
    /** 
     * ALGORITHM 算法 <br> 
     * 可替换为以下任意一种算法，同时key值的size相应改变。 
     *  
     * <pre> 
     * DES                  key size must be equal to 56 
     * DESede(TripleDES)    key size must be equal to 112 or 168 
     * AES                  key size must be equal to 128, 192 or 256,but 192 and 256 bits may not be available 
     * Blowfish             key size must be multiple of 8, and can only range from 32 to 448 (inclusive) 
     * RC2                  key size must be between 40 and 1024 bits 
     * RC4(ARCFOUR)         key size must be between 40 and 1024 bits 
     * </pre> 
     *  
     * 在Key toKey(byte[] key)方法中使用下述代码 
     * <code>SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);</code> 替换 
     * <code> 
     * DESKeySpec dks = new DESKeySpec(key); 
     * SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM); 
     * SecretKey secretKey = keyFactory.generateSecret(dks); 
     * </code> 
     */  
    public static final String ALGORITHM = "DES";  
  
    /** 
     * 转换密钥<br> 
     *  
     * @param key 
     * @return 
     * @throws Exception 
     */  
    private static Key toKey(byte[] key) throws Exception {  
        DESKeySpec dks = new DESKeySpec(key);  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);  
        SecretKey secretKey = keyFactory.generateSecret(dks);  
  
        // 当使用其他对称加密算法时，如AES、Blowfish等算法时，用下述代码替换上述三行代码  
        // SecretKey secretKey = new SecretKeySpec(key, ALGORITHM);  
  
        return secretKey;  
    }  
  
    /** 
     * 解密 
     *  
     * @param data 
     * @param key 
     * @return 
     * @throws Exception 
     */  
    public static byte[] decrypt(byte[] data, String key) throws Exception {  
        Key k = toKey(decryptBASE64(key));  
  
        Cipher cipher = Cipher.getInstance(ALGORITHM);  
        cipher.init(Cipher.DECRYPT_MODE, k);  
  
        return cipher.doFinal(data);  
    }  
  
    /** 
     * 加密 
     *  
     * @param data 
     * @param key 
     * @return 
     * @throws Exception 
     */  
    public static byte[] encrypt(byte[] data, String key) throws Exception {  
        Key k = toKey(decryptBASE64(key));  
        Cipher cipher = Cipher.getInstance(ALGORITHM);  
        cipher.init(Cipher.ENCRYPT_MODE, k);  
  
        return cipher.doFinal(data);  
    }  
  
    /** 
     * 生成密钥 
     *  
     * @return 
     * @throws Exception 
     */  
    public static String initKey() throws Exception {  
        return initKey(null);  
    }  
  
    /** 
     * 生成密钥 
     *  
     * @param seed 
     * @return 
     * @throws Exception 
     */  
    public static String initKey(String seed) throws Exception {  
        SecureRandom secureRandom = null;  
        seed = "hrpweb30";
        if (seed != null) {  
            secureRandom = new SecureRandom(decryptBASE64(seed));  
        } else {  
            secureRandom = new SecureRandom();  
        }  
  
        KeyGenerator kg = KeyGenerator.getInstance(ALGORITHM);  
        kg.init(secureRandom);  
  
        SecretKey secretKey = kg.generateKey();  
  
        return encryptBASE64(secretKey.getEncoded());  
    }  
    
   	public static void main(String[] arges) throws Exception{

   		String inputStr = "<LEFTDAYS>-1</LEFTDAYS><ProductNo>CQOL5eDYhVvyfgZNqT6guuaTDcIEJEnO</ProductNo><UPGRADETYPE>2</UPGRADETYPE><LOCKNO>64168</LOCKNO><FIRSTDATE>2012-04-13</FIRSTDATE><CurDatabasePlat>1</CurDatabasePlat><VER>60</VER><VER_S>1</VER_S><GRP_BPS_BASIC>1</GRP_BPS_BASIC><BAMA>1</BAMA><RSYD>1</RSYD><HTGL>1</HTGL><SAMA>1</SAMA><BXFL>1</BXFL><BBGL>1</BBGL><BGGJ>1</BGGJ><CGZS>1</CGZS><GZZD>1</GZZD><FZJC>1</FZJC><JXGL>1</JXGL><GXGL>1</GXGL><GRP_BPS_BUSSINESS>1</GRP_BPS_BUSSINESS><REMA>1</REMA><PRMA>1</PRMA><WBOC>1</WBOC><CC>1</CC><MBO>1</MBO><TRMA>1</TRMA><ATMA>1</ATMA><RMGL>1</RMGL><DAGL>1</DAGL><BSGZ>0</BSGZ><ZCZM>1</ZCZM><GZRZ>1</GZRZ><YDHW>1</YDHW><DTGH>1</DTGH><COMP>1</COMP><ZXXX>1</ZXXX><ZXKS>1</ZXKS><GRP_ESS_EBASIC>1</GRP_ESS_EBASIC><GRP_ESS_MBASIC>1</GRP_ESS_MBASIC><SELFSEVICEFLAG>2</SELFSEVICEFLAG><GRP_ESS_EBASIC>1</GRP_ESS_EBASIC><EMSS>1</EMSS><GRP_ESS_MBASIC>1</GRP_ESS_MBASIC><MASS>1</MASS><TRSS>1</TRSS><PRSS>1</PRSS><RESS>1</RESS><ATSS>1</ATSS><EATSS>1</EATSS><ZPMH>1</ZPMH>";  
        String key = DESCoder.initKey();  
        System.err.println("原文:\t" + inputStr);  
        
        System.err.println("密钥:\t" + key);  
        	
        byte[] inputData = inputStr.getBytes();  
        inputData = DESCoder.encrypt(inputData, key);  
  
        System.err.println("加密后:\t" + DESCoder.encryptBASE64(inputData));  
        
        inputData = new String("4BEF4EE35DD47B8FD844F06EE8400D6A9F8D93A79F9D92E3100808071CF43A9DDB231326002A147AEF5CC740E13DD4085FD152B37FD05AFC42CB52E63DE34BA6DB22034F093CCC0F43D046CA6EB894E309310A2C1A3BE2046DD569D77DDC6EF071D051E250F027B334113D09221435B332E95AE062F64FB4C087A180B465D11260F449E242F02758A995A896BF8AD93F5CE46BE86DC560BC331414171C05244BA0B680B35EB59BCF74BD52C340C073EC7E9AAAAB90DA7CC20521F0150106054B80B857C84AED48ADC27DC970D771C22A5FD96AD65AFA2FBD21371A26221D0061F02C18241C0B39ABDD46EB3B0A2EE31E51E76BD770D247A4341E1C1F092E0D53AC87B783B29681F10059E767DE45F0010F23072AF45CF81965FC3DE04DF451BE37E359D563F14C48A09C91AD9CBD7387E44EFE400B5FD0215EF744F044F9225DABB482C173AE96D1203404360A33137783DA6FC17EAF8FF80B3AF34EFB48E62557F64CE652EB4DA732ED5EFF4B1F0074FE3A0A360A01394EBC85B392AE6CA4DB2A0E26F04CEA4B4FBB82BA65D879D5215BDB51ED5BE94440BA7BB08CBD9C81EA022616370456FF6B82A696A29E9587D52810110035EF2147A086B97DA780D32362C166C651F6254B9AB478BB78A490E60A35014DE84BFA0F7DC671D054FC285AA88CAE71C96ECE335FE645E742E647B03812132613213F5D84AE8FA297B69BED1C25133202203C4BA882A391B594A1DD10370733F0261161AF88B6959E9580F20155E449E146E62B57EE42E643E1424DAF94A985B480DE3DBF65DE5BEE4EF00178AC98B982D47B8FE65BEB58ED240950BE86B0AF86BC66F30256C276A791ADED1A21093CE14AEA146BAD72BC8DDB7A9AD144E44FFA52C93DB565D173D86DA4DB1403331F140D364DBB84B291A293B8324014250426133357A3BA8FAE8CB995E20D0D171F2A3E1874FE3FE54EFB5DD51D58C370D179CD4A91EC281420100735A7DC58D949F959F87FF854E062E97CA1C021E85CDF44C66E83F4201B2E1B321B5E9E95A88BA96CDB2D5ED951E454E07F9DD44FED3DF52C1D4FAC86B579B59DB9C62A0721171D073FBBCE7CB08CBA67C7CA370E1328032C1D519788B98EA38AA9C332063FE145C1658BEE26192B1B0B364AB881CF8EA29183D1271217063C1B3EA2DB77C774CE79AE315FF847063CEC2246B498AD70B772D51A5DD450E253C36F818FA896B58BB86BF90F0A2FFE3B183BBD3712222E0C28195FADB680DF5AFE30B0DE73B578BC75D1305CE34AEC37EF4CBB3CE648EB5DEB4A4AAA949598A1B8699DC07CC889B284B4CA2EE95AE65FD648A8D660EE6ED848F97E8CA097A88BBB6D98F95EFF350130E10674D841E158C566A4D068B071C977D7").getBytes();
        byte[] outputData = DESCoder.decrypt(inputData, key);  
        String outputStr = new String(outputData);  
  
        System.err.println("解密后:\t" + outputStr);  
  
        assertEquals(inputStr, outputStr);    	
    }           
}  