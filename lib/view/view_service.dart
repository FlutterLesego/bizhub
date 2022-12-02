import 'package:bizhub/widgets/dialogs.dart';
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage(service.image), fit: BoxFit.cover)),
          ),
          const SizedBoxH10(),
          Row(
            children: [
              Text(
                '${service.bizName} - ',
                style: title26Indigo,
              ),
              const SizedBoxW5(),
              Text(
                service.category,
                style: style16Black,
              ),
            ],
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
                    "0",
                    style: style16Indigo,
                  )),
              TextButton.icon(
                  onPressed: () {
                    showSnackBar(context, "show location", 2000);
                  },
                  icon: const Icon(Icons.location_pin),
                  label: Text(
                    service.location,
                    style: style16Indigo,
                  )),
            ],
          ),
          Divider(
            thickness: 1.0,
            color: Colors.indigo.shade100,
          ),
          Text(service.title, style: titleStyleBlack),
          const SizedBoxH5(),
          Text(service.description, style: style16Black),
          Divider(
            thickness: 1.0,
            color: Colors.indigo.shade100,
          ),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.call),
              label: Text(
                service.servicePhone,
                style: style16Indigo,
              )),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.email),
              label: Text(
                service.serviceEmail,
                style: style16Indigo,
              ))
        ],
      ),
    );
  }
}
