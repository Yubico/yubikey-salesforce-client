public with sharing class OtpUtils {
  
  static final Integer FIRST_PRINTABLE_CHAR = 32;
  static final Integer LAST_PRINTABLE_CHAR = 126;
  
  static final Integer OTP_MIN_LEN = 32;
  static final Integer OTP_MAX_LEN = 48;
  
  /*
   * Checks whether the given OTP is valid, according to the recommendations at
   * https://github.com/Yubico/yubikey-val/blob/master/doc/GettingStartedWritingClients.adoc#validate-otp-format
   */
  public static boolean isValidOtpFormat(String otp) {
    return otp != null && isValidOtpLength(otp) && containsOnlyPrintableAscii(otp) && isYubikeyIssuedByYubico(otp);
  }
  
  public static boolean isYubikeyIssuedByYubico(String otpOrId) {
    return otpOrId != null && otpOrId.toLowerCase().startsWith('cc');
  }
  
  public static boolean isValidIdFormat(String id) {
    return id != null && id.length() == 12 && containsOnlyPrintableAscii(id) && isYubikeyIssuedByYubico(id);
  }
  
  private static boolean containsOnlyPrintableAscii(String otp) {
    Integer length = otp.length();
    for (Integer i = 0; i < length; i++) {
      Integer c = otp.charAt(i);
      if (c < FIRST_PRINTABLE_CHAR || c > LAST_PRINTABLE_CHAR) {
        return false;
      }
    }
    return true;
  }
  
  private static boolean isValidOtpLength(String otp) {
    return OTP_MIN_LEN <= otp.length() && otp.length() <= OTP_MAX_LEN;
  }
  
  public static String getYubikeyId(String otp) {
    return otp.substring(0, 12);
  }
  
  public static boolean isUniqueId(String yubikeyId) {
       List<User> usersWithSameYubikey = [SELECT yubikey_id__c from User where yubikey_id__c=:yubikeyId];
       return usersWithSameYubikey.isEmpty();
  }
}