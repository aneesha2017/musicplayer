// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesAdapter extends TypeAdapter<Favourites> {
  @override
  final int typeId = 1;

  @override
  Favourites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourites(
      id: fields[0] as int?,
      songname: fields[1] as String?,
      artist: fields[2] as String?,
      songurl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Favourites obj) {
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
      other is FavouritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
