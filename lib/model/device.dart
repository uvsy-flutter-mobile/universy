import 'copyable.dart';

class Device implements Copyable<Device> {
  String udid;

  Device(this.udid);

  @override
  Device copy() {
    return Device(udid);
  }
}
