import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi_124220138_prak_mobile/repo/auth_repo.dart';

class SignupController extends GetxController {
  final AuthRepo authRepo = Get.find();

  final username = TextEditingController();
  final password = TextEditingController();

  //signup
  void signup(String username, String password) {
    authRepo.signup(username, password);
  }
}
