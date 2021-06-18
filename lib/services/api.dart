import 'package:http/http.dart' as http;

class Api {
  String _baseUrl = 'https://shop-flutter-73319-default-rtdb.firebaseio.com/';
  Uri _url;

  Api(String path) {
    _url = Uri.parse('$_baseUrl$path');
  }

  Future<http.Response> post(Object body) {
    return http.post(_url, body: body);
  }
}
