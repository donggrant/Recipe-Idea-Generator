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
  }

  void loadRecipesIntoDatabase() async {
    for (int i = 0; i < foods.length; i++) {
      await recipesCollection.document(i.toString()).setData({"food": foods[i]});
    }
  }
  
  Future updateUserData(List<int> favoriteRecipeIDs) async {
    //CollectionReference favoriteRecipesCollection = userDocument.collection("Favorite Recipes");
    //userDocument.setData({}); // without this, the document won't show up in the query snapshot
    return await usersCollection.document(uid).setData({
      "favoriteRecipeIDs": favoriteRecipeIDs
    });
  }

  List<FavoriteRecipe> getFavoriteRecipeList(QuerySnapshot snapshot) {
    DocumentReference userDocument = usersCollection.document(uid);

    // Iterate through all users' favorite recipe documents
    List<dynamic> favoriteRecipeIDs = new List<dynamic>();
    log("getFavoriteRecipeList() : >>> Printing query snapshots...");
    for (int i = 0; i < snapshot.documents.asMap().length; i++) {
      DocumentSnapshot currentDocument = snapshot.documents.asMap()[i];
      String currentDocumentID = currentDocument.documentID;

      // Get the document for the currently signed-in user
      if (currentDocumentID == uid) {
        // Retrieve the array of favorite recipe IDs
        favoriteRecipeIDs = currentDocument.data["favoriteRecipeIDs"];
        log("getFavoriteRecipeList() : >>> Found favoriteRecipeIDs for $uid: ${favoriteRecipeIDs.toString()}");
        break; // terminate the loop because we've gotten the document we want
      }
    }
    log("getFavoriteRecipeList() : >>> Printing query snapshots... finished!");

    // Create FavoriteRecipe objects for each favoriteRecipeID
    List<FavoriteRecipe> favoriteRecipes = new List<FavoriteRecipe>();
    log("getFavoriteRecipeList() : >>> Creating list of FavoriteRecipe objects...");
    log("getFavoriteRecipeList() : >>> Using food list ${foods.toString()}");
    for (int i = 0; i < favoriteRecipeIDs.length; i++) {
      log("getFavoriteRecipeList() : >>> >>> Creating FavoriteRecipe object for recipeID ${favoriteRecipeIDs[i]} a.k.a. ${foods[i]}");
      favoriteRecipes.add(
          new FavoriteRecipe(
              foodName: foods[favoriteRecipeIDs[i]],
              recipeID: favoriteRecipeIDs[i],
              recipe: ""
          )
      );
    }
    log("getFavoriteRecipeList() : >>> Creating list of FavoriteRecipe objects... finished!");

    return favoriteRecipes;
  }

  Stream<List<FavoriteRecipe>> get favoriteRecipes {
    return usersCollection.snapshots().map(getFavoriteRecipeList);
  }
}
