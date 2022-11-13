import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc/constants.dart';
import '../misc/validators.dart';
import '../services/helper_user.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key:loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBoxH30(),
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: validateEmail,
                controller: emailController,
                decoration: formDecoration(
                  'Email address',
                  Icons.mail_outline,
                ),
              ),
              const SizedBoxH10(),
              TextFormField(
                textInputAction: TextInputAction.done,
                validator: validatePassword,
                controller: passwordController,
                decoration: formDecoration(
                  'Password',
                  Icons.lock_outline,
                ),
              ),
              const SizedBoxH10(),
              //forgot password
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        resetPasswordInUI(context,
                            email: emailController.text.trim());
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: style16Black,
                      ))
                ],
              ),
              //SIGN IN BUTTON
              CupertinoButton(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.indigo,
                  child: const Text(
                    'Sign in',
                    style: style16White,
                  ),
                  onPressed: () {
                    loginServiceProviderInUI(
                        context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  }),
              const SizedBoxH20(),
              CupertinoButton(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  child: const Text(
                    'Sign up',
                    style: style16Indigo,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, RouteManager.registerPage);
                  })
            ],
          ),
        ));
  }
}
