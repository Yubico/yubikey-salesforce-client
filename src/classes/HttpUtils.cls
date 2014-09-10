public with sharing class HttpUtils {

  public static Map<String, String> parseResponseParameters(String responseBody) {
    Map<String, String> parsedParams = new Map<String, String>();
    
    List<String> params = responseBody.split('\r\n'); 
        for(String param : params) { 
            String[] keyValue = param.split('=');
            if(keyValue.size() == 2) {
              parsedParams.put(keyValue[0], keyValue[1]);
            }
        } 
        return parsedParams;
  }
}