// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum BusinessTypeEnum { Registered, Unregistered }

class RadioButton extends StatelessWidget {
  RadioButton(
      {Key? key,
      required this.title,
      required this.selectedBusinessType,
      required this.value,
      required this.onChanged})
      : super(key: key);

  String title;
  BusinessTypeEnum value;
  BusinessTypeEnum? selectedBusinessType;
  Function(BusinessTypeEnum?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<BusinessTypeEnum>(
          contentPadding: const EdgeInsets.all(0.0),
          value: value,
          groupValue: selectedBusinessType,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.indigo.shade50,
          dense: true,
          title: Text(title),
          onChanged: onChanged),
    );
  }
}
