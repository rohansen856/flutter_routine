import 'package:hive_flutter/hive_flutter.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class SettingsInfo extends HiveObject{
  @HiveField(0)
  late String? email;

  @HiveField(1)
  late String? branch;

  @HiveField(2)
  late String? group;

  @HiveField(3)
  late int? sem;

  @HiveField(4)
  late int? roll;

  @HiveField(5)
  late int? mess;

  @HiveField(6)
  late bool? isProfileVisible;

  SettingsInfo({
    this.email,
    this.branch,
    this.group,
    this.sem,
    this.roll,
    this.mess,
    this.isProfileVisible
  });
}
