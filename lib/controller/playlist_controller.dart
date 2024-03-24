import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistController with ChangeNotifier {
  late Box<PlayListModelList> box1;
  late Box<MySongsModel> box2;
  late Box<MySongsModel> box3;
  OnAudioQuery audioQuery = OnAudioQuery();
  List<MySongsModel> allSongsList = [];

  List<PlayListModelList> playlists = [];
  List<MySongsModel> playlistSongsadd = [];
  List<MySongsModel> favorites = [];

  PlaylistController() {
    _initHive();
  }
  _initHive() async {
    box1 = Hive.box<PlayListModelList>("PlaylistBox");
    box2 = Hive.box<MySongsModel>("MySongBox");
    box3 = Hive.box<MySongsModel>("MySongBox");
    loadPlaylistsFromBox(); // Load playlists from Hive box on initialization
  }

  loadPlaylistsFromBox() {
    playlists = box1.values.toList();
    playlistSongsadd = box2.values.toList();
    favorites = box3.values.toList();
    notifyListeners();
  }

  newPlaylist(String? name) async {
    final playlist = PlayListModelList(name: name!);
    playlists.add(playlist);
    await box1.add(playlist);

    notifyListeners();
  }

  removePlaylist(int index) {
    playlists.removeAt(index);
    box1.delete(index);
    notifyListeners();
  }

  addSongToPlalist(MySongsModel songs) async {
    playlistSongsadd.add(songs);
    await box2.add(songs);
    notifyListeners();
  }

  favoriteSongs(MySongsModel song) async {
    if (favorites.contains(song)) {
      favorites.remove(song);
      box3.delete(song);
    } else {
      favorites.add(song);
      await box3.add(song);
    }
    notifyListeners();
  }

  fetchDeviceSongs() async {
    final List<SongModel> deviceSongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.DESC_OR_GREATER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    allSongsList = deviceSongs
        .map((e) => MySongsModel(
              id: e.id,
              title: e.title,
              displayName: e.displayNameWOExt,
              artist: e.artist!,
              url: e.uri!,
              data: e.data,
              duration: e.duration,
            ))
        .toList();
    notifyListeners();
  }
}
