// ignore_for_file: prefer_const_constructors
import 'package:bizhub/routes/route_manager.dart';
import 'package:bizhub/services/service_view_model.dart';
import 'package:bizhub/widgets/view_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

class ViewServicePage extends StatelessWidget {
  const ViewServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, RouteManager.bizhubHomePage);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: provider.Consumer<ServiceViewModel>(
                builder: ((context, value, child) {
                  return ViewService(service: value.services.first);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
