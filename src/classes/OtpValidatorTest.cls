// Copyright Yubico 2014

@isTest
public with sharing class OtpValidatorTest {

  private static String clientid = '17394';

  public static testmethod void ok() {
    Test.setMock(HttpCalloutMock.class, new MockValidationServerResponseGenerator('OK'));
    String result = OtpValidator.validate('dummyOtp', clientid);
    System.assertEquals(AuthenticationResult.OK, result);
  }

  public static testmethod void replayedOtp() {
    Test.setMock(HttpCalloutMock.class, new MockValidationServerResponseGenerator('OK', null, 'anotherOtp'));
    String result = OtpValidator.validate('dummyOtp', clientid);
    System.assertEquals(AuthenticationResult.OTP_MISMATCH, result);
  }
  
  public static testmethod void nonceMismatch() {
    Test.setMock(HttpCalloutMock.class, new MockValidationServerResponseGenerator('OK', 'an_old_nonce'));
    String result = OtpValidator.validate('dummyOtp', clientid);
    System.assertEquals(AuthenticationResult.NONCE_MISMATCH, result);
  }
}
