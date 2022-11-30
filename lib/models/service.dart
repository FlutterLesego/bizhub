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
  final String bizName;
  final String title;
  final String description;
  final String category;
  final String location;
  final String servicePhone;
  final String serviceEmail;
  final DateTime created;
  final DateTime? updated;
  final String image;

  Service(
      {required this.bizName,
      required this.title,
      required this.created,
      this.updated,
      required this.description,
      required this.category,
      required this.location,
      required this.servicePhone,
      required this.serviceEmail,
      required this.image});

  Map<String, Object?> toJson() => {
        'bizName': bizName,
        'serviceTitle': title,
        'serviceDescription': description,
        'serviceCategory': category,
        'serviceImage': image,
        'serviceLocation': location,
        'servicePhone': servicePhone,
        'serviceEmail': serviceEmail,
        'created': created.millisecondsSinceEpoch,
        'updated': created.millisecondsSinceEpoch
      };

//convert from Backendless database
  static Service fromJson(Map<dynamic, dynamic>? json) => Service(
      title: json!['serviceTitle'] as String,
      bizName: json['bizName'] as String,
      description: json['serviceDescription'] as String,
      category: json['serviceCategory'] as String,
      location: json['serviceLocation'] as String,
      servicePhone: json['servicePhone'] as String,
      serviceEmail: json['serviceEmail'] as String,
      image: json['serviceImage'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(
          (json['created'] as double).toInt()),
      updated: DateTime.fromMillisecondsSinceEpoch(
          (json['updated'] as double).toInt()));

  @override
  bool operator ==(covariant Service service) {
    return (title.toUpperCase().compareTo(service.title.toUpperCase()) == 0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}
