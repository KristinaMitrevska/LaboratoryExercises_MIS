import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_bar.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final ApiService _api = ApiService();
  List<Meal> _all = [];
  List<Meal> _filtered = [];
  bool _isSearching = false;
  String _category = '';
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      _category = arg;
      _loadMeals();
    }
  }

  void _loadMeals() async {
    final meals = await _api.fetchMealsByCategory(_category);
    if (!mounted) return;
    setState(() {
      _all = meals;
      _filtered = meals;
      _isLoading = false;
    });
  }

  Future<void> _onSearch(String name) async {
    if (name.isEmpty) {
      setState(() {
        _filtered = _all;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final List<Meal> meals = await _api.searchMeals(name);

    setState(() {
      _isSearching = false;
      _filtered = meals.where((m) => m.category == _category).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SimpleSearchBar(
                  hint: 'Пребарувај јадења',
                  onChanged: _onSearch,
                  onClear: () => _onSearch(''),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final meal = _filtered[index];
                        return MealCard(
                          meal: meal,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MealDetailScreen.routeName,
                              arguments: meal.id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
