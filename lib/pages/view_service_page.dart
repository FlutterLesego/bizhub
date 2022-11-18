// ignore_for_file: prefer_const_constructors

import 'package:firstapp/misc/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewServicePage extends StatelessWidget {
  const ViewServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.indigo),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          //image container
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBoxH10(),
              //bizName
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "bizHub",
                  style: title26Indigo,
                ),
              ),
              //rating and location  header
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.star),
                      label: Text(
                        "4.0",
                        style: style16Indigo,
                      ),
                      onPressed: () {},
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.location_pin),
                      label: Text(
                        "Willows",
                        style: style16Indigo,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBoxH10(),
              //service title header
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Cellphone Repairs",
                  style: titleStyleBlack,
                ),
              ),
              SizedBoxH5(),
              //service description header
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Cellphone Repairs",
                  style: style14Black,
                ),
              ),
              Divider(
                indent: 25,
                endIndent: 25,
                color: Colors.indigo.shade200,
              ),
              //contact deatils of the service provider
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.call),
                      label: Text(
                        "061 234 5678",
                        style: style16Indigo,
                      ),
                      onPressed: () {},
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.mail),
                      label: Text(
                        "me@info.com",
                        style: style16Indigo,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBoxH10(),
              //request callback button
              Center(
                child: CupertinoButton(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.indigo,
                    child: const Text(
                      'Request Callback',
                      style: style16White,
                    ),
                    onPressed: () {}),
              ),
            ],
          )
        ],
      )),
    );
  }
}
