import 'package:flutter/material.dart';
import 'package:socially/firestore/authentication.dart';
import 'package:socially/screens/taskScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
bool loading = false;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Container(
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
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
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
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
setState(() {
  loading = true;
});
              String loginResponse = await login(emailController.text, passwordController.text);
              print(loginResponse);
              if(loginResponse == 'Logged in successfully!') {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => TaskScreen()));
              } else {
                showMessage(loginResponse);
              }
setState(() {
  loading = false;
});
            },
            child: Center(
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
                        ])),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
