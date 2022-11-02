import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/models/service.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);
  final Service service;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            service.title,
            style: bold16Indigo
          ),
          subtitle: Text(service.location,
          style: style14Black),
          onTap: (){
          },
        ),
      ),
    );
  }
}
