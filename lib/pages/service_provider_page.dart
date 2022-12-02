// ignore_for_file: unnecessary_null_comparison

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bizhub/widgets/biz_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';
import '../../misc/constants.dart';
import '../../routes/route_manager.dart';
import '../services/helper_service.dart';
import '../services/service_view_model.dart';
import '../services/user_view_model.dart';
import '../view/service_card.dart';
import '../widgets/app_progress_indicator.dart';

class ServiceProviderPage extends StatefulWidget {
  const ServiceProviderPage({super.key});

  @override
  State<ServiceProviderPage> createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // - - - - - top app bar - - - - - //
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "bizHub",
          style: titleStyleBlack,
        ),
        actions: [
          ///--------------------------------------------------------///
          // - - - - - save icon to save the services in UI - - - - -//
          // IconButton(
          //     onPressed: () async {
          //       saveAllServicesInUI(context);
          //     },
          //     icon: const Icon(Icons.save)),

          ///----------------------------------------------------------------///
          // - - - - - refress icon to refresh the services in UI - - - - -//
          IconButton(
              onPressed: () async {
                refreshServicesInUI(context);
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.indigo,
              ))
        ],
      ),

      ///--------------------------------------///
      // - - - - - navigation drawer - - - - - //
      drawer: const BizNavigationDrawer(),
      body: Stack(children: [
        SafeArea(
          child: Column(
            children: [
              const SizedBoxH20(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                //title
                child: Row(
                  children: [
                    provider.Selector<UserViewModel, BackendlessUser?>(
                      selector: (context, value) => value.currentUser,
                      builder: (context, value, child) {
                        return const Text(
                          "My Services",
                          style: titleStyleBlack,
                        );
                      },
                    )
                  ],
                ),
              ),
              //listing the services of the business
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: provider.Consumer<ServiceViewModel>(
                    builder: ((context, value, child) {
                      return value != null
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.services.length,
                              itemBuilder: (context, index) {
                                return ServiceCard(
                                  service: value.services[index],
                                  deleteAction: () {
                                    context
                                        .read<ServiceViewModel>()
                                        .deleteService(value.services[index]);
                                  },
                                );
                              })
                          : const Center(
                              child: Text(
                                'No services to display',
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
      ]),
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
