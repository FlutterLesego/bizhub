// ignore_for_file: deprecated_member_use, prefer_const_constructors
import 'dart:io';
import 'package:firstapp/misc/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../misc/validators.dart';
import '../services/helper_user.dart';
import 'radio_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController bizNameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController cipcNumberController;
  late TextEditingController idNumberController;
  BusinessTypeEnum? _businessTypeEnum;

  XFile? imageXFile;

  String bizImageUrl = "";

  Future _pickImage() async {
    imageXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
      bizImageUrl = imageXFile!.path.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    bizNameController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    cipcNumberController = TextEditingController();
    idNumberController = TextEditingController();
  }

  @override
  void dispose() {
    bizNameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    cipcNumberController.dispose();
    idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: InkWell(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 5,
                  backgroundColor: Colors.indigo.shade50,
                  backgroundImage: imageXFile == null
                      ? null
                      : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: MediaQuery.of(context).size.width / 5,
                            )
                          ],
                        )
                      : null,
                ),
              )),
              const SizedBoxH10(),
              TextFormField(
                validator: validateBizName,
                controller: bizNameController,
                decoration: formDecoration(
                  "Biz Name",
                  Icons.person_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validateEmail,
                controller: emailController,
                decoration: formDecoration(
                  "Email Address",
                  Icons.mail_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validatePhone,
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: formDecoration(
                  "Phone Number",
                  Icons.phone_outlined,
                ),
              ),
              const SizedBoxH10(),
              //
              //business type radio
              //Registered business button
              //
              const Text(
                "Business Registration Type",
                style: style14grey,
              ),
              const SizedBoxH5(),
              Row(
                children: [
                  RadioButton(
                      title: BusinessTypeEnum.Registered.name,
                      selectedBusinessType: _businessTypeEnum,
                      value: BusinessTypeEnum.Registered,
                      onChanged: (newValue) {
                        setState(() {
                          _businessTypeEnum = newValue;
                        });
                      }),
                  const SizedBoxW10(),
                  RadioButton(
                      title: BusinessTypeEnum.Unregistered.name,
                      selectedBusinessType: _businessTypeEnum,
                      value: BusinessTypeEnum.Unregistered,
                      onChanged: (newValue) {
                        setState(() {
                          _businessTypeEnum = newValue;
                        });
                      }),
                ],
              ),
              const SizedBoxH10(),
              if (_businessTypeEnum == BusinessTypeEnum.Registered)
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cipcNumberController,
                    validator: validateCIPC,
                    keyboardType: TextInputType.number,
                    decoration: formDecoration(
                        "CIPC registration number", Icons.business))
              else if (_businessTypeEnum == BusinessTypeEnum.Unregistered)
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: idNumberController,
                  validator: validateIDNumber,
                  keyboardType: TextInputType.number,
                  decoration: formDecoration(
                      "Biz Owner ID Number", Icons.perm_identity_sharp),
                ),

              const SizedBoxH10(),
              //business location
              //
              TextFormField(
                controller: locationController,
                enabled: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateLocation,
                textInputAction: TextInputAction.next,
                decoration: formDecoration("Biz Location", Icons.location_pin),
              ),
              const SizedBoxH10(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    getCurrentLocation(context,
                        location: locationController.text.trim());
                  },
                  icon: const Icon(
                    Icons.location_searching,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Get Current Location",
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBoxH10(),
              TextFormField(
                validator: validatePassword,
                controller: passwordController,
                decoration: formDecoration(
                  "Password",
                  Icons.lock_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                validator: validateConfirmPassword,
                controller: confirmPasswordController,
                decoration: formDecoration(
                  "Confirm Password",
                  Icons.lock_outline,
                ),
              ),
              const SizedBoxH20(),
              CupertinoButton(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.indigo,
                  child: const Text(
                    'Sign up',
                    style: style16White,
                  ),
                  onPressed: () {
                    createServiceProviderInUI(context,
                        name: bizNameController.text.trim(),
                        email: emailController.text.trim(),
                        phoneNumber: phoneController.text.trim(),
                        location: locationController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                        businessType: _businessTypeEnum!,
                        cipcNumber: cipcNumberController.text.trim(),
                        idNumber: idNumberController.text.trim());
                  }),
            ],
          ),
        ));
  }
}
