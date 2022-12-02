// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_nullable, unused_import, prefer_is_empty

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bizhub/models/categoriesEntry.dart';
import 'package:bizhub/models/category.dart';
import 'package:bizhub/models/service_entry.dart';
import 'package:bizhub/routes/route_manager.dart';
import 'package:bizhub/services/user_view_model.dart';
import 'package:bizhub/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/service.dart';

class ServiceViewModel with ChangeNotifier {
  final serviceFormKey = GlobalKey<FormState>();

  ServiceEntry? _serviceEntry;

  //empty service list
  List<Service> _services = [];
  List<Service> get services => _services;

  final List<Category> _categories = [];
  List<Category> get categories => _categories;

  void emptyServices() {
    _services = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

////--------------------------------------------////
// -----get services of the service provider-----//
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
      if (map.length > 0) {
        _serviceEntry = ServiceEntry.fromJson(map.first);
        _services = convertMapToServiceList(_serviceEntry!.services);
        notifyListeners();
      } else {
        emptyServices();
      }
    } else {
      result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

////------------------------------------////
// -----save new service for a specific user-----//
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

////------------------------////
// -----adding a service-----//
  void createService(Service service) {
    _services.insert(0, service);
    notifyListeners();
  }

////--------------------------////
// -----deleting a service-----//
  void deleteService(Service service) {
    _services.remove(service);
    notifyListeners();
  }
}
