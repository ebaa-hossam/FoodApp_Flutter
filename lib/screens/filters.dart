import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

// enum Filter {
//   glutenFree,
//   lactoseFree,
//   vegeterian,
//   vegan,
// }

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  //final Map<Filter, bool> currentFilters;

  // @override
  // ConsumerState<FiltersScreen> createState() {
  //   return _FiltersScreenState();
  // }

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  //we cant access currentFilters in here as we are in a diff class
  //we are in _FiltersScreenState class where as currentFilters in FiltersScreen class
  //so we will need widget. property to access what in widget class FiltersScreen
  //but also we cant use it here because its only available inside methods of this class
  //we will use initState method
  // var _glutenFreeFilterSet = false; // to check is switch is on or off
  // var _lactoseFreeFilterSet = false; // to check is switch is on or off
  // var _vegeterianFilterSet = false; // to check is switch is on or off
  // var _veganFilterSet = false; // to check is switch is on or off

  // @override
  // void initState() {
  //   //run before the build method dont need setState so
  //   super.initState(); //to get currentFilters and save them
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
  //   _vegeterianFilterSet = activeFilters[Filter.vegeterian]!;
  //   _veganFilterSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Filters',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement( //to replace current page with routed one
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body:
          // WillPopScope(
          //   //creates a widget that registers a callback when user click back bottom
          //   onWillPop: () async {
          //     //async to tell the function to reserve a futter value
          //     ref.read(filtersProvider.notifier).setFilters(
          //       {
          //         Filter.glutenFree: _glutenFreeFilterSet,
          //         Filter.lactoseFree: _lactoseFreeFilterSet,
          //         Filter.vegeterian: _vegeterianFilterSet,
          //         Filter.vegan: _veganFilterSet,
          //       },
          //     ); //get direct access to notifier class (setFilter method)
          //     // Navigator.of(context).pop(); //sending pop map values for switch
          //     return true; //allow flutter to pop
          //   },
          //   child:
          Column(
        children: [
          SwitchListTile(
            // list of rows
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              //instead of set state now i will use the provider
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'only include Gluten-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //when clicked color
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
          SwitchListTile(
            // list of rows
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'only include Lactose-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //when clicked color
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
          SwitchListTile(
            // list of rows
            value: activeFilters[Filter.vegeterian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegeterian, isChecked);
            },
            title: Text(
              'Vegeterian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'only include Vegeterian meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //when clicked color
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
          SwitchListTile(
            // list of rows
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'only include Vegan meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor:
                Theme.of(context).colorScheme.tertiary, //when clicked color
            contentPadding: const EdgeInsets.only(left: 32, right: 22),
          ),
        ],
      ),
    );
  }
}
