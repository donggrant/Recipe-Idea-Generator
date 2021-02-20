import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<FavoriteRecipe> getFavoriteRecipeList() {
    log("Getting favorite recipe list...");
    DocumentReference userDocument = usersCollection.document(uid);
    log("userDocument.documentID = ${userDocument.documentID}");

    List<FavoriteRecipe> result = new List<FavoriteRecipe>();

    usersCollection.getDocuments().then((querySnapshot) {
      log("Printing query snapshots...");
      for (int i = 0; i < querySnapshot.documents.asMap().length; i++) {
        DocumentSnapshot currentDocument = querySnapshot.documents.asMap()[i];
        log("DocID: ${currentDocument.documentID}");
        log("UserID: $uid");
        List<dynamic> favoriteRecipeIDs = currentDocument.data["favoriteRecipeIDs"];
        log("favoriteRecipeIDs: ${favoriteRecipeIDs.toString()}");
        log("**************************************************************");
      }
      log("Printing query snapshots... finished!");
    });

    return result;
  }
}
