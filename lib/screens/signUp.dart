import 'package:flutter/material.dart';
import 'package:socially/firestore/authentication.dart';
import 'package:socially/screens/taskScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible;
  bool loading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  showMessage(String msg) {
    final SnackBar snackBar =
    SnackBar(content: Text(msg));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  validateForm() {
    if(nameController.text.isEmpty) {
      showMessage('Name is required!');
    } else if(emailController.text.isEmpty) {
      showMessage('Email is required!');
    } else if(passwordController.text.isEmpty) {
      showMessage('Password is required!');
    }
  }

  resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: loading ? Container(
        color: Color(0xFF311f4f),
    child: Align(
    alignment: Alignment.center,
    child: Text('Loading....', style: TextStyle(color: Colors.white),),
    ),
    ) : Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Color(0xFF311f4f),
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email address",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  icon: _passwordVisible
                      ? Icon(
                    Icons.visibility,
                    color: Colors.white,
                  )
                      : Icon(
                    Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    setState(() {
                      loading = true;
                    });

                    String resgisterResponse = await register(emailController.text.trim().toLowerCase(), passwordController.text, nameController.text);
                    print(resgisterResponse);
                    showMessage(resgisterResponse);
                    if(resgisterResponse == 'Registered successfully!') {
                      resetForm();
                    }
                    setState(() {
                      loading = false;
                    });
                  } else {
                    validateForm();
                  }
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFb63bfe),
                        Color(0xFF8c3aff),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
