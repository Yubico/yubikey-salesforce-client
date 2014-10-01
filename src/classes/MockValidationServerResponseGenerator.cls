public with sharing class MockValidationServerResponseGenerator implements HttpCalloutMock {

  private final String status;
  private final String nonceToUse;
  private final String otpToUse;

  public MockValidationServerResponseGenerator(String status) {
    this(status, null, null);
  }
  
  public MockValidationServerResponseGenerator(String status, String nonceToUse) {
    this(status, nonceToUse, null);
  }
  
  public MockValidationServerResponseGenerator(String status, String nonceToUse, String otpToUse) {
    this.status = status;
    this.nonceToUse = nonceToUse;
    this.otpToUse = otpToUse;
  }

  public HTTPResponse respond(HTTPRequest req) {
    String nonce = nonceToUse == null ? getParam('nonce', req) : nonceToUse;
    String otp = otpToUse == null ? getParam('otp', req) : otpToUse ;
    
    HttpResponse res = new HttpResponse();
    String responseBody =
      'h=vjhFxZrNHB5CjI6vhuSeF2n46a8=\r\n' +
      't=2010-04-23T20:34:51Z0678\r\n' +
      'otp=' + otp + '\r\n' +
      'nonce=' + nonce + '\r\n' +
      'sl=75\r\n' +
      'status=' + status + '\r\n';
    res.setBody(responseBody);
    res.setStatusCode(200);
    return res;
  }
  
  private static String getParam(String paramName, HTTPRequest req) {
    String endpoint = req.getEndpoint();
    Integer paramStart = endpoint.indexOf(paramName + '=');
    Integer paramLength = endpoint.subString(paramStart).indexOf('&');
    
    Integer paramNameLength = paramName.length();
    if(paramLength == -1) {
      return endpoint.subString(paramStart + paramNameLength + 1);
    }
    else {
      return endpoint.subString(paramStart + paramNameLength + 1, paramStart + paramLength);
    }
  }
}
