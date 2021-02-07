import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/pages/forgot_password.dart';
import 'package:recipic/pages/home.dart';
import 'package:recipic/pages/register.dart';
import 'package:recipic/pages/sign_in.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<String>(
        valueListenable: Constants().getPageToShow(),
        builder: (BuildContext context, String value, Widget child) {
          switch (value) {
            case "Loading":
              return Loading();
            case "Sign In":
              return SignIn();
            case "Register":
              return Register();
            case "Forgot Password":
              return ForgotPassword();
            case "Home":
              return Home();
            default:
              return null;
          }
        },
      ),
    );
  }
}