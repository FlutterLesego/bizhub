import 'package:firstapp/misc/constants.dart';
import 'package:flutter/material.dart';

class ServiceCategoryView extends StatelessWidget {
  const ServiceCategoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade50,
      margin: const EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width / 4,
      height: 50,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.electrical_services,
              color: Colors.indigo,
            ),
            Text(
              'Electrical',
              style: style16Indigo,
            )
          ]),
    );
  }
}
