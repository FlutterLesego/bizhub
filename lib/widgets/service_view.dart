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
        color: Colors.indigo.shade50,
        child: ListTile(
          title: Container(
            margin: const EdgeInsets.only(top: 10, right: 10, bottom: 20),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white30,
                      // ignore: prefer_const_constructors
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/code_stable.png'))),
                ),
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
                              Icons.location_pin,
                              color: Colors.indigo,
                            ),
                            Text(
                              service.location,
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
      ),
    );
  }
}
