import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_tile.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection = Firestore.instance.collection("Users");

  Future updateUserData(List<int> favoriteRecipeIDs) async {
    //CollectionReference favoriteRecipesCollection = userDocument.collection("Favorite Recipes");
    //userDocument.setData({}); // without this, the document won't show up in the query snapshot
    return await usersCollection.document(uid).setData({
      "favoriteRecipeIDs": favoriteRecipeIDs
    });
  }

  List<FavoriteRecipe> getFavoriteRecipeList(QuerySnapshot snapshot) {
    DocumentReference userDocument = usersCollection.document(uid);
    log("getFavoriteRecipeList() : userDocument.documentID = ${userDocument.documentID}");

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
        log("getFavoriteRecipeList() : >>> Found favoriteRecipeIDs: ${favoriteRecipeIDs.toString()}");
      }
    }
    log("getFavoriteRecipeList() : >>> Printing query snapshots... finished!");

    // Create FavoriteRecipe objects for each favoriteRecipeID
    List<FavoriteRecipe> favoriteRecipes = new List<FavoriteRecipe>();
    log("getFavoriteRecipeList = ${favoriteRecipes.toString()}");
    for (int i = 0; i < favoriteRecipeIDs.length; i++) {
      favoriteRecipes.add(new FavoriteRecipe(foodName: "", recipeID: favoriteRecipeIDs[i], recipe: ""));
      log("getFavoriteRecipeList = ${favoriteRecipes.toString()}");
    }

    log("getFavoriteRecipeList = ${favoriteRecipes.toString()}");
    return favoriteRecipes;
  }

  List<FavoriteRecipe> _favoriteRecipeListFromSnapshot(QuerySnapshot snapshot) {
    List<FavoriteRecipe> result = snapshot.documents.map((doc) {
      log("snapshot.documents.map(doc.data) : ${doc.data}");
      List<dynamic> favoriteRecipeIDs = doc.data['favoriteRecipeIDs'];
      return FavoriteRecipe(
        foodName: doc.data['favoriteRecipeIDs'].toString() ?? '',
        recipeID: doc.data['recipeID'] ?? 0,
        recipe: doc.data['recipe'] ?? '',
      );
    }).toList();
    log("_favoriteRecipeListFromSnapshot = ${result.toString()}");
    return result;
  }

  Stream<List<FavoriteRecipe>> get favoriteRecipes {
    return usersCollection.snapshots().map(_favoriteRecipeListFromSnapshot);
    //return usersCollection.snapshots().map(getFavoriteRecipeList);
  }
}
