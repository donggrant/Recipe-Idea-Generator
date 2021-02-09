import 'package:flutter/material.dart';
import 'package:recipic/models/favorite_recipe.dart';

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
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueAccent,
          ),
          title: Text(favoriteRecipe.foodName),
        ),
      ),
    );
  }
}
