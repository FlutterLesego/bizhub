// ignore_for_file: use_build_context_synchronously

import 'dart:js';

import 'package:firstapp/models/service_entry.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:firstapp/view_models/user_view_model.dart';
import 'package:firstapp/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/service.dart';

class ServiceViewModel with ChangeNotifier {
  final serviceFormKey = GlobalKey<FormState>();

  ServiceEntry? _serviceEntry;

  //empty service list
  List<Service> _services = [];
  List<Service> get services => _services;

  void emptyServices() {
    _services = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  Future<String> getServices(String username) async {
    String result = 'OK';
    return result;
  }

  Future<String> saveServiceEntry(String username, bool inUI) async {
    String result = 'OK';
    return result;
  }

// ----------helpers---------//
  ///
//create a new service
  void createNewServiceInUI(
    BuildContext context, {
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  }) async {
    if (serviceFormKey.currentState?.validate() ?? false) {
      Service service = Service(
          title: titleController.text.trim(),
          created: DateTime.now(),
          description: descriptionController.text.trim(),
          category: '',
          image: 'image');
      if (context.read<ServiceViewModel>().services.contains(service)) {
        showSnackBar(context, "Service Already Exists!", 3000);
      } else {
        titleController.text = '';
        context.read<ServiceViewModel>().createService(service);
        Navigator.popAndPushNamed(context, RouteManager.serviceProviderPage);
      }
      // context
      //     .read<ServiceViewModel>()
      //     .saveService(context.read<UserViewModel>().currentUser!.email, true);
      // Service service = Service(
      //     title: titleController.toString(),
      //     created: created,
      //     description: descriptionController.toString(),
      //     category: category,
      //     rating: rating,
      //     image: image);
      // if (context.read<ServiceViewModel>().services.contains(service)) {
      //   showSnackBar(
      //       context, 'Service with the same title already exists', 4000);
      // } else {
      //   context.read<UserViewModel>().currentUser!.email.toString().trim();
      //   titleController.text = '';
      //   descriptionController.text = '';
      //   context.read<ServiceViewModel>().createService(service);
      //   context.read<ServiceViewModel>().saveService(
      //       context.read<ServiceViewModel>().currentUser!.email, true);
      //   Navigator.pop(context);
      //   showSnackBar(context, "Service added successfully!", 3500);
      // }
    }
  }

////
  ///
//get services in Ui
  void getServicesInUI(BuildContext context) async {
    String result = await context
        .read<ServiceViewModel>()
        .getServices(context.read<ServiceViewModel>().currentUser!.email);
    if (result != 'OK') {
      showSnackBar(context, "Services Retrieved Successfully!", 35000);
    }
  }

////
  ///
//add a new service
  void createService(Service service) {
    _services.insert(0, service);
    notifyListeners();
  }

  ///
//delete service method
  void deleteService(Service service) {
    _services.remove(service);
    notifyListeners();
  }

  ///
//edit a service
  void editService(int index) {}
}
