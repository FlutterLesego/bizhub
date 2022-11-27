// ignore_for_file: unnecessary_null_comparison

import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/widgets/service_view.dart';
import 'package:flutter/material.dart';

import '../services/helper_service.dart';
import '../services/service_view_model.dart';
import '../widgets/category_view.dart';
import '../widgets/navigation_drawer.dart';
import 'package:provider/provider.dart' as provider;

class FirstAppHome extends StatefulWidget {
  const FirstAppHome({Key? key}) : super(key: key);

  @override
  State<FirstAppHome> createState() => _FirstAppHomeState();
}

class _FirstAppHomeState extends State<FirstAppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.1,
        centerTitle: true,
        title: const Text(
          "bizHub",
          style: titleStyleBlack,
        ),
        actions: [
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
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            //search bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo.shade50,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      Text(
                        'What are you looking for?',
                        style: style16grey,
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBoxH10(),
            //Categories title and director
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: titleStyleBlack,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, RouteManager.categoriesPage);
                  },
                  child: InkWell(
                    child: const Text(
                      "view all",
                      style: style16grey,
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, RouteManager.categoriesPage);
                    },
                  ),
                )
              ],
            ),
            const SizedBoxH10(),
            // services view
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const [
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                    ]))),
            Row(
              children: const [
                Text(
                  "New Services",
                  style: titleStyleBlack,
                ),
              ],
            ),
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
                              return ServiceView(
                                service: value.services[index],
                              );
                            })
                        : const Center(
                            child: Text(
                              'Services Not Yet Available',
                              style: style16Black,
                            ),
                          );
                  }),
                ),
              ),
            ),
            const SizedBoxH10()
          ],
        ),
      )),
    );
  }
}
