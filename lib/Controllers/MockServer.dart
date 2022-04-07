import 'package:http/http.dart';
import 'package:http/testing.dart';

MockClient myMockHttpClient = MockClient((request) async {
  switch (request.url.toString()) {
    case 'https://mymockwebserver/api/login':
      {
        await Future.delayed(const Duration(seconds: 3));
        return Response(
            """{
      "displayName": "ShaheryarTheDev",
      "email": "shaheryarthedev@gmail.com",
      "id": "112260725763765838305",
      "photoUrl": "https: //lh3.googleusercontent.com/a/AATXAJwEPaLZW5c07NRz5XTBmEWVfv13j-181BJEf_LV=s96-c"
      }""", 200);
      }

    default:
      return Response('{"message": "page not found"}', 404);
  }
});