// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/service.dart';
import '../routes/route_manager.dart';
import '../widgets/dialogs.dart';
import 'service_view_model.dart';
import 'user_view_model.dart';

// ----------helpers---------//
///
//create a new service
void createNewServiceInUI(
  BuildContext context, {
  required TextEditingController titleController,
  required TextEditingController descriptionController,
}) async {
  if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
    showSnackBar(context, "Please enter all fields", 2000);
  } else {
    Service service = Service(
        title: titleController.text.trim(),
        created: DateTime.now(),
        description: descriptionController.text.trim(),
        category: 'category',
        location:
            context.read<UserViewModel>().currentUser!.getProperty('location'),
        image: 'imagePath');
    if (context.read<ServiceViewModel>().services.contains(service)) {
      showSnackBar(context, "Service Already Exists!", 3000);
    } else {
      titleController.text = '';
      descriptionController.text = '';
      context.read<ServiceViewModel>().createService(service);
      context.read<ServiceViewModel>().saveServiceEntry(
          context.read<UserViewModel>().currentUser!.email, true);
      showSnackBar(context, 'Service added successfully!', 2000);
      Navigator.popAndPushNamed(context, RouteManager.serviceProviderPage);
    }
  }
}

////
///
//---------save all services in UI---------//

void saveAllServicesInUI(BuildContext context) async {
  String result = await context
      .read<ServiceViewModel>()
      .saveServiceEntry(context.read<UserViewModel>().currentUser!.email, true);
  if (result != 'OK') {
    showSnackBar(context, result, 3000);
  } else {
    showSnackBar(context, "Service saved successfully!", 3000);
  }
}

void refreshServicesInUI(BuildContext context) async {
  String result = await context.read<ServiceViewModel>().getServices(
        context.read<UserViewModel>().currentUser!.email,
      );
  if (result != 'OK') {
    showSnackBar(context, result, 3000);
  } else {
    showSnackBar(context, "Services Retrieved Successfully", 2000);
  }
}
