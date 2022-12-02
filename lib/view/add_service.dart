// ignore_for_file: prefer_const_constructors

import 'package:bizhub/misc/constants.dart';
import 'package:bizhub/routes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../misc/validators.dart';
import '../services/helper_service.dart';
import '../services/service_view_model.dart';

class ServiceAdd extends StatefulWidget {
  const ServiceAdd({super.key});

  @override
  State<ServiceAdd> createState() => _ServiceAddState();
}

class _ServiceAddState extends State<ServiceAdd> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  _ServiceAddState() {
    _selectedValue = _categoriesList[0];
  }

  //list of categories
  final _categoriesList = [
    "Appliance Repairs",
    "Automobile Repairs",
    "Catering & Events",
    "Cleaning Services",
    "DSTV Services",
    "Errand Runners",
    "Events & Entertainment",
    "Gardening Services",
    "IT Services",
    "Sitters",
    "Other Services"
  ];
  String? _selectedValue = "";

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.popAndPushNamed(
                  context, RouteManager.serviceProviderPage);
            }),
        backgroundColor: Colors.indigo,
        title: const Text('Add a service', style: style16White),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: context.read<ServiceViewModel>().serviceFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBoxH30(),
                      TextFormField(
                          textCapitalization: TextCapitalization.characters,
                          validator: validateServiceTitle,
                          controller: titleController,
                          enableSuggestions: true,
                          decoration: formDecoration("Title", Icons.title)),
                      const SizedBoxH20(),
                      TextFormField(
                          validator: validateServiceDescription,
                          controller: descriptionController,
                          enableSuggestions: true,
                          decoration:
                              formDecoration("Description", Icons.description)),
                      const SizedBoxH20(),
                      //
                      //dropdown button for categories
                      DropdownButtonFormField(
                        isDense: true,
                        value: _selectedValue,
                        items: _categoriesList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (catValue) {
                          setState(() {
                            _selectedValue = catValue as String;
                          });
                        },
                        dropdownColor: Colors.indigo.shade50,
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.indigo,
                        ),
                        decoration: formDecoration(
                            "Category", Icons.miscellaneous_services),
                      ),
                      const SizedBoxH20(),
                      ElevatedButton(
                          onPressed: () {
                            createNewServiceInUI(
                              context,
                              titleController: titleController,
                              descriptionController: descriptionController,
                              categoryName: _selectedValue.toString().trim(),
                            );
                          },
                          child: const Text("Add Service"))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
