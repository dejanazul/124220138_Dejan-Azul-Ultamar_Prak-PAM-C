import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsi_124220138_prak_mobile/auth/login/controllers/login_controller.dart';
import 'package:responsi_124220138_prak_mobile/auth/login/screens/login_screen.dart';
import 'package:responsi_124220138_prak_mobile/auth/signup/controllers/signup_controller.dart';
import 'package:responsi_124220138_prak_mobile/auth/signup/models/user_model.dart';
import 'package:responsi_124220138_prak_mobile/features/homepage/controllers/homepage_controller.dart';
import 'package:responsi_124220138_prak_mobile/main_controller.dart';
import 'package:responsi_124220138_prak_mobile/repo/auth_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //mendaftarkan adapter
  Hive.registerAdapter(UserModelAdapter());
  //membuka box hive
  await Hive.openBox<UserModel>('users');
  await Hive.openBox('session');
  Get.put(AuthRepo());
  Get.put(MainController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //controllers
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => HomepageController(), fenix: true);

    return const GetMaterialApp(home: LoginScreen());
  }
}
