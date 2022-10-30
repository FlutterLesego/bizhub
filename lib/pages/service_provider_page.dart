import 'package:firstapp/view_models/service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/constants.dart';
import '../../routes/route_manager.dart';
import '../../widgets/service_view.dart';

class ServiceProviderPage extends StatefulWidget {
  const ServiceProviderPage({super.key});

  @override
  State<ServiceProviderPage> createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_rounded,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "bizHub",
          style: titleStyleBlack,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                context.read<ServiceViewModel>().refreshServicesInUI(context);
              },
              icon: const Icon(Icons.refresh,
              color: Colors.indigo,))
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                //search bar
                const SizedBoxH20(),
                Row(
                  children: const [
                    Text(
                      "Services",
                      style: titleStyleBlack,
                    ),
                  ],
                ),
                const SizedBoxH20(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: const [
                      ServiceView(),
                      SizedBoxH10(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.popAndPushNamed(context, RouteManager.serviceAddPage);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
