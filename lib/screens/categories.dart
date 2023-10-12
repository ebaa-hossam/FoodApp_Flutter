import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/meals.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    //required this.onToggleFavorites,
    required this.availableMeals,
  });

  //final void Function(Meal meal) onToggleFavorites;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //with to add a mixIn to a class being merged into this class behind the scenes with certain features needed by flutter animation system
  late AnimationController
      _animationController; // variable which will have a value as soon as its being used
  //

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      //explisit animation (updates the state which u can listen to mantually update the UI)
      //doesnt actually re execute the build method
      vsync: this, //this class (60 times per second if u have 60 frames)
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1, // animate between these values
    );
    //vsync wants a tickerProvider to make sure this animation executes in every frame
    //
    _animationController.forward(); //to start animation
  }

  @override
  void dispose() {
    _animationController
        .dispose(); //removed from memory after animation executes
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
//search inside availableMeals (filtered) for every meal if its categories contain the id of
//category selected/taped
//convert to a list then
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          //onToggleFavorites: onToggleFavorites,
        ),
      ),
      //navigator pushes the MealsScreen in top of current screen
      //given the filtered meals
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController, //listens to this animation controller
      //child is any widget that should be output as part of the animated content but should not be animated themselves to improve performance
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //number of columns
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, //horizontal spacing
          mainAxisSpacing: 20, //vertical spacing
        ),
        children: [
          //get category in availableCategories in dummy_data
          //and for each category send it to categoryGridItem for styling
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                }),
          //sends selected category to view wanted meals
        ],
      ),
      //   builder: (context, child) => Padding(
      //       padding: EdgeInsets.only(top: 100 - _animationController.value * 100), // 100 - to slide up not down
      //       child: child), // pading will be animated
      //   //child of padding set to gridView so padding widget only will be rebuilt and re evaluated
      // or
      builder: (context, child) => SlideTransition(
        position: // _animationController.drive(
            Tween(
          //slide with an offset from widget rather that providing well defined values
          begin: const Offset(0, 0.3), //dx , dy
          end: const Offset(0, 0),
        ).animate(
          //instead of drive
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut, //u can choose any
          ),
        ), // controls how animation is played back
        //makes it look more natural

        child: child,
      ),
    );
    //GridView Creates a scrollable, 2D array of widgets with a custom [SliverGridDelegate].
    //The [gridDelegate] argument must not be null.
  }
}
