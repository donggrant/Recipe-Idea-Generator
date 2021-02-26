import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final String recipeDetails;

  RecipeDetails({this.recipeDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        elevation: 0.0,
        title: Text('Recipe Details'),
      ),
      body: Text(recipeDetails),
    );
  }
}
