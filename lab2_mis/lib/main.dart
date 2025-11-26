import 'package:flutter/material.dart';
import 'package:lab2_mis/screens/categories_screen.dart';
import 'package:lab2_mis/screens/meal_detail_screen.dart';
import 'package:lab2_mis/screens/meals_screen.dart';
import 'package:lab2_mis/screens/random_meal_screen.dart';

void main() {
  runApp(const MealApp());
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const CategoriesScreen(),
        '/meals': (context) => const MealsScreen(),
        '/meal': (context) => const MealDetailScreen(),
        '/random': (context) => const RandomMealScreen(),
      },
    );
  }
}
