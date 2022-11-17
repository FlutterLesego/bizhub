import 'dart:io';

import 'package:firstapp/misc/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({
    Key? key,
  }) : super(key: key);

  XFile? imageXFile;
  String bizImageUrl = "";

  Future _pickImage() async {
    imageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
          _pickImage();
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
                    Icon(
                      Icons.photo_camera,
                      size: MediaQuery.of(context).size.width / 5,
                    ),
                    const Text(
                      "Biz Logo",
                      style: style16grey,
                    )
                  ],
                )
              : null,
        ),
      ),
    );
  }

  // buildImage() {
  //   return ClipOval(
  //     child: Material(
  //       color: Colors.indigo.shade50,
  //       child: Ink.image(
  //         image: _getImage(),
  //         fit: BoxFit.cover,
  //         width: 128,
  //         height: 128,
  //         child: InkWell(
  //           onTap: onClicked,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildEditIcon(Color color) => buildCircle(
  //     color: color,
  //     all: 8,
  //     child: const Icon(
  //       Icons.add_a_photo,
  //       size: 20,
  //       color: Colors.white,
  //     ));

  // Widget buildCircle(
  //         {required Color color, required int all, required Icon child}) =>
  //     ClipOval(
  //       child: Container(
  //         padding: const EdgeInsets.all(8.0),
  //         color: color,
  //         child: child,
  //       ),
  //     );
}
