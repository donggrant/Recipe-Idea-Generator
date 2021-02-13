import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterUI extends StatefulWidget {
  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6C63FF),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Ink(
                //Can add background color to back button here
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: BackButton(),
              ),
              Text(
                "Create \nAccount",
                style: GoogleFonts.lato(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
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
                  hintText: 'johndoe@mail.com',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
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
              ),
              //TODO: Add an agree to terms and conditions and privacy policy
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Text(
                      "Create Account",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {
                  //TODO: Add Google Login
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
