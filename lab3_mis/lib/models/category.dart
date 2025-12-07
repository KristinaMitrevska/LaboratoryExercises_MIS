class Category{
  final String id;
  final String name;
  final String img;
  final String description;

  Category({required this.id, required this.name, required this.img, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'] ?? '',
      name: json['strCategory'] ?? '',
      img: json['strCategoryThumb'] ?? '',
      description: json['strCategoryDescription'] ?? '',
    );
  }
}