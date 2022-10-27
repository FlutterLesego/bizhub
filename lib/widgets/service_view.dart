import 'package:flutter/material.dart';

import '../misc/constants.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height/6,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white30,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/code_stable.png"
                        )
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        )
                      ),
                      child: Padding(padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                             Text("Visual Studio Code",
                              style: style16Black,
                              overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                          const SizedBoxH10(),
                          Row(
                            children: const [
                             Text("IT Services",
                              style: style16grey,),
                            ],
                          ),
                          const SizedBoxH10(),
                          Row(
                            children: const [
                              Icon(Icons.person_pin_circle,
                              color: Colors.indigo,),
                              Text("Hilton, Bloemfontein")
                            ],
                          )
                        ],
                      ),),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
