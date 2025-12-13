import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../widgets/meal_card.dart';
import '../models/meal.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites';

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> favorites = FavoritesService.instance.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Омилени рецепти",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "Немате омилени рецепти",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final meal = favorites[index];

            return MealCard(
              meal: meal,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MealDetailScreen.routeName,
                  arguments: meal.id,
                ).then((_) {
                  setState(() {});
                });
              },

              isFavorite: true,

              onFavorite: () {
                setState(() {
                  FavoritesService.instance.toggleFavorite(meal);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
