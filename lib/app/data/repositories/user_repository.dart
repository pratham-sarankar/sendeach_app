import 'package:get/get.dart';
import 'package:sendeach_app/app/data/providers/user_provider.dart';
import 'package:sendeach_app/app/routes/app_pages.dart';

class UserRepository extends UserProvider {
  @override
  Future<bool> loginWithWhatsappNumber(
      {required String phoneNumber,
      required Future<String> Function() onRequestingOTP}) async {
    bool result = await super.loginWithWhatsappNumber(
      phoneNumber: phoneNumber,
      onRequestingOTP: onRequestingOTP,
    );
    if (result) {
      Get.offAllNamed(Routes.HOME);
    }
    return result;
  }
}
