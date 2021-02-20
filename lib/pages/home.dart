import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_list.dart';
import 'package:recipic/services/auth.dart';
import 'package:recipic/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    List<FavoriteRecipe> list = DatabaseService().getFavoriteRecipeList();
    return Scaffold(
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
          body: FavoriteRecipeList(),
    );
  }
}
