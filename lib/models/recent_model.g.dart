// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentAdapter extends TypeAdapter<Recent> {
  @override
  final int typeId = 3;

  @override
  Recent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recent(
      id: fields[0] as int?,
      songname: fields[1] as String?,
      artist: fields[2] as String?,
      songurl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recent obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songname)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.songurl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
