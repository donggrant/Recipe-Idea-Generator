import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/services/database.dart';
import 'constants.dart';
import 'favorite_recipe_tile.dart';

class FavoriteRecipeList extends StatefulWidget {
  @override
  _FavoriteRecipeListState createState() => _FavoriteRecipeListState();
}

class _FavoriteRecipeListState extends State<FavoriteRecipeList> {
  @override
  Widget build(BuildContext context) {
    //final favoriteRecipes = DatabaseService(uid: Constants().getAuth().currentUserID).getFavoriteRecipeList();
    List<FavoriteRecipe> favoriteRecipes = Provider.of<List<FavoriteRecipe>>(context);

    if (favoriteRecipes == null) {
      favoriteRecipes = List<FavoriteRecipe>();
    }

    //return ListTile(title: Text("foo"));
    return ListView.builder(
      itemCount: favoriteRecipes.length,
      itemBuilder: (context, index) {
        // For each item in the favorite recipes list, we return a widget tree
        return FavoriteRecipeTile(favoriteRecipe: favoriteRecipes[index]);
      },
    );
  }
}
