import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socially/screens/authentication.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
Widget build(BuildContext context) {
  return FutureBuilder(
    // Initialize FlutterFire:
    future: _initialization,
    builder: (context, snapshot) {
      // Check for errors
      if (snapshot.hasError) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            child: new Text(snapshot.error.toString() , textDirection: TextDirection.ltr)
          ),
        );
      }

      // Once complete, show your application
      if (snapshot.connectionState == ConnectionState.done) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      }

      // Otherwise, show something whilst waiting for initialization to complete
      return Align(
        alignment: Alignment.center,
        child: Container(
          child: new Text("Loading...", textDirection: TextDirection.ltr)
        ),
      );
    },
  );
}
}
