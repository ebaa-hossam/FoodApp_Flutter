import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  //initial state
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegeterian: false,
          Filter.vegan: false,
        });

  //methods
  void setFilter(Filter filter, bool isActive) {
    //reassign the state
    state = {
      ...state, //old key value pairs
      filter: isActive, //overrides one key value pair
    };
  }

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

//a simple provider bec i wont ceate a new filter notifier class
//based on other providers state using ref argument
final filteredMealProvider = Provider((ref) {
  //logic of switching filters based on providers mealsProvider and filtersProvider not in tabs.dart
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  //
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true; //meals that i wanna keep that passed if statements
  }).toList();
});
