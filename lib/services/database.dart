import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_tile.dart';

class DatabaseService {
  String uid;
  List<String> foods;

  DatabaseService({String uid}) {
    this.uid = uid;
    createFoodList();
    loadRecipesIntoDatabase();
  }

  // collection reference
  final CollectionReference usersCollection = Firestore.instance.collection("Users");
  final CollectionReference recipesCollection = Firestore.instance.collection("Recipes");

  void createFoodList() {
    foods = new List<String>();
    foods.add("pizza");
    foods.add("sandwich");
    foods.add("burrito");
    foods.add("cookies");
    foods.add("fried rice");
    foods.add("burger");
    foods.add("cake");
    foods.add("salad");
    foods.add("french fries");
    foods.add("tacos");
  }

  void loadRecipesIntoDatabase() async {
    for (int i = 0; i < foods.length; i++) {
      await recipesCollection.document(i.toString()).setData({"food": foods[i]});
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
      log("Creating FavoriteRecipe object for recipeID ${favoriteRecipeIDs[i]} (${foods[i]})");
      favoriteRecipes.add(
          new FavoriteRecipe(
              foodName: foods[favoriteRecipeIDs[i]],
              recipeID: favoriteRecipeIDs[i],
              recipe: ""
          )
      );
    }
    log("Creating list of FavoriteRecipe objects... finished!");

    return favoriteRecipes;
  }

  Stream<List<FavoriteRecipe>> get favoriteRecipes {
    return usersCollection.snapshots().map(getFavoriteRecipesFromSnapshot);
  }
}
