/**
 * @author aidan@processity.ai
 * @date 27/06/2024
 */

@IsTest
private class ListsTest {

    static List<SObject> input = new List<SObject> {
            new Account(Name = 'A'),
            new Account(Name = 'B'),
            new Account(Name = 'C'),
            new Account(Name = 'D')
    };


    @IsTest
    static void sliceOneFromBeginning() {
        List<SObject> result = Lists.slice(input, 0, 1);

        Assert.areEqual(1, result.size());
        Assert.areEqual(input[0], result[0]);
    }

    @IsTest
    static void sliceOneFromMiddle() {
        List<SObject> result = Lists.slice(input, 3, 4);

        Assert.areEqual(1, result.size());
        Assert.areEqual(input[3], result[0]);
    }

    @IsTest
    static void sliceTwoFromBeginning() {
        List<SObject> result = Lists.slice(input, 0, 2);

        Assert.areEqual(2, result.size());
        Assert.areEqual(input[0], result[0]);
        Assert.areEqual(input[1], result[1]);
    }

    @IsTest
    static void sliceTwoFromMiddle() {
        List<SObject> result = Lists.slice(input, 1, 3);

        Assert.areEqual(2, result.size());
        Assert.areEqual(input[1], result[0]);
        Assert.areEqual(input[2], result[1]);
    }
}