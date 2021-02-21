import 'package:flutter/material.dart';
import 'package:recipic/services/auth.dart';
import 'package:recipic/models/constants.dart';

class SignIn extends StatefulWidget {

  SignIn(); // constructor for SignIn class

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          elevation: 0.0,
          title: Text('Sign In Page'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () {
                Constants().setPageToShow("Register");
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Password'),
                    validator: (val) =>
                    val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.grey[800],
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await Constants().getAuth()
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                              'could not sign in with those credentials';
                            });
                          } else {
                            Constants().setPageToShow("Home");
                          }
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    RaisedButton(
                        child: Text(
                            "Forgot Password",
                            style: TextStyle(color: Colors.white)
                        ),
                        color: Colors.grey[800],
                        onPressed: () {
                          Constants().setPageToShow("Forgot Password");
                        }
                    )
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
    }
}