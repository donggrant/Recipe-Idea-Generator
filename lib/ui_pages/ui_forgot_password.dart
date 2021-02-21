import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipic/models/constants.dart';

class ForgotPasswordUI extends StatefulWidget {
  @override
  _ForgotPasswordUIState createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: Color(0xFF6C63FF),
                      onPressed: () {
                        Constants().setPageToShow("Sign In");
                      },
                    ),
                  ),
                  Container(
                    height: 250,
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: SvgPicture.asset(
                        "images/undraw_forgot_password_gi2d.svg",
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        Text(
                          "Forgot your password?",
                          style: GoogleFonts.lato(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "We'll send you instructions to reset your password. Enter the email address associated with your account. ",
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 17,
                              textStyle: TextStyle(
                                color: Colors.grey[600],
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
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
                    onChanged: (string) {},
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF6C63FF),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: Text(
                          "Send",
                          style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
