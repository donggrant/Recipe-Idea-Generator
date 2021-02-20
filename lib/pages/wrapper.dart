import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/pages/forgot_password.dart';
import 'package:recipic/pages/home.dart';
import 'package:recipic/pages/sign_in.dart';
import 'package:recipic/ui_pages/ui_landing.dart';
import 'package:recipic/ui_pages/ui_register.dart';

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
            case "Landing":
              return Landing();
            case "Loading":
              return Loading();
            case "Sign In":
              return SignIn();
            case "Register":
              return RegisterUI();
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
