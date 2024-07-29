import 'package:hive/hive.dart';
part 'tbl_device.g.dart';

@HiveType(typeId: 10)
class TBLDevice {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? customerId;
  @HiveField(2)
  String? deviceName;
  @HiveField(3)
  String? deviceId;
  @HiveField(4)
  bool? isSelected;
  TBLDevice(
      {this.id,
      this.customerId,
      this.deviceName,
      this.deviceId,
      this.isSelected});
  factory TBLDevice.fromJson(Map<String, dynamic> jsonData) {
    return TBLDevice(
        id: jsonData['id'],
        customerId: jsonData['customer_id'],
        deviceName: jsonData['device_name'],
        deviceId: jsonData['device_id']);
  }
}
