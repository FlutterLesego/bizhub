import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/material.dart';

class ServiceAdd extends StatefulWidget {
  const ServiceAdd({super.key});

  @override
  State<ServiceAdd> createState() => _ServiceAddState();
}

class _ServiceAddState extends State<ServiceAdd> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

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
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBoxH30(),
                    TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        //validator: validateEmptyTitle,
                        controller: titleController,
                        decoration: serviceFormDecoration("Title")),
                    const SizedBoxH30(),
                    TextFormField(
                        maxLines: 1,
                        minLines: 1,
                        //validator: validateEmptyDescription,
                        controller: descriptionController,
                        decoration: serviceFormDecoration("Description")),
                    const SizedBoxH20(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, RouteManager.serviceProviderPage);
                        },
                        child: const Text("Add Service"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}