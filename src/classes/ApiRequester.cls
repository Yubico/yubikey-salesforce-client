/*
 * Sends a request. Handles failover and geographical load-balancing.
 */

public with sharing class ApiRequester {
 
    public static final List<String> SERVERS_NORTH_AMERICA = new List<String> {'api', 'api2'};
    public static final List<String> SERVERS_APAC = new List<String> {'api3'};
    public static final List<String> SERVERS_EMEA = new List<String> {'api5', 'api4'};
    
    public static final Integer SHORT_TIMEOUT_MS = 4000;
    public static final Integer LONG_TIMEOUT_MS = 20000;
 
    public static HttpResponse sendRequest(String parameters) {
        List<String> servers = orderServers(getLocation());
        return sendRequest(parameters, servers);
    }
 
    public static HttpResponse sendRequest(String parameters, List<String> servers) {
        Http http = new Http();
        HTTPResponse response = null;
        Integer timeout = SHORT_TIMEOUT_MS;
        
        for(String server : servers) {
            try {
                HttpRequest request = createRequest(server, parameters, timeout);                
                response = http.send(request);
                if(response.getStatusCode() < 500) {
                    break;
                }
            } catch(System.CalloutException e) {
                timeout = LONG_TIMEOUT_MS;
            }
        }     
        
        return response; 
    }
    
    private static HttpRequest createRequest(String server, String parameters, Integer timeout) {
        HttpRequest req = new HttpRequest();
        req.setTimeout(timeout); 
        req.setEndpoint('https://' + server + '.yubico.com/wsapi/2.0/verify?' + parameters ); 
        req.setMethod('GET');
        req.setHeader('User-Agent', 'yubico-salesforce-client/' + AboutController.VERSION + ' (' + getLocation() + ')');
        return req; 
    }
    
    private static String getLocation() {
        String host = URL.getSalesforceBaseUrl().getHost();
        return host.substring(0, 2); 
    }
    
    public static List<String> orderServers(String location) {
        List<String> servers = new List<String>();
        if(location == 'eu') {
            servers.addAll(RandomUtils.shuffle(SERVERS_EMEA));
            servers.addAll(RandomUtils.shuffle(SERVERS_APAC));
            servers.addAll(RandomUtils.shuffle(SERVERS_NORTH_AMERICA));
        } else if(location == 'ap') {
            servers.addAll(RandomUtils.shuffle(SERVERS_APAC));
            servers.addAll(RandomUtils.shuffle(SERVERS_EMEA));
            servers.addAll(RandomUtils.shuffle(SERVERS_NORTH_AMERICA));
        } else {
            servers.addAll(RandomUtils.shuffle(SERVERS_NORTH_AMERICA));
            servers.addAll(RandomUtils.shuffle(SERVERS_EMEA));
            servers.addAll(RandomUtils.shuffle(SERVERS_APAC));
        }
        return servers;
    }
        
}
