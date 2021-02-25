import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_list.dart';
import 'package:recipic/services/auth.dart';
import 'package:recipic/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FavoriteRecipe>>.value(
      value: DatabaseService(uid: Constants().getCurrentUserID()).favoriteRecipes,
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
                  await Constants().getAuth().signOut();
                  Constants().setPageToShow("Sign In");
                },
              )
            ],
          ),
          body: FavoriteRecipeList(),
    )
    );
  }
}
