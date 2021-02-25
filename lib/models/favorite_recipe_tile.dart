import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/pages/recipe_details.dart';

class FavoriteRecipeTile extends StatelessWidget {

  final FavoriteRecipe favoriteRecipe;
  FavoriteRecipeTile({this.favoriteRecipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          tileColor: Color(0xFF6C63FF),
          title: Text(favoriteRecipe.foodName,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            log("Opening recipe details for ${favoriteRecipe.foodName}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipeDetails(recipeDetails: favoriteRecipe.recipe)),
            );
          },
        ),
      ),
    );
  }
}
