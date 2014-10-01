// Copyright Yubico 2014

@isTest
class SequentialResponseGeneratorTest {

  static testmethod void respondsInCorrectOrder() {
      SequentialResponseGenerator respGen = new SequentialResponseGenerator(
          new List<String> {'foo', 'bar', null}
      );
      System.assertEquals('foo', respGen.respond(null).getBody());
      System.assertEquals('bar', respGen.respond(null).getBody());
      System.assertEquals(500, respGen.respond(null).getStatusCode());
  }
}
