@isTest
private class OtpUtilsTest {

    static testmethod void validatesCorrectly() {
        System.assert(OtpUtils.isValidOtpFormat('ccbvijfhvcjbgubnrredtrrkhuhglcnudjfngiknllnc'));
        System.assert(OtpUtils.isValidOtpFormat('CCBVIJFHVCJBLNNVHLHRNIUCDBEBNEGCKJFNKGVGINUH'));
        System.assert(OtpUtils.isValidIdFormat('CCBVIJFHVCJB'));
        
        System.assert(!OtpUtils.isValidOtpFormat(null));
        System.assert(!OtpUtils.isValidOtpFormat('vvv'));
        System.assert(!OtpUtils.isValidOtpFormat('åäövijfhvcjbgcervulbnrlevbrkfectekeivunjtrdr'));
    }
    
    static testmethod void extractsYubikeyIds() {
        System.assertEquals(OtpUtils.getYubikeyId('ccbvijfhvcjbgcervulbnrlevbrkfectekeivunjtrdr'), 'ccbvijfhvcjb');
    }
    
    static testmethod void recognizesYubikeysIssuedByYubico() {
        System.assert(!OtpUtils.isYubikeyIssuedByYubico('vvbvijfhvcjbgcervulbnrlevbrkfectekeivunjtrdr'));
        System.assert(OtpUtils.isYubikeyIssuedByYubico('ccbvijfhvcjb'));
    }
}