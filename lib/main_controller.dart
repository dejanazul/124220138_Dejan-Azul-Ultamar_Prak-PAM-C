import 'package:get/get.dart';
import 'package:responsi_124220138_prak_mobile/auth/login/screens/login_screen.dart';
import 'package:responsi_124220138_prak_mobile/features/homepage/screens/homepage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  @override
  Future<void> onReady() async {
    super.onReady();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final isLogin = sharedPreferences.getBool('isLogin');

    isLogin == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const HomepageScreen());
  }
}
