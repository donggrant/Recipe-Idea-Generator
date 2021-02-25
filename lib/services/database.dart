import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_tile.dart';

class DatabaseService {
  String uid;
  List<Map<String, String>> recipes;

  DatabaseService({String uid}) {
    this.uid = uid;
    recipes = new List<Map<String, String>>();
    this.recipeData; // call the function that gets the recipe data
    //addRecipesToDatabase();
  }

  // collection reference
  final CollectionReference usersCollection = Firestore.instance.collection("Users");
  final CollectionReference recipesCollection = Firestore.instance.collection("Recipes");

  // Method for manually adding recipes to the database, if necessary
  void addRecipesToDatabase() async {
    recipes.add({"food": "pizza", "recipe": "How to make pizza"});
    recipes.add({"food": "sandwich", "recipe": "How to make a sandwich"});
    recipes.add({"food": "burrito", "recipe": "How to make a burrito"});
    recipes.add({"food": "cookies", "recipe": "How to make cookies"});
    recipes.add({"food": "fried rice", "recipe": "How to make fried rice"});
    recipes.add({"food": "burger", "recipe": "How to make a burger"});
    recipes.add({"food": "cake", "recipe": "How to make cake"});
    recipes.add({"food": "salad", "recipe": "How to make salad"});
    recipes.add({"food": "french fries", "recipe": "How to make french fries"});
    recipes.add({"food": "tacos", "recipe": "How to make tacos"});

    for (int i = 0; i < recipes.length; i++) {
      await recipesCollection.document(i.toString()).setData(recipes[i]);
    }
  }
  
  Future updateUserData(List<int> favoriteRecipeIDs) async {
    return await usersCollection.document(uid).setData({
      "favoriteRecipeIDs": favoriteRecipeIDs
    });
  }

  List<FavoriteRecipe> getFavoriteRecipesFromSnapshot(QuerySnapshot snapshot) {
    // Iterate through all users' favorite recipe documents
    List<dynamic> favoriteRecipeIDs = new List<dynamic>();
    log("Printing query snapshots...");
    for (int i = 0; i < snapshot.documents.asMap().length; i++) {
      DocumentSnapshot currentDocument = snapshot.documents.asMap()[i];
      String currentDocumentID = currentDocument.documentID;

      // Get the document for the currently signed-in user
      if (currentDocumentID == uid) {
        // Retrieve the array of favorite recipe IDs
        favoriteRecipeIDs = currentDocument.data["favoriteRecipeIDs"];
        log("Found favoriteRecipeIDs for $uid: ${favoriteRecipeIDs.toString()}");
        break; // terminate the loop because we've gotten the document we want
      }
    }
    log("Printing query snapshots... finished!");

    // Create FavoriteRecipe objects for each favoriteRecipeID
    List<FavoriteRecipe> favoriteRecipes = new List<FavoriteRecipe>();
    log("Creating list of FavoriteRecipe objects...");
    for (int i = 0; i < favoriteRecipeIDs.length; i++) {
      log("Creating FavoriteRecipe object for recipeID ${favoriteRecipeIDs[i]}");
      favoriteRecipes.add(
          new FavoriteRecipe(
              foodName: recipes[favoriteRecipeIDs[i]].keys.elementAt(0),
              recipeID: favoriteRecipeIDs[i],
              recipe: recipes[favoriteRecipeIDs[i]].values.elementAt(0),
          )
      );
    }
    log("Creating list of FavoriteRecipe objects... finished!");

    return favoriteRecipes;
  }

  Stream<List<FavoriteRecipe>> get favoriteRecipes {
    return usersCollection.snapshots().map(getFavoriteRecipesFromSnapshot);
  }

  void get recipeData {
    log("Retrieving recipe data...");
    recipesCollection.snapshots().elementAt(0).then((x) {
      List<DocumentSnapshot> docsList = x.documents;

      // Get the recipe data from the database, and populate the food list
      // instance variable with this data
      log("${docsList.length} recipes found");
      for (int i = 0; i < docsList.length; i++) {
        String foodName = docsList[i].data["food"];
        String foodRecipe = docsList[i].data["recipe"];
        log("Retrieved recipe ${docsList[i].documentID}: $foodName");
        recipes.add({foodName: foodRecipe});
      }
    });
    log("Final recipe list retrieved from database: ${recipes.toString()}");
  }
}
