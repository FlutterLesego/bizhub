import 'package:flutter/material.dart';

InputDecoration formDecoration(String labelText, IconData iconData) {
  return InputDecoration(
    errorStyle: const TextStyle(fontSize: 10),
    prefixIcon: Icon(
      iconData,
      color: Colors.indigoAccent,
    ),
    errorMaxLines: 3,
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.grey),
    enabledBorder: enabledBorder,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
  );
}

const enabledBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    borderSide: BorderSide(width: 1, color: Colors.indigoAccent));

const focusedBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 2, color: Colors.indigoAccent));

const errorBorder = UnderlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 2, color: Colors.red));

//Divider box
class SizedBoxH10 extends StatelessWidget {
  const SizedBoxH10({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class SizedBoxH20 extends StatelessWidget {
  const SizedBoxH20({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class SizedBoxH30 extends StatelessWidget {
  const SizedBoxH30({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}

//text styles
const TextStyle style16Indigo = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 16,
    color: Colors.indigo,
    fontWeight: FontWeight.w200);

const TextStyle style16White = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w200);

const TextStyle style16Black = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w300);


const TextStyle titleStyleIndigo = TextStyle(
    fontFamily: "Montserrat",
    color: Colors.indigo,
    fontSize: 36,
    fontWeight: FontWeight.w300);
