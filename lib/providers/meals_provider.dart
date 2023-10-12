import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

//creating a variable to store provider objects that
//receives a ref and return dynamic data or cross widget state
//we can use it in widgets that needs this data provided
final mealsProvider = Provider((ref) {
  return dummyMeals; //if you have static data(never changes)
});

//to use this provider in widgets
//we need to import flutter_riverpod and provider
//extend ConsumerStatefullWidget instead of StatefullWidget
//+ extend ConsumerState<> instead of State<>
//we have ref. property available like widget. before
//ref.read() to get data from our provider once
//ref.watch() to make sure build method executes again as our data changes
//watch() needs a Provider parameter and returns the data from provider that its listening
//not enough tho
//you will have to go to main.dart
//import flutter_riverpod
//wrapp the App() in runApp with child of providerScope() widget
//
//
// or extend ConsumerWidget instead of StatelessWidget
//inside build accept WidgetRef ref also not just context
//to listen to providers and change those values

