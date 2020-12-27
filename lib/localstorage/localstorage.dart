import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  UserCredential user;

  void dispose() {
  }

  void openSession(user) async {
    this.user = user;
    print("open session =>>>>>>>>>>>>>>>>>>>>");
    print(user);
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('token');
    user = null;
  }
}



final authBloc = AuthBloc();
