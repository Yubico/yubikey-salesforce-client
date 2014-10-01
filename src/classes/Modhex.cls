// Copyright Yubico 2014

/**
 * <p>
 *   Utility methods to 
 *   {@link #encode(byte[]) encode} a byte array to Modhex 
 *   {@code String} and to
 *   {@link #decode(String) decode} a Modhex
 *   {@link String} to a the byte array it represents.   
 * </p>
 * <p>
 *   Modehex encoding uses the 
 *   {@link #ALPHABET alphabet} {@code cbdefghijklnrtuv} which has the property
 *   of being at the same position on all keyboards.
 * </p>
 */
public class Modhex {
  
  /**
  *   The Modhex alphabet: the letters used to decode bytes in.
  */
  private static String ALPHABET = 'cbdefghijklnrtuv';
  private static String[] chars = new String[]{'c', 'b', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'n', 'r', 't', 'u', 'v'};

  public static String getSerialNumber(String yubikeyModhexId) {
      if(yubikeyModHexId == null)
          return '';
      String result = String.valueOf(decode(yubikeyModhexId));
      while(result.length() < 8) { 
        result = '0' + result;
      }
      return result;
  }
  
  public static Long decode(String s) {
    while(s.length() < 16) { 
        s = 'c' + s;
    }
  
    List<Integer> bytes = new List<Integer>();
    Integer len = s.length();
      
    Boolean toggle = false;
    Integer keep = 0;

    for (Integer i = 0; i < len; i++) {
        String ch = s.substring(i, i+1);
        Integer n = ALPHABET.indexOf(ch);
        if (n == -1) {
            throw new IllegalArgumentException(s+' is not properly encoded');
        }

        toggle = !toggle;

        if (toggle) {
            keep = n;
        } else {
            bytes.add((keep << 4) | n);
        }
      }
      return byteArrayToLong(bytes);
  }
  
  private static Long byteArrayToLong(List<Integer> bytes) 
  {
    Long value = 0;
    for (Integer i = 0; i < 8; i++) {
        Integer shift = (4 - 1 - i) * 8;
        value += (bytes.get(i) & 255) << shift;
    }
    return value;
  }
 
  public class IllegalArgumentException extends Exception {}
}
