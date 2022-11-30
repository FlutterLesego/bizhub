import 'package:firstapp/misc/constants.dart';
import 'package:firstapp/models/service.dart';
import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {Key? key, required this.service, required this.deleteAction})
      : super(key: key);
  final Service service;
  final Function() deleteAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      child: Slidable(
        endActionPane: ActionPane(motion: const BehindMotion(), children: [
          SlidableAction(
            icon: Icons.delete,
            foregroundColor: Colors.indigo,
            onPressed: (BuildContext context) {
              deleteAction;
            },
          ),
          SlidableAction(
            icon: Icons.edit,
            foregroundColor: Colors.indigo,
            onPressed: (BuildContext context) {
              Navigator.popAndPushNamed(context, RouteManager.editServicePage);
            },
          )
        ]),
        child: ListTile(
          title: Text(service.title, style: bold16Indigo),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service.category, style: style16Black),
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.indigo,
                  ),
                  const SizedBoxH30(),
                  Text(service.location,
                      style: style14Black, overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
