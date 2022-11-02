// ignore_for_file: unnecessary_null_comparison

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:firstapp/view_models/service_view_model.dart';
import 'package:firstapp/view_models/user_view_model.dart';
import 'package:firstapp/widgets/app_progress_indicator.dart';
import 'package:firstapp/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';

import '../../misc/constants.dart';
import '../../routes/route_manager.dart';
import '../widgets/service_card.dart';

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
          IconButton(
              onPressed: () async {
                context.read<ServiceViewModel>().saveAllServicesInUI(context);
              },
              icon: const Icon(Icons.save)),

          ///----------------------------------------------------------------///
          // - - - - - refress icon to refresh the services in UI - - - - -//
          IconButton(
              onPressed: () async {
                context.read<ServiceViewModel>().refreshServicesInUI(context);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),

      ///--------------------------------------///
      // - - - - - navigation drawer - - - - - //
      drawer: const NavigationDrawer(),
      body: Stack(
        children: [
        SafeArea(
            child: Column(
              children: [
                const SizedBoxH20(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      provider.Selector<UserViewModel, BackendlessUser?>(
                        selector: (context, value) => value.currentUser,
                        builder: (context, value, child) {
                          return value == null
                              ? Container()
                              : Text(
                                  "${value.getProperty('name')}",
                                  style: title26Indigo,
                                );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBoxH20(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: provider.Consumer<ServiceViewModel>(
                      builder: ((context, value, child) {
                        return value != null
                            ? ListView.builder(
                                itemCount: value.services.length,
                                itemBuilder: (context, index) {
                                  return ServiceCard(
                                      service: value.services[index]);
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
            ),),
            // provider.Selector<UserViewModel, Tuple2>(
            //   selector: (context, value) =>
            //       Tuple2(value.showUserProgress, value.userProgressText),
            //   builder: (context, value, child) {
            //     return value.item1
            //         ? AppProgressIndicator(text: value.item2)
            //         : Container();
            //   },
            // ),
            // provider.Selector<ServiceViewModel, Tuple2>(
            //   selector: (context, value) =>
            //       Tuple2(value.busyRetrieving, value.busyRetrieving),
            //   builder: (context, value, child) {
            //     return value.item1
            //         ? const AppProgressIndicator(
            //             text:
            //                 'Busy retrieving data from the database... Please wait...',
            //           )
            //         :Container();
            //   },
            // )
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
