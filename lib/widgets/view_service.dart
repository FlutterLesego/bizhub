import 'package:firstapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';

import '../misc/constants.dart';
import '../models/service.dart';

class ViewService extends StatelessWidget {
  const ViewService({required this.service, super.key});
  final Service service;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          const SizedBoxH10(),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              service.bizName,
              style: title26Indigo,
            ),
          ),
          //rating and location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: () {
                    showSnackBar(context, "show ratings", 2000);
                  },
                  icon: const Icon(Icons.star),
                  label: const Text(
                    "3,8",
                    style: style16Indigo,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
