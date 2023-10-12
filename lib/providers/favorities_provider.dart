import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

//i need to add to this class for editing and retreiving state
//A. initial value (like initial list of meals)
//B. all methods that should exist to change that list in this case
class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]); //constructor dont take any parameters
  //we give super the initial values

  //next add methods
  //you r not allowed to edit an existing value in memory
  //instead you must create a new one
  //replace it using state. property
  bool toggleMealFavoriteStatus(Meal meal) {
    //check wether meal is in list or not
    final mealIsFavorite = state.contains(meal);

    //reassign the state
    if (mealIsFavorite) {
      //if meal is fav drop it , add others
      state = state.where((m) => m.id != meal.id).toList();
      return false; //if item removed
    } else {
      state = [
        ...state,
        meal
      ]; //pull out all elements stored in that list + meal
      return true; //if item added
    }
  }
}

//instead of provider() used for dynamic data
//works with another class (above)
final favoritMealsProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {
  return FavoriteMealNotifier(); //return an instance of above class giving the generic type
});
