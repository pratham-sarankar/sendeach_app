import 'package:sendeach_app/app/data/providers/device_provider.dart';

class DeviceRepository extends DeviceProvider {
  void toggleConnection() {
    if (isConnected.value) {
      disconnect();
    } else {
      connect();
    }
  }
}
