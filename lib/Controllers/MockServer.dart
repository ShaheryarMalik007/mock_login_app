import 'package:http/http.dart';
import 'package:http/testing.dart';

MockClient myMockHttpClient = MockClient((request) async {
  switch (request.url.toString()) {
    case 'https://staging.company.com/api/customer/123':
      return Response('{"customer": "123", "name": "Jane Jimmy"}', 200);
    case 'https://staging.company.com/api/customer/155':
      return Response('{"customer": "155", "name": "Gregor"}', 200);
    default:
      return Response('{"customer": "155", "name": "Gregor"}', 200);
  }
});