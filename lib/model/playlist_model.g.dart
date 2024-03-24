// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListModelListAdapter extends TypeAdapter<PlayListModelList> {
  @override
  final int typeId = 2;

  @override
  PlayListModelList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModelList(
      name: fields[0] as String,
      playlistSongs: (fields[1] as List).cast<MySongsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayListModelList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.playlistSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
