// ignore_for_file: avoid_renaming_method_parameters

//category map
Map<dynamic, dynamic> convertCategoryListToMap(List<Category> categories) {
  Map<dynamic, dynamic> map = {};
  return map;
}

//categories list
List<Category> convertMapToCategoryList(Map<dynamic, dynamic> map) {
  List<Category> categories = [];
  return categories;
}

class Category {
  final String categoryName;

  Category({
    required this.categoryName,
  });

  Map<String, Object?> toJson() => {
        'categoryName': categoryName,
      };

//convert from Backendless database
  static Category fromJson(Map<dynamic, dynamic>? json) =>
      Category(categoryName: json!['categoryName'] as String);
}
