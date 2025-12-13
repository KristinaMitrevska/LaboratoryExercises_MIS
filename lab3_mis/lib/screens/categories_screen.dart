import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../services/notification_service.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar.dart';
import 'favorites_screen.dart';
import 'meals_screen.dart';
import 'random_meal_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService _api = ApiService();
  List<Category> _all = [];
  List<Category> _filtered = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    NotificationService.instance.startRepeating(seconds: 30);
  }

  void _loadCategories() async {
    final categories = await _api.fetchCategories();
    if (!mounted) return;
    setState(() {
      _all = categories;
      _filtered = categories;
      _isLoading = false;
    });
  }

  void _onSearch(String q) {
    if (q.trim().isEmpty) {
      setState(() => _filtered = _all);
      return;
    }
    final low = q.toLowerCase();
    setState(() {
      _filtered = _all
          .where((c) => c.name.toLowerCase().contains(low))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мени',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.pushNamed(context, FavoritesScreen.routeName);
            },
          ),
          ElevatedButton(
            child: const Text(
                'Рандом рецепт',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () =>
                Navigator.pushNamed(context, RandomMealScreen.routeName),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SimpleSearchBar(
                  hint: 'Пребарувај категории',
                  onChanged: _onSearch,
                  onClear: () => _onSearch(''),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final cat = _filtered[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CategoryCard(
                          category: cat,
                          onTap: () => Navigator.pushNamed(
                            context,
                            MealsScreen.routeName,
                            arguments: cat.name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
