// ignore_for_file: avoid_renaming_method_parameters

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

//category map
Map<dynamic, dynamic> convertCategoryListToMap(
    List<ServiceCategory> categories) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < categories.length; i++) {
    map.addAll({'$i': categories[i].toJson()});
  }
  return map;
}

//categories list
List<ServiceCategory> convertMapToCategoryList(Map<dynamic, dynamic> map) {
  List<ServiceCategory> categories = [];
  for (var i = 0; i < map.length; i++) {
    categories.add(ServiceCategory.fromJson(map['$i']));
  }
  return categories;
}

class ServiceCategory {
  final String category;

  ServiceCategory({
    required this.category,
  });

  Map<String, Object?> toJson() => {
        'serviceCategory': category,
      };

//convert from Backendless database
  static ServiceCategory fromJson(Map<dynamic, dynamic>? json) =>
      ServiceCategory(category: json!['serviceCategory'] as String);
}
