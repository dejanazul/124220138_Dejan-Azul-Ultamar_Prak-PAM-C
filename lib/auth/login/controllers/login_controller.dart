import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi_124220138_prak_mobile/repo/auth_repo.dart';

class LoginController extends GetxController {
  final AuthRepo authRepo = Get.find();

  final username = TextEditingController();
  final password = TextEditingController();

  void login(String username, String password) {
    authRepo.login(username, password);
  }
}