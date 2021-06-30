import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthApi {
  final String _key = 'AIzaSyA1daSNHmB_gLnvQnI3ySiBH-CtGGq80Cs';
  Uri _url;

  AuthApi(String serviceType) {
    _url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$serviceType?key=$_key');
  }

  Future<http.Response> post(Object body) {
    return http.post(_url, body: json.encode(body));
  }

  Future<http.Response> get() {
    return http.get(_url);
  }

  Future<http.Response> patch(Object body) {
    return http.patch(_url, body: json.encode(body));
  }

  Future<http.Response> delete() {
    return http.delete(_url);
  }
}
