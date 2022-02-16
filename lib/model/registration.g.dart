// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegistrationAdapter extends TypeAdapter<Registration> {
  @override
  final int typeId = 0;

  @override
  Registration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Registration()
      ..name = fields[0] as String
      ..createdDate = fields[1] as DateTime
      ..email = fields[2] as String
      ..password = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Registration obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistrationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
