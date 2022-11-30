// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  XFile? imageXFile;

  String bizImageUrl = "";

  Future _pickImage(String image) async {
    imageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
      bizImageUrl = imageXFile!.path.toString();

      Backendless.files.upload((File(imageXFile!.path)), "/biz_logos");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        focusColor: Colors.white,
        splashColor: Colors.white,
        hoverColor: Colors.white,
        highlightColor: Colors.white,
        onTap: () {
          _pickImage(bizImageUrl);
        },
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.width / 5,
          backgroundColor: Colors.indigo.shade50,
          backgroundImage:
              imageXFile == null ? null : FileImage(File(imageXFile!.path)),
          child: imageXFile == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 5,
                      backgroundColor: Colors.indigo.shade50,
                      child: Image.asset(
                        "assets/images/bizhublogo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Icon(
                    //   Icons.photo_camera,
                    //   size: MediaQuery.of(context).size.width / 5,
                    // ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
