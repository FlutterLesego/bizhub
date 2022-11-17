import 'package:firstapp/misc/constants.dart';
import 'package:flutter/material.dart';

class ServiceCategoryView extends StatelessWidget {
  const ServiceCategoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.grey.shade50,
      child: ListTile(
        title: const Text("IT Services", style: style16Indigo),
        // subtitle: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(service.category, style: style16Black),
        //     Row(
        //       children: [
        //         const Icon(
        //           Icons.location_pin,
        //           color: Colors.indigo,
        //         ),
        //         const SizedBoxH30(),
        //         Text(service.location,
        //             style: style14Black, overflow: TextOverflow.ellipsis),
        //       ],
        //     ),
        //   ],
        // ),
        onTap: () {},
      ),
    );
  }
}
