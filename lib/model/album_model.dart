import 'package:music_player/model/my_song_model.dart';

class AudioModel {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String path;

  AudioModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.path,
  });
}

class CategoryModelSongs {
  final String category;
  final List<MySongsModel> songs;

  CategoryModelSongs({
    required this.category,
    required this.songs,
  });
}
