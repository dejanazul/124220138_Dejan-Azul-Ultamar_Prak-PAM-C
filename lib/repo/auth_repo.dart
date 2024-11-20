import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220138_prak_mobile/auth/login/screens/login_screen.dart';
import 'package:responsi_124220138_prak_mobile/auth/signup/models/user_model.dart';
import 'package:responsi_124220138_prak_mobile/features/homepage/screens/homepage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxController {
    final Box<UserModel> userBox = Hive.box('users');

  //login
  Future<void> login(String username, String password) async {
    try {
      //cari pengguna di hive
      final user = userBox.values.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => throw Exception("User not found!"),
      );

      if (user.isInBox) {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool('isLogin', true);

        var sessionBox = Hive.box('session');
        sessionBox.put('loggedInUser', username);

        Get.offAll(() => const HomepageScreen());
      }
    } catch (e) {
      Get.snackbar("Error", "Incorrect username or password!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16.0));
    }
  }

  //signup
  Future<void> signup(String username, String password) async {
    try {
      //cek username udah ada atau belum
      if (userBox.values.any(
        (user) => user.username == username,
      )) {
        Get.snackbar("Error", 'Username already exist!',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16.0));
        return;
      }

      //simpan akun
      final newUser = UserModel()
        ..username = username
        ..password = password;
      await userBox.add(newUser);

      var sessionBox = Hive.box('session');
      sessionBox.put('loggedInUser', username);

      //sudah login
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isLogin', true);

      //akun berhasil dibuat
      Get.snackbar('Success', 'Account registered!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16.0));
      Get.offAll(() => const HomepageScreen());
    } catch (e) {
      //return snackbar
      Get.snackbar("Error", "Failed to create account!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16.0));
    }
  }

  Future<void> logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('isLogin');

    var sessionBox = Hive.box('session');
    await sessionBox.delete('loggedInUser');
    Get.offAll(() => const LoginScreen());
  }
}