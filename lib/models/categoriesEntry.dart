class CategoryEntry {
  Map<dynamic, dynamic> categories; //list of categories

  CategoryEntry({
    required this.categories,
  });

  Map<String, Object?> toJson() => {
        'categories': categories,
      };

  static CategoryEntry fromJson(Map<dynamic, dynamic>? json) => CategoryEntry(
        categories: json!['categories'] as Map<dynamic, dynamic>,
      );
}
