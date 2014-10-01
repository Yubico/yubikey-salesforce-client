// Copyright Yubico 2014

public with sharing class SequentialResponseGenerator implements HttpCalloutMock {

  private final List<String> responses;

  public SequentialResponseGenerator(List<String> responses) {
    this.responses = responses;
  }
  
  public HTTPResponse respond(HTTPRequest req) {
     HttpResponse res = new HttpResponse();
     String body = responses.remove(0);
     
     if(body == null) {
         res.setStatusCode(500);
     } else {
         res.setBody(body);
         res.setStatusCode(200);
     }
     return res;
  }
}
