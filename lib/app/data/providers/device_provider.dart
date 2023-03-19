import 'dart:convert';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sendeach_app/app/data/repositories/device_repository.dart';
import 'package:sendeach_app/app/data/services/auth_service.dart';
import 'package:sendeach_app/app/data/services/device_info_service.dart';
import 'package:sendeach_app/app/data/services/fcm_service.dart';

class DeviceProvider extends GetConnect {
  late RxBool isConnected;

  @override
  void onInit() {
    baseUrl = const String.fromEnvironment("host");
    isConnected = false.obs;
    if(Get.find<AuthService>().isLoggedIn){
      updateConnection();
    }
    super.onInit();
  }

  void updateConnection() async {
    await Permission.sms.request();
    String fcmToken = await Get.find<FCMService>().readToken();
    String deviceId = Get.find<DeviceInfoService>().deviceId;
    var token = Get.find<AuthService>().readToken();
    var response = await post(
      "/exist_fcm_token",
      {
        "fcm_token": fcmToken,
        "device_id": deviceId,
      },
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    var body = response.body;
    print(body);

    if (body['status'] == true) {
      isConnected.value = body['data']['exist_fcm_token'] ?? false;
    } else {
      throw body['data']['message'];
    }
  }

  void connect() async {
    String fcmToken = await Get.find<FCMService>().readToken();
    String deviceId = Get.find<DeviceInfoService>().deviceId;
    String? token = Get.find<AuthService>().readToken();
    Response response = await post(
      "/store_fcm_token",
      {
        "fcm_token": fcmToken,
        "device_id": deviceId,
      },
      contentType: "application/json",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    var body = response.body;

    if (body['status'] == true) {
      updateConnection();
    } else {
      throw body['data']['message'];
    }
  }

  void disconnect() async {
    var deviceId = Get.find<DeviceInfoService>().deviceId;
    var token = Get.find<AuthService>().readToken();
    var response = await post(
      "/delete_fcm_token",
      {
        "device_id": deviceId,
      },
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    var body = response.body;

    if (body['status'] == true) {
      updateConnection();
    } else {
      throw body['data']['message'];
    }
  }
}
