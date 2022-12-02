// ignore_for_file: unnecessary_null_comparison

import 'package:bizhub/misc/constants.dart';
import 'package:bizhub/routes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../services/service_view_model.dart';
import '../view/service_view.dart';

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
            Navigator.popAndPushNamed(context, RouteManager.bizhubHomePage);
          },
        ),
        title: const Text(
          "Categories",
          style: style16White,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: provider.Consumer<ServiceViewModel>(
                  builder: ((context, value, child) {
                    return value != null
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: value.services.length,
                            itemBuilder: (context, index) {
                              return ServiceView(
                                service: value.services[index],
                              );
                            })
                        : const Center(
                            child: Text(
                              'Categories Unavailable',
                              style: style16Black,
                            ),
                          );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
