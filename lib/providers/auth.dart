import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shop/errors/auth_errors.dart';
import 'package:shop/services/auth_api.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    if (isAuth) {
      return _userId;
    }

    return null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _autenticate(
      String email, String password, String serviceType) async {
    Response response = await AuthApi(serviceType).post({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    });

    final responseBody = json.decode(response.body);

    if (responseBody["error"] != null) {
      throw AuthErrors(responseBody['error']['message']);
    } else {
      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );
      print(_token);
      print(_expiryDate);
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> signInWithPassword(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }
}
