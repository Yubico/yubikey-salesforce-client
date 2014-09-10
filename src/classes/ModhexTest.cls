@isTest
public class ModhexTest {

    static testmethod void shouldDecodeCorrectly() {
        System.assertEquals('', Modhex.getSerialNumber(null));
        System.assertEquals(1949730, Modhex.decode('ccccccbtrcdd'));
        System.assertEquals('01949730', Modhex.getSerialNumber('ccccccbtrcdd'));
    }
}