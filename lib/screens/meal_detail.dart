import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorities_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
    // required this.onToggleFavorites,
  });

  final Meal meal;
  //final void Function(Meal meal) onToggleFavorites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoritMealsProvider); // to swap fav icon
    final isFavorite = favoriteMeals
        .contains(meal); //checks if list of fav meals contain this meal

    var counter = 1; //for numbering steps list in meals.steps

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              //onToggleFavorites(meal);
              final wasAdded = ref
                  .read(favoritMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal); //listen to notifier class

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Marked as Favorite!'
                      : 'Removed from Favorites'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                //creates and start animation whenever child changes
                return RotationTransition(
                  turns: Tween(
                    begin: 0.8,
                    end: 1.0, //or set Tween to <double>
                  ).animate(animation), //to control rotation
                  child: child,
                ); //rotates child stated which is the icon
              }, //state what to do with the icon
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(
                    isFavorite), //stating the key helps flutter to notice changes made so it can do the animation
              ),
            ), //implicit animation
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              // same widget
              tag: meal.id, //same tag in meal_item . dart
              child: Image.network(
                //image i wanna animate
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 3,
                ),
                child: Text(
                  '${counter++}-  $step',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
