import 'package:flutter/material.dart';
import 'package:lab2_mis/screens/categories_screen.dart';
import 'package:lab2_mis/screens/meals_screen.dart';

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
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CategoriesScreen(),
        '/meals': (context) => const MealsScreen(),
        // '/meal': (context) => const MealDetailScreen(),
        // '/random': (context) => const RandomMealScreen(),
      },
    );
  }
}
