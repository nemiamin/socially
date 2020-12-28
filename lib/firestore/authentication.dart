

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socially/localstorage/localstorage.dart';

Future<String> register(String email, String password, String name) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    await userCredential.user.updateProfile(displayName: name, photoURL: null);
    await userCredential.user.reload();
    User user = FirebaseAuth.instance.currentUser;
    Firestore.instance.collection('users').document().setData({
      'displayName': user.displayName,
      'uid': user.uid,
      'email': user.email,
      'isEmailVerified': user.emailVerified,
      'photoUrl': user.photoURL,
    });
    authBloc.openSession(userCredential);

    return 'Registered successfully!';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 'The account already exists for that email.';
    }else if (e.code == 'invalid-email') {
      return 'The email address is badly formatted';
    }
  } catch (e) {
    print(e);
    return 'Something went wrong!';
  }
}

Future<String> login(email, password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    // Store user in localstorage
    authBloc.openSession(userCredential);

    return 'Logged in successfully!';
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return 'Wrong password provided for that user.';
    } else if (e.code == 'invalid-email') {
      return 'The email address is badly formatted';
    }
  } catch (e) {
    return 'something went wrong';
    print(e);
  }
}


Future<User> getUser() async {
  User user = FirebaseAuth.instance.currentUser;
  print(user);
  return user;
}