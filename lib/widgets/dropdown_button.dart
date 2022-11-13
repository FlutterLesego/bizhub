import 'package:firstapp/widgets/dialogs.dart';
import 'package:flutter/material.dart';

class DropdownButton extends StatelessWidget {
  const DropdownButton({
    Key? key, 
    List? items}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(items: [
          DropdownMenuItem(
              onTap: () {
                showSnackBar(context, 'Button Clicked', 2500);
              },
              child: const Text("Automotive Services")),
          DropdownMenuItem(
              onTap: () {
                showSnackBar(context, 'Button Clicked', 2500);
              },
              child: const Text("Appliance Repairs")),
          DropdownMenuItem(
              onTap: () {
                showSnackBar(context, 'Button Clicked', 2500);
              },
              child: const Text("IT Services")),
        ])
      ],
    );
  }
}
