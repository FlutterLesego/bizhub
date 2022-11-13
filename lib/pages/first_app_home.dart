// ignore_for_file: unnecessary_null_comparison

import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/widgets/service_view.dart';
import 'package:flutter/material.dart';

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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       "first app",
    //       style: style16White,
    //     ),
    //     actions: [
    //       IconButton(
    //           onPressed: () {
    //             context.read<UserViewModel>().logoutUserInUI(context);
    //           },
    //           icon: const Icon(Icons.exit_to_app))
    //     ],
    //   ),
    //   body: const Center(child: Text("Home Screen!")),
    // );
    return Scaffold(
      drawer: const NavigationDrawer(),
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
      ),

      body: SafeArea(
          child: ListView(
        children: [
          Container(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
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
                const SizedBoxH20(),
                //title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: const InkWell(
                        child: Text(
                          "view all",
                          style: style16grey,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBoxH20(),
                //bus companies view
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                      ServiceCategoryView(),
                    ],
                  ),
                ),
                const SizedBoxH20(),
                Row(
                  children: const [
                    Text(
                      "New Services",
                      style: titleStyleBlack,
                    ),
                  ],
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
                                physics: const BouncingScrollPhysics(),
                                itemCount: value.services.length,
                                itemBuilder: (context, index) {
                                  return ServiceView(
                                      service: value.services[index]);
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
          )
        ],
      )),

      // bottomSheet: DraggableScrollableSheet(
      //               initialChildSize: 0.2,
      //               minChildSize: 0.1,
      //               maxChildSize: 0.4,
      //               builder: (BuildContext context,
      //                   ScrollController scrollController) {
      //                 return SingleChildScrollView(
      //                   controller: scrollController,
      //                   child: Container(
      //                     color: Colors.indigo,
      //                     child: ListView.builder(
      //                       controller: scrollController,
      //                       itemBuilder: (BuildContext context, int index){
      //                       return ListTile(title: Text('Item $index'));
      //                     }))

      //                 );
      //               }),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.house,
      //       color: Colors.deepPurple,),
      //       label: "home"),
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.magnifyingGlass,
      //       color: Colors.deepPurple,),
      //       label: "search"),
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.receipt,
      //       color: Colors.deepPurple,),
      //       label: "history"),
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.user,
      //       color: Colors.deepPurple,),
      //       label: "profile")
      //   ]),
    );
  }
}
