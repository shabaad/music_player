// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MySongsModelAdapter extends TypeAdapter<MySongsModel> {
  @override
  final int typeId = 1;

  @override
  MySongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MySongsModel(
      id: fields[0] as int,
      title: fields[1] as String,
      displayName: fields[2] as String,
      artist: fields[3] as String,
      url: fields[4] as String,
      duration: fields[5] as int?,
      favorites: fields[6] as bool?,
      data: fields[7] as String,
      album: fields[8] as String?,
      genre: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MySongsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.artist)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.favorites)
      ..writeByte(7)
      ..write(obj.data)
      ..writeByte(8)
      ..write(obj.album)
      ..writeByte(9)
      ..write(obj.genre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MySongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
