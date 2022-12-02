import 'package:bizhub/misc/constants.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class ServiceCategoryView extends StatelessWidget {
  const ServiceCategoryView({
    required this.category,
    Key? key,
  }) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width / 4,
      height: 50,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          category.categoryName,
          style: style16Indigo,
        )
      ]),
    );
  }
}
