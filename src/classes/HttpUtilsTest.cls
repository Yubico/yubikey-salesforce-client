@isTest
public with sharing class HttpUtilsTest {

  static testMethod void parsesCorrectly() {
    String responseBody =
      'h=vjhFxZrNHB5CjI6vhuSeF2n46a8=\r\n' +
      't=2010-04-23T20:34:51Z0678\r\n' +
      'otp=cccccccbcjdifctrndncchkftchjlnbhvhtugdljibej\r\n' +
      'nonce=aef3a7835277a28da831005c2ae3b919e2076a62\r\n' +
      'sl=75\r\n' +
      'status=OK\r\n';
    
    Map<String, String> parameters = HttpUtils.parseResponseParameters(responseBody);
    
    System.assertEquals('aef3a7835277a28da831005c2ae3b919e2076a62', parameters.get('nonce'));
    System.assertEquals('OK', parameters.get('status'));
  }
   
}