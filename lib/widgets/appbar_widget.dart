import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      color: Colors.indigo,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}
