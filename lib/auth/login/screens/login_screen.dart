import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:responsi_124220138_prak_mobile/auth/login/controllers/login_controller.dart';
import 'package:responsi_124220138_prak_mobile/auth/signup/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginKey = GlobalKey<FormState>();
    final LoginController loginController = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: loginKey,
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
                    controller: loginController.username,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Username"),
                  ),

                  //password
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username can't be empty!";
                      }
                      return null;
                    },
                    controller: loginController.password,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                  ),

                  //button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {
                          if (loginKey.currentState!.validate()) {
                            loginController.login(
                                loginController.username.text.trim(),
                                loginController.password.text.trim());
                          }
                        },
                        child: const Text("Login")),
                  ),

                  //signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account yet? "),
                      InkWell(
                        onTap: () {
                          Get.to(() => const SignupScreen());
                        },
                        child: const Text(
                          "Signup here!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}