import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_sender/sms_sender.dart';

class SMSService extends GetxService {
  Future<SMSService> init() async {
    return this;
  }

  Future sendSms(RemoteMessage remoteMessage, {bool isTestSms = false}) async {
    if (isTestSms) {
      await Permission.sms.request();
    }
    var data = remoteMessage.data;
    var recipients = List<String>.from(jsonDecode(data['recipients']) ?? []);
    var message = remoteMessage.data['message'] ?? "";
    SmsSender().sendSms(
      recipients,
      message,
      _onSent,
      _onDelivered,
      deleteAfterDelivery: true,
      onSmsDeleted: _onSmsDeleted,
    );
  }

  Future _onSent(bool success) async {
    Fluttertoast.showToast(msg: "Sms sent");
  }

  Future _onDelivered(bool success) async {
    Fluttertoast.showToast(msg: "Sms Delivered");
  }

  Future _onSmsDeleted() async {
    Fluttertoast.showToast(msg: "Sms Deleted");
  }
}
