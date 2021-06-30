import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Api {
  final String _baseUrl = dotenv.env['FIREBASE_REALTIME_URL'];
  Uri _url;

  Api(String path) {
    _url = Uri.parse('$_baseUrl$path');
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

  Future<http.Response> put(Object body) {
    return http.put(_url, body: json.encode(body));
  }

  Future<http.Response> delete() {
    return http.delete(_url);
  }
}
