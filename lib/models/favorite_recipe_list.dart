import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FavoriteRecipeList extends StatefulWidget {
  @override
  _FavoriteRecipeListState createState() => _FavoriteRecipeListState();
}

class _FavoriteRecipeListState extends State<FavoriteRecipeList> {
  @override
  Widget build(BuildContext context) {

    final favoriteRecipes = Provider.of<QuerySnapshot>(context);
    log("*************************************************");
    for (var doc in favoriteRecipes.documents) {
      log(doc.data.toString());
    }
    log("*************************************************");

    return Container();
  }
}
