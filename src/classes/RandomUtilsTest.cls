// Copyright Yubico 2014

@isTest
public class RandomUtilsTest {

    public static testmethod void shuffleShouldReturnListWithSameSetOfElements() {
        List<String> originalList = new List<String> {'a', 'b', 'c'};
        List<String> shuffledList = RandomUtils.shuffle(originalList);

        originalList.sort();
        shuffledList.sort();
        System.assertEquals(originalList, shuffledList);
    }

}
