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

InputDecoration serviceFormDecoration(
  String labelText,
) {
  return InputDecoration(
    errorStyle: const TextStyle(fontSize: 10),
    errorMaxLines: 3,
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.grey),
    enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.indigo)),
    focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 2, color: Colors.indigo)),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 2, color: Colors.red)),
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
const TextStyle bold16Indigo = TextStyle(
    fontSize: 16,
    color: Colors.indigo,
    fontWeight: FontWeight.w600);

const TextStyle style16Indigo = TextStyle(
    fontSize: 16,
    color: Colors.indigo,
    fontWeight: FontWeight.w400);

const TextStyle style16White = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w300);

const TextStyle style14White = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w300);

const TextStyle style16grey = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.w300);

const TextStyle style16Black = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w300);

  const TextStyle style14Black = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w300);  

const TextStyle title26Indigo = TextStyle(
    color: Colors.indigo,
    fontSize: 26,
    fontWeight: FontWeight.bold);

const TextStyle titleStyleIndigo = TextStyle(
    color: Colors.indigo,
    fontSize: 36,
    fontWeight: FontWeight.bold);


const TextStyle titleStyleBlack = TextStyle(
    fontFamily: "",
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold);

const TextStyle titleStyle26 = TextStyle(
    color: Colors.indigo,
    fontSize: 26,
    fontWeight: FontWeight.bold);
