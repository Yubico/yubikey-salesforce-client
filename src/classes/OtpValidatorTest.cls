@isTest
public with sharing class OtpValidatorTest {

  private static String clientid = '17394';

  public static testmethod void replayedOtp() {
    Test.setMock(HttpCalloutMock.class, new MockValidationServerResponseGenerator('REPLAYED_OTP'));
    String result = OtpValidator.validate('dummyOtp', clientid);
    System.assertEquals(AuthenticationResult.REPLAYED_OTP, result);
  }
  
  public static testmethod void nonceMismatch() {
    Test.setMock(HttpCalloutMock.class, new MockValidationServerResponseGenerator('OK', 'an_old_nonce'));
    String result = OtpValidator.validate('dummyOtp', clientid);
    System.assertEquals(AuthenticationResult.NONCE_MISMATCH, result);
  }
}