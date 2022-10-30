// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_nullable

import 'dart:js';

import 'package:backendless_sdk/backendless_sdk.dart';
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

//get services of the user
  Future<String> getServices(String username) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

    _busyRetrieving = true;
    notifyListeners();

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('ServiceEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    //check if there is an error and show it
    if (result != 'OK') {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }

    //convert map and save it into the service entry
    if (map != null) {
      if (map.isNotEmpty) {
        _serviceEntry = ServiceEntry.fromJson(map.first);
        _services = convertMapToServiceList(_serviceEntry!.services);
        notifyListeners();
      } else {
        _services = [];
        notifyListeners();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

////
  ///
//----------save services in our database----------//
  ///
////
  Future<String> saveServiceEntry(String username, bool inUI) async {
    String result = 'OK';
    if (_serviceEntry == null) {
      _serviceEntry = ServiceEntry(
          services: convertServiceListToMap(_services), username: username);
    } else {
      _serviceEntry!.services = convertServiceListToMap(_services);
    }

    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }
    await Backendless.data
        .of('ServiceEntry')
        .save(_serviceEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }

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
    }
  }

  ////
  ///
  //---------save all services in UI---------//

  void saveAllServicesInUI(BuildContext context) async {
    String result = await context.read<ServiceViewModel>().saveServiceEntry(
        context.read<UserViewModel>().currentUser!.email, true);
    if (result != 'OK') {
      showSnackBar(context, result, 3000);
    } else {
      showSnackBar(context, "Service saved successfully!", 3000);
    }
  }

////
  ///
//get services in Ui
  void getServicesInUI(BuildContext context) async {
    String result = await context
        .read<ServiceViewModel>()
        .getServices(context.read<UserViewModel>().currentUser!.email);
    if (result != 'OK') {
      showSnackBar(context, result, 35000);
    } else {
      showSnackBar(context, "Services Retrieved Successfully!", 3000);
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
