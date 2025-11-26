import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const String _base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$_base/categories.php');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      final List categories = data['categories'] ?? [];
      return categories
          .map((c) => Category.fromJson(c))
          .cast<Category>()
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final url = Uri.parse('$_base/filter.php?c=$category');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromFilterJson(m)).cast<Meal>().toList();
    } else {
      throw Exception('Failed to load meals for category');
    }
  }

  Future<Meal?> lookupMealById(String id) async {
    final url = Uri.parse('$_base/lookup.php?i=$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      if (meals.isNotEmpty) {
        return Meal.fromJson(meals.first);
      }
      return null;
    } else {
      throw Exception('Failed to lookup meal');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    final url = Uri.parse('$_base/search.php?s=$query');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).cast<Meal>().toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }

  Future<Meal?> randomMeal() async {
    final url = Uri.parse('$_base/random.php');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(res.body);
      final List meals = data['meals'] ?? [];
      if (meals.isNotEmpty) return Meal.fromJson(meals.first);
    }
    return null;
  }
}
