// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expertGroup_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpertGroupAdapter extends TypeAdapter<ExpertGroup> {
  @override
  final int typeId = 4;

  @override
  ExpertGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpertGroup(
      id: fields[0] as String,
      firstname: fields[1] as String,
      lastname: fields[2] as String,
      onlinestatus: fields[3] as int,
      profileImage: (fields[4] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExpertGroup obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.onlinestatus)
      ..writeByte(4)
      ..write(obj.profileImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpertGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
