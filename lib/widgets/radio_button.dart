import 'package:flutter/material.dart';

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
  final BusinessTypeEnum value;
  final BusinessTypeEnum? selectedBusinessType;
  final Function(BusinessTypeEnum?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<BusinessTypeEnum>(
        contentPadding: const EdgeInsets.all(0.0),
        value: BusinessTypeEnum.Registered,
        groupValue: selectedBusinessType,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.indigo.shade50,
        dense: true,
        title: Text(title),
        onChanged: (newValue) {
          onChanged;
        },
      ),
    );
  }
}
