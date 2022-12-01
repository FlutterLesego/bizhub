// ignore_for_file: unnecessary_null_comparison

import 'package:bizhub/misc/constants.dart';
import 'package:bizhub/widgets/service_view.dart';
import 'package:flutter/material.dart';
import '../routes/route_manager.dart';
import '../services/service_view_model.dart';
import '../widgets/navigation_drawer.dart';
import 'package:provider/provider.dart' as provider;

class bizhubHome extends StatefulWidget {
  const bizhubHome({Key? key}) : super(key: key);

  @override
  State<bizhubHome> createState() => _bizhubHomeState();
}

class _bizhubHomeState extends State<bizhubHome> {
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
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            //search bar
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
              ),
              child: TextField(
                onChanged: (text) {
                  text = text.toLowerCase();
                  //TODO: search function
                },
                cursorColor: Colors.indigo,
                decoration: const InputDecoration(
                  labelText: 'What are you looking for?',
                  icon: Icon(Icons.search),
                  iconColor: Colors.indigo,
                ),
              ),
            ),
            const SizedBoxH10(),
            // Categories title and director
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
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: const [])),
            Row(
              children: const [
                Text(
                  "New Services",
                  style: titleStyleBlack,
                ),
              ],
            ),
            const SizedBoxH10(),
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
                            'No Services Available',
                            style: style16Black,
                          ),
                        );
                }),
              ),
            ),
            const SizedBoxH10()
          ],
        ),
      )),
    );
  }

  searchServices() {}
}
