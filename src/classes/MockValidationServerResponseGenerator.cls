public with sharing class MockValidationServerResponseGenerator implements HttpCalloutMock {

  private final String status;
  private final String nonceToUse;

  public MockValidationServerResponseGenerator(String status) {
    this.status = status;
    this.nonceToUse = null;
  }
  
  public MockValidationServerResponseGenerator(String status, String nonceToUse) {
    this.status = status;
    this.nonceToUse = nonceToUse;
  }

  public HTTPResponse respond(HTTPRequest req) {
    String nonce = nonceToUse == null ? getNonce(req) : nonceToUse;
    
    HttpResponse res = new HttpResponse();
    String responseBody =
      'h=vjhFxZrNHB5CjI6vhuSeF2n46a8=\r\n' +
      't=2010-04-23T20:34:51Z0678\r\n' +
      'otp=cccccccbcjdifctrndncchkftchjlnbhvhtugdljibej\r\n' +
      'nonce=' + nonce + '\r\n' +
      'sl=75\r\n' +
      'status=' + status + '\r\n';
        res.setBody(responseBody);
        res.setStatusCode(200);
        return res;
  }
  
  private static String getNonce(HTTPRequest req) {
    String endpoint = req.getEndpoint();
    Integer nonceStart = endpoint.indexOf('nonce=');
    Integer nonceEnd = endpoint.subString(nonceStart).indexOf('&');
    
    String nonce;
    if(nonceEnd == -1) {
      return endpoint.subString(nonceStart + 6);
    }
    else {
      return endpoint.subString(nonceStart + 6, nonceEnd);
    }
  }
}