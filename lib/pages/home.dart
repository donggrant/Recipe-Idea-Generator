import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_list.dart';
import 'package:recipic/pages/recipeWizard.dart';
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
            backgroundColor: Color(0xFF6C63FF),
            elevation: 0.0,
            title: Text('Home Page'),
            actions: [
              FlatButton.icon(
                icon: Icon(Icons.person, color: Colors.white),
                label: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await Constants().getAuth().signOut();
                  Constants().setPageToShow("Sign In");
                },
              )
            ],
          ),
          body: Column(
            children: [
              RaisedButton(
                  child: Text("Get New Recipe Recommendation"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecipeWizardAddPhotos()),
                    );
                  }
              ),
              FavoriteRecipeList(),
            ],
          ),
    )
    );
  }
}
