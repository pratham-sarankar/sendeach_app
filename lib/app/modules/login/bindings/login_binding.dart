import 'package:get/get.dart';
import 'package:sendeach_app/app/data/repositories/user_repository.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<UserRepository>(() => UserRepository());
  }
}
