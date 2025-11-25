import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_bar.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final ApiService _api = ApiService();
  late Future<List<Meal>> _future;
  List<Meal> _all = [];
  List<Meal> _filtered = [];
  String _category = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      _category = arg;
      _future = _api.fetchMealsByCategory(_category);
      _future.then((value) {
        setState(() {
          _all = value;
          _filtered = value;
        });
      });
    }
  }

  void _onSearch(String q) async {
    if (q.trim().isEmpty) {
      setState(() => _filtered = _all);
      return;
    }
    final low = q.toLowerCase();
    final local = _all.where((m) => m.name.toLowerCase().contains(low)).toList();

    try {
      final remote = await _api.searchMeals(q);
      final remoteFiltered = remote.where((m) => m.category == _category).toList();
      final merged = {for (var m in local) m.id: m};
      for (var m in remoteFiltered) {
        merged[m.id] = m;
      }
      setState(() => _filtered = merged.values.toList());
    } catch (_) {
      setState(() => _filtered = local);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Јадења: $_category')),
      body: FutureBuilder<List<Meal>>(
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
              SimpleSearchBar(hint: 'Пребарувај јадења', onChanged: _onSearch, onClear: () => _onSearch('')),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        onTap: () async {
                          //Navigator.pushNamed(context, MealDetailScreen.routeName, arguments: meal.id);
                        },
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