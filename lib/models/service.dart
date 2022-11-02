// ignore_for_file: avoid_renaming_method_parameters

import 'dart:convert';
import 'dart:ffi';

Map<dynamic, dynamic> convertServiceListToMap(List<Service> services) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < services.length; i++) {
    map.addAll({'$i': services[i].toJson()});
  }
  return map;
}


//add new service
List<Service> convertMapToServiceList(Map<dynamic, dynamic> map) {
  List<Service> services = [];
  for (var i = 0; i < map.length; i++) {
    services.add(Service.fromJson(map['$i']));
  }
  return services;
}

class Service {
  final String title;
  final String description;
  final String category;
  final String location;
  final DateTime created;
  final Double? rating;
  final String image;

  Service(
      {required this.title,
      required this.created,
      required this.description,
      required this.category,
      required this.location,
      this.rating,
      required this.image});

  Map<String, dynamic> toJson() => {
        'serviceTitle': title,
        'serviceDescription': description,
        'serviceCategory': category,
        'serviceRating': rating,
        'serviceImage': image,
        'serviceLocation': location,
        'created': created.millisecondsSinceEpoch
      };

//convert from Backendless database
  static Service fromJson(Map<dynamic, dynamic>? json) => Service(
      title: json!['serviceTitle'] as String,
      description: json['serviceDescription'] as String,
      category: json['serviceCategory'] as String,
      location: json['serviceLocation'] as String,
      rating: json['serviceRating'] as Double,
      image: json['serviceImage'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(
          (json['created'] as double).toInt()));

  @override
  bool operator ==(covariant Service service) {
    return (title.toUpperCase().compareTo(service.title.toUpperCase()) == 0 ||
        description
                .toUpperCase()
                .compareTo(service.description.toUpperCase()) ==
            0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}
