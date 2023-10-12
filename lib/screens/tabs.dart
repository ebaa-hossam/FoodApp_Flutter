import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/main_drawer.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/providers/favorities_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}
//to handle toggling between diff screens

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0; // default is 0 which is categoriesscreen
  //final List<Meal> _favoriteMeals = []; //no need bec of provider
  //Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

//no need for this method as we used provider
  // void _toggleMealFavoriteStatus(Meal meal) {
  //   //for pressing star icon in meals
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('removed from favorites');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Marked as favorite!');
  //   }
  // }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex =
          index; //change index based on selection in bottomn bar
    });
  }

  void _setScreen(String identifier) async {
    //async for future value
    //for handlling drawer
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      //final result =
      await Navigator.of(context).push<Map<Filter, bool>>(
        //await navigation of user then get value
        MaterialPageRoute(
          //stack pages
          builder: (ctx) => const FiltersScreen(),
        ),
      );

//no longer need to manage selected filters bec of provider
      // setState(() {
      //   _selectedFilters = result ??
      //       kInitialFilters; //checks if result is null, if so set to kInitialFilters
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealProvider);
    //final activeFilters = ref.watch(filtersProvider);
    // final availableMeals = dummyMeals.where((meal) {
    //   if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegeterian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true; //meals that i wanna keep that passed if statements
    // }).toList();

    Widget activePage = CategoriesScreen(
      //onToggleFavorites: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoritMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        //onToggleFavorites: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
