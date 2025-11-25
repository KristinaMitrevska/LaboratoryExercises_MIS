import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService _api = ApiService();
  late Future<List<Category>> _future;
  List<Category> _all = [];
  List<Category> _filtered = [];

  @override
  void initState() {
    super.initState();
    _future = _api.fetchCategories();
    _future.then((value) {
      setState(() {
        _all = value;
        _filtered = value;
      });
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
          .toList();    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Категории'),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.shuffle),
            //   tooltip: 'Рандом рецепт',
            //   onPressed: () => Navigator.pushNamed(context, RandomMealScreen.routeName),
            // ),
          ],
        ),
        body: FutureBuilder<List<Category>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Грешка: ${snapshot.error}'));
              }

              return Column(
                  children: [
                    SimpleSearchBar(hint: 'Пребарувај категории', onChanged: _onSearch, onClear: () => _onSearch('')),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: _filtered.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final cat = _filtered[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CategoryCard(category: cat, onTap: () => Navigator.pushNamed(context, MealsScreen.routeName, arguments: cat.name),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
              );
            },
        ),
    );
  }
}