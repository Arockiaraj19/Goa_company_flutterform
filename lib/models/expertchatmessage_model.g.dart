// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expertchatmessage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpertChatMessageAdapter extends TypeAdapter<ExpertChatMessage> {
  @override
  final int typeId = 3;

  @override
  ExpertChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpertChatMessage(
      id: fields[0] as String,
      userid: fields[1] as String,
      expertid: fields[2] as String,
      groupid: fields[3] as String,
      message: fields[4] as String,
      readByRecipients: (fields[5] as List)?.cast<String>(),
      venderDetails: (fields[6] as List)?.cast<Details>(),
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
      images: (fields[9] as List)?.cast<String>(),
      userType: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpertChatMessage obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userid)
      ..writeByte(2)
      ..write(obj.expertid)
      ..writeByte(3)
      ..write(obj.groupid)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.readByRecipients)
      ..writeByte(6)
      ..write(obj.venderDetails)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.images)
      ..writeByte(10)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpertChatMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
