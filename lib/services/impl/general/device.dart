import 'package:flutter_udid/flutter_udid.dart';
import 'package:universy/model/device.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/util/object.dart';

class DefaultDeviceService implements DeviceService {
  static DeviceService _instance;

  Device _device;

  DefaultDeviceService._internal();

  factory DefaultDeviceService.instance() {
    if (isNull(_instance)) {
      _instance = DefaultDeviceService._internal();
    }
    return _instance;
  }

  @override
  Future<Device> getDevice() async {
    if (isNull(_device)) {
      String uidi = await getUDID();
      _device = Device(uidi);
    }
    return _device.copy();
  }

  Future<String> getUDID() async {
    return await FlutterUdid.consistentUdid;
  }

  @override
  void dispose() {
    _instance = null;
  }
}
