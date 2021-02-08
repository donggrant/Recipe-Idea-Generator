import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/services/auth.dart';
import 'package:recipic/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userData,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            elevation: 0.0,
            title: Text('Home Page'),
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign Out'),
                onPressed: () async {
                  await _auth.signOut();
                  Constants().setPageToShow("Sign In");
                },
              )
            ],
          ),
          body: Container(),
      ),
    );
  }
}
