import 'package:flutter/material.dart';
import 'package:lab3_mis/screens/categories_screen.dart';
import 'package:lab3_mis/screens/meal_detail_screen.dart';
import 'package:lab3_mis/screens/meals_screen.dart';
import 'package:lab3_mis/screens/random_meal_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
