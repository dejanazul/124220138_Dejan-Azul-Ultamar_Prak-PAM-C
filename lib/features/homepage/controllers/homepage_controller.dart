import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220138_prak_mobile/repo/auth_repo.dart';

class HomepageController extends GetxController {
  final AuthRepo authRepo = Get.find();

  void logout() {
    authRepo.logout();
  }

  Future<String?> getLoggedInUser() async {
    var sessionBox = await Hive.openBox('session');
    return sessionBox.get('loggedInUser');
  }
}
