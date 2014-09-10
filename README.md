yubikey-salesforce-client
=========================

Apex classes for validating YubiKey OTP's (one-time passwords).

## Usage
```
OtpValidator validator = new OtpValidator();
String result = validator.validate(otp, clientId);

if(result == AuthenticationResult.OK) {
  /* The OTP is valid! Now check that the YubiKey used belongs to this user,
     using one of these methods:
  
      OtpUtils.getYubikeyId(otp);
      
      OtpUtils.getYubikeySerialNumber(otp);
      
    For example:
  */
  
  String yubikeyId = OtpUtils.getYubikeyId(otp)
  if(yubiKeyId == user.yubikeyId__c) {
    // Successfully authenticated!
  } else {
    // The wrong YubiKey was used for this user.
  }
} else {
  // Invalid OTP
}
```
