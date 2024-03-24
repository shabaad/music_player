import 'package:hive/hive.dart';

part 'my_song_model.g.dart';

@HiveType(typeId: 1)
class MySongsModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String displayName;
  @HiveField(3)
  String artist;
  @HiveField(4)
  String url;
  @HiveField(5)
  int? duration;
  @HiveField(6)
  bool? favorites;
  @HiveField(7)
  String data;
  @HiveField(8)
  String? album;
  @HiveField(9)
  String? genre;

  MySongsModel(
      {required this.id,
      required this.title,
      required this.displayName,
      required this.artist,
      required this.url,
      required this.duration,
      this.favorites = false,
      required this.data,
      this.album,
      this.genre});
}

class AlbumSongsModel {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String genre;
  final String filePath;

  AlbumSongsModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.genre,
    required this.filePath,
  });
}
