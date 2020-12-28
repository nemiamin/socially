import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socially/firestore/authentication.dart';

class AuthBloc {
  UserCredential user;

  final PublishSubject _isSessionValid = PublishSubject<bool>();
  PublishSubject<bool> get isSessionValid => _isSessionValid.stream;

  void dispose() {
    _isSessionValid.close();
  }

  void restoreSession() async {
   User user = await getUser();
    if (user != null) {
      print("User found");
      _isSessionValid.sink.add(true);
    } else {
      print("User not found");
      _isSessionValid.sink.add(false);
    }
  }

  void openSession(user) async {
    this.user = user;
    _isSessionValid.sink.add(true);
    print("open session =>>>>>>>>>>>>>>>>>>>>");
    print(user);
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('token');

    user = null;
    _isSessionValid.sink.add(false);
  }
}



final authBloc = AuthBloc();
