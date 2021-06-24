import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shop/data/store.dart';
import 'package:shop/errors/auth_errors.dart';
import 'package:shop/services/auth_api.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  String _userId;
  Timer _signOutTimer;
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
    String email,
    String password,
    String serviceType,
  ) async {
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

      Store.saveMap('userData', {
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });

      _autoSignOut();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> signInWithPassword(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    }

    final userData = await Store.getMap('userData');

    if (userData == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(userData["expiryDate"]);

    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _userId = userData['userId'];
    _token = userData['token'];
    _expiryDate = expiryDate;

    _autoSignOut();
    notifyListeners();

    return Future.value();
  }

  void signOut() {
    _expiryDate = null;
    _token = null;
    _userId = null;

    if (_signOutTimer != null) {
      _signOutTimer.cancel();
      _signOutTimer = null;
    }

    Store.remove('userData');

    notifyListeners();
  }

  void _autoSignOut() {
    if (_signOutTimer != null) {
      _signOutTimer.cancel();
    }

    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;
    _signOutTimer = Timer(
      Duration(
        seconds: timeToLogout,
      ),
      () {
        signOut();

        Fluttertoast.showToast(
          msg: "Seu token expirou. Faça um novo login.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        );
      },
    );
  }
}
