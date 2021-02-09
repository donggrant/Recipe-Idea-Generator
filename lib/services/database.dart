import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipic/models/favorite_recipe.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference favoriteRecipesCollection = Firestore.instance.collection("Favorite Recipes");

  Future updateUserData(String foodName, int recipeID, String recipe) async {
    return await favoriteRecipesCollection.document(uid).setData({
      'foodName': foodName,
      'recipeID': recipeID,
      'recipe': recipe,
    });
  }

  // favorite recipe list from snapshot
  List<FavoriteRecipe> _favoriteRecipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FavoriteRecipe(
        foodName: doc.data['foodName'] ?? '',
        recipeID: doc.data['recipeID'] ?? 0,
        recipe: doc.data['recipe'] ?? '',
      );
    }).toList();
  }

  // get stream
  Stream<List<FavoriteRecipe>> get favoriteRecipes {
    return favoriteRecipesCollection.snapshots().map(_favoriteRecipeListFromSnapshot);
  }
}
