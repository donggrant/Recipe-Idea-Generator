import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/services/auth.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  void emailVerificationDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification Email Sent'),
          content: SingleChildScrollView(
            child: Text("We have sent you an email containing a link to "
                "verify your email address. You must verify your email "
                "address before you can sign in."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: Color(0xFF6C63FF),
                      onPressed: () {
                        Constants().setPageToShow("Landing");
                      },
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: SvgPicture.asset(
                        "images/result.svg",
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello there!",
                          style: GoogleFonts.lato(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Let's create your account so you can get cooking.",
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 17,
                              textStyle: TextStyle(
                                color: Colors.grey[600],
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Your Email",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Enter an email';
                      else
                        return null;
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    validator: (val) {
                      if (val.length < 6)
                        return 'Enter a password 6+ chars long';
                      else
                        return null;
                    },
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    validator: (val) {
                      if (val != password)
                        return 'Passwords do not match';
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 20),
                  //TODO: Add an agree to terms and conditions and privacy policy
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'please supply a valid email';
                          });
                        } else {
                          Constants().setPageToShow("Sign In");
                          emailVerificationDialog();
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                textStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  // SignInButton(
                  //   Buttons.Google,
                  //   text: "Sign up with Google",
                  //   onPressed: () {
                  //     //TODO: Add Google Login
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
