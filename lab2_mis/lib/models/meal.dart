class Meal {
  final String id;
  final String name;
  final String img;
  final String? category;
  final String? area;
  final String? instructions;
  final String? youtube;
  final Map<String, String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.img,
    this.category,
    this.area,
    this.instructions,
    this.youtube,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    final Map<String, String> ingr = {};
    for (int i = 1; i <= 20; i++) {
      final ing = json['strIngredient\$i'];
      final meas = json['strMeasure\$i'];
      if (ing != null && ing.toString().trim().isNotEmpty) {
        ingr[ing.toString()] = (meas ?? '').toString();
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      img: json['strMealThumb'] ?? '',
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      youtube: json['strYoutube'],
      ingredients: ingr,
    );
  }

  factory Meal.fromFilterJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      img: json['strMealThumb'] ?? '',
      ingredients: {},
    );
  }
}