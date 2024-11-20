import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:responsi_124220138_prak_mobile/auth/login/screens/login_screen.dart';
import 'package:responsi_124220138_prak_mobile/auth/signup/controllers/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final signupKey = GlobalKey<FormState>();
    final SignupController signupController = Get.find();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: signupKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //username
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username can't be empty!";
                      }
                      return null;
                    },
                    controller: signupController.username,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Username'),
                  ),

                  //password
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username can't be empty!";
                      }
                      return null;
                    },
                    controller: signupController.password,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                  ),

                  //signup
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {
                          if (signupKey.currentState!.validate()) {
                            signupController.signup(
                                signupController.username.text.trim(),
                                signupController.password.text.trim());
                          }
                        },
                        child: const Text("Signup")),
                  ),

                  //login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Text(
                          "Login here!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}