import 'package:firstapp/misc/constants.dart';
import 'package:flutter/material.dart';

class ServiceCategoryView extends StatelessWidget {
  const ServiceCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: MediaQuery.of(context).size.width / 5.5,
      height: 100,
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, children: const [
              Icon(Icons.electrical_services,
              color: Colors.indigo,),
              Text(
                  'Electrical',
                  style: style16Indigo,
                )
              ]
            ),
    );
  }
}
