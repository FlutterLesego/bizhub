import 'package:firstapp/widgets/edit_service.dart';
import 'package:flutter/material.dart';

class EditServicePage extends StatelessWidget {
  const EditServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: ServiceEdit()),
            ),
          )
        ],
      )),
    );
  }
}
