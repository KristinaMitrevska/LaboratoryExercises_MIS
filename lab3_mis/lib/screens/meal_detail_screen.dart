import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal';
  const MealDetailScreen({super.key});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Meal? _meal;
  final ApiService _api = ApiService();
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMealDetails();
  }

  void _loadMealDetails() async {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final mealDetails = await _api.lookupMealById(id);

    if (!mounted) return;
    setState(() {
      _meal = mealDetails;
      _isLoading = false;
    });
  }

  Widget _buildIngredients(Map<String, String> ing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ing.entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Text(
                  "${e.key} — ${e.value}",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _tableRow(String label, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: content),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Рецепт",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No Meal details found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      _meal!.img,
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    _meal!.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${_meal!.area ?? ''} • ${_meal!.category ?? ''}",
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _tableRow(
                          "Состојки",
                          _buildIngredients(_meal!.ingredients),
                        ),
                        Divider(color: Colors.grey.shade300, height: 1),
                        _tableRow(
                          "Инструкции",
                          Text(
                            _meal!.instructions ?? '',
                            style: const TextStyle(fontSize: 15, height: 1.45),
                          ),
                        ),
                        Divider(color: Colors.grey.shade300, height: 1),
                        if (_meal!.youtube != null &&
                            _meal!.youtube!.isNotEmpty)
                          _tableRow(
                            "YouTube",
                            SelectableText(
                              _meal!.youtube!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
