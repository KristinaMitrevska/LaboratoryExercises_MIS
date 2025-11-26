import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';

class RandomMealScreen extends StatefulWidget {
  static const routeName = '/random';
  const RandomMealScreen({super.key});

  @override
  State<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  final ApiService _api = ApiService();
  Meal? _meal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRandomMeal();
  }

  void _loadRandomMeal() async {
    final meal = await _api.randomMeal();
    if (!mounted) return;
    setState(() {
      _meal = meal;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Рандом рецепт',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
          ? const Center(child: Text('Нема рецепт'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _meal!.img,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _meal!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/meal',
                      arguments: _meal!.id,
                    ),
                    child: const Text('Отвори целосен рецепт'),
                  ),
                ],
              ),
            ),
    );
  }
}
