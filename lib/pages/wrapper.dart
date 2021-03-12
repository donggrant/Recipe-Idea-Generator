import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/pages/home.dart';
import 'package:recipic/ui_pages/ui_forgot_password.dart';
import 'package:recipic/ui_pages/ui_landing.dart';
import 'package:recipic/ui_pages/ui_register.dart';
import 'package:recipic/ui_pages/ui_sign_in.dart';

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
              return SignInUI();
            case "Register":
              return RegisterUI();
            case "Forgot Password":
              return ForgotPasswordUI();
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
