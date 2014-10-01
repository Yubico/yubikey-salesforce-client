// Copyright Yubico 2014

public class RandomUtils
{
    /**
     * Gets a random integer number between lower (inclusive) and upper (exclusive)
     */
    public static Integer getRandomInt(Integer lower, Integer upper) {
        return (Integer) (Math.floor(Math.random() * (upper - lower)) + lower);
    }
    
    public static List<String> shuffle(List<String> originalList) {
        List<String> availableValues = originalList.clone();
        List<String> shuffledList = new List<String>();
        for(Integer i=0; i<originalList.size(); i++) {
            Integer indexToRemove = getRandomInt(0, availableValues.size());
            shuffledList.add(availableValues.remove(indexToRemove));
        }
        return shuffledList;
    }
}
