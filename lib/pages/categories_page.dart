import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, RouteManager.firstAppHomePage);
          },
        ),
        title: const Text(
          "Categories",
          style: style16White,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SafeArea(
            child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          children: const [],
        )),
      ),
    );
  }
}
