public with sharing class OtpValidator {

  public static String validate(String otp, String clientId) {
      String nonceInRequest = CryptoUtils.generateNonce();
 
      HTTPResponse res = ApiRequester.sendRequest('id=' + clientId + '&otp=' + otp + '&nonce=' + nonceInRequest);
 
      Map<String, String> responseParameters = HttpUtils.parseResponseParameters(res.getBody()); 
      String result = responseParameters.get('status');

      if(result == AuthenticationResult.OK) {
          String nonceInResponse = responseParameters.get('nonce');
          if (nonceInResponse != nonceInRequest) { 
              return AuthenticationResult.NONCE_MISMATCH;
          } 
      }     

      return result;
  }
}