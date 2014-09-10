public with sharing class CryptoUtils {
  
  public static String generateNonce() {
        Blob blobKey = Crypto.generateAesKey(128); 
        String key = EncodingUtil.convertToHex(blobKey); // 32 hex characters
        return key.substring(0, 20);
  }
}