@isTest
public class ApiRequesterTest {

    private static final Set<String> SERVERS_NORTH_AMERICA = new Set<String>(ApiRequester.SERVERS_NORTH_AMERICA);
    private static final Set<String> SERVERS_EMEA = new Set<String>(ApiRequester.SERVERS_EMEA);
    private static final Set<String> SERVERS_APAC = new Set<String>(ApiRequester.SERVERS_APAC);

    public static testmethod void shouldOrderCorrectly() {
        List<String> servers = ApiRequester.orderServers('na');
        
        System.assert(SERVERS_NORTH_AMERICA.contains(servers.get(0)));
        System.assert(SERVERS_NORTH_AMERICA.contains(servers.get(1)));
        System.assert(servers.get(0) != servers.get(1));
        
        System.assert(SERVERS_EMEA.contains(servers.get(2)) || SERVERS_APAC.contains(servers.get(2)));
        System.assert(SERVERS_EMEA.contains(servers.get(3)) || SERVERS_APAC.contains(servers.get(3)));
        System.assert(SERVERS_EMEA.contains(servers.get(4)) || SERVERS_APAC.contains(servers.get(4)));
        System.assert(servers.get(2) != servers.get(3) && servers.get(3) != servers.get(4) && servers.get(4) != servers.get(2));
    }

    public static testmethod void shouldFailover() {
        Test.setMock(HttpCalloutMock.class, new SequentialResponseGenerator(new List<String>{null, null, 'server 3 responded'}));
        List<String> servers = new List<String> {'foo', 'bar', 'baz'};
        HttpResponse response = ApiRequester.sendRequest('myParam=true', servers);
        
        System.assertEquals(response.getBody(), 'server 3 responded');
    }
}
