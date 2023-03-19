import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sendeach_app/app/data/services/fcm_service.dart';
import 'package:sms_sender/sms_sender.dart';

class SmsController extends GetxController {
  late TextEditingController recipientsController;
  late TextEditingController messageController;

  @override
  void onInit() {
    recipientsController = TextEditingController();
    messageController = TextEditingController();
    Get.find<FCMService>().readToken().then((value) {
      messageController.text = value;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendSMS() async {
    await Permission.sms.request();
    List<String> recipients = recipientsController.text.split(",");
    await SmsSender().sendSms(
      recipients,
      messageController.text,
      onSentListener,
      onDeliveredListener,
    );
  }

  Future<void> onSentListener(bool success) async {
    Fluttertoast.showToast(msg: "SMS sent");
  }

  Future<void> onDeliveredListener(bool success) async {
    Fluttertoast.showToast(msg: "SMS Delivered");
  }
}
