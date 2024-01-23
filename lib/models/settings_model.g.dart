// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsInfoAdapter extends TypeAdapter<SettingsInfo> {
  @override
  final int typeId = 1;

  @override
  SettingsInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsInfo(
      email: fields[0] as String?,
      branch: fields[1] as String?,
      group: fields[2] as String?,
      sem: fields[3] as int?,
      roll: fields[4] as int?,
      mess: fields[5] as int?,
      isProfileVisible: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.branch)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.sem)
      ..writeByte(4)
      ..write(obj.roll)
      ..writeByte(5)
      ..write(obj.mess)
      ..writeByte(6)
      ..write(obj.isProfileVisible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
