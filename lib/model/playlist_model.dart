import 'package:hive/hive.dart';
import 'package:music_player/model/my_song_model.dart';

part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModelList {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<MySongsModel> playlistSongs;

  PlayListModelList({required this.name, this.playlistSongs = const []});
}
