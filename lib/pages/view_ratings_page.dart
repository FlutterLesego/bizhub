// ignore_for_file: prefer_const_constructors

import 'package:bizhub/misc/constants.dart';
import 'package:bizhub/services/service_view_model.dart';
import 'package:bizhub/widgets/view_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

class ViewRatingsPage extends StatelessWidget {
  const ViewRatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.indigo),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: provider.Consumer<ServiceViewModel>(
                  builder: ((context, value, child) {
                    return Center(
                      child: Text(
                        "No reviews available",
                        style: style16Black,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
