import 'dart:convert';

class ServiceEntry {
  Map<dynamic, dynamic> services; //list of services
  String username;
  String? objectId;
  DateTime? created;
  DateTime? updated;

  ServiceEntry({
    required this.services,
    required this.username,
    this.objectId,
    this.created,
    this.updated,
  });

  Map<String, Object?> toJson() => {
        'username': username,
        'services': services,
        'created': created,
        'updated': updated,
        'objectId': objectId,
      };

  static ServiceEntry fromJson(Map<dynamic, dynamic>? json) => ServiceEntry(
    username: json!['username'] as String,
    services: json['services'] as Map<dynamic, dynamic>,
    objectId: json['objectId'] as String,
    created: json['created'] as DateTime,
    updated: json['updated'] as DateTime
  );
}
