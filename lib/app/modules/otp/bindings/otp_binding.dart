import 'package:get/get.dart';
import 'package:sendeach_app/app/widgets/otp_field.dart';

import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
    Get.lazyPut<OtpFieldController>(() => OtpFieldController());
  }
}
