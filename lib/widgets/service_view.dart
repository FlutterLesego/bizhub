// ignore_for_file: must_be_immutable, prefer_const_constructors, duplicate_ignore

import 'package:firstapp/models/service.dart';
import 'package:firstapp/routes/route_manager.dart';
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
    return InkWell(
      onTap: () {
        Navigator.popAndPushNamed(context, RouteManager.viewServicePage);
      },
      child: Card(
        color: Colors.grey.shade100,
        child: ListTile(
          title: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white30,
                    // ignore: prefer_const_constructors
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(service.image))),
              ),
              const SizedBoxW5(),
              Expanded(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            service.bizName,
                            style: titleStyleBlack,
                          ),
                          Text(
                            service.category,
                            style: style14Black,
                          )
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          Text(
                            service.title,
                            style: style16Black,
                          ),
                        ],
                      ),
                      const SizedBoxH10(),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.indigo,
                          ),
                          Text(
                            service.location,
                            style: style16Black,
                            overflow: TextOverflow.ellipsis,
                          )
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
