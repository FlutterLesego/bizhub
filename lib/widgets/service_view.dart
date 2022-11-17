// ignore_for_file: must_be_immutable

import 'package:firstapp/models/service.dart';
import 'package:flutter/material.dart';
import '../misc/constants.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({
    Key? key,
    required this.service,
  }) : super(key: key);
  final Service service;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      child: ListTile(
        title: Container(
          margin:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white30,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('$service.imagePath'))),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            service.bizName,
                            style: style16Black,
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          Text(
                            service.title,
                            style: style16grey,
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          const Icon(
                            Icons.person_pin_circle,
                            color: Colors.indigo,
                          ),
                          Text(service.location, overflow: TextOverflow.clip)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
