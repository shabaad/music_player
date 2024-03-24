import 'package:flutter/material.dart';
import 'package:music_player/model/album_model.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumController with ChangeNotifier {
  OnAudioQuery audioQuery = OnAudioQuery();

  List<MySongsModel> songs = [];
  List<AlbumModel> albums = [];

  String selectedAlbum = "";

  Future<List<AlbumModel>> getAlbums() async {
    albums = await audioQuery.queryAlbums(
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: AlbumSortType.ALBUM,
        ignoreCase: true,
        uriType: UriType.EXTERNAL);
    return albums;
  }

  Future<List<MySongsModel>> getAlbumSongs(String album) async {
    final songs = await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM, album,
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: SongSortType.ALBUM);
    return songs
        .map((song) => MySongsModel(
              duration: song.duration,
              displayName: song.displayNameWOExt,
              url: song.uri!,
              data: song.data,
              id: song.id,
              title: song.title,
              artist: song.artist!,
              album: song.album!,
            ))
        .toList();
  }

  List<CategoryModelSongs> convertToAlbumModel(List<MySongsModel> songs) {
    final Map<String, List<MySongsModel>> albumMap = {};

    for (final song in songs) {
      final album = song.album;
      if (albumMap.containsKey(album)) {
        albumMap[album]!.add(song);
      } else {
        albumMap[album!] = [song];
      }
    }

    final List<CategoryModelSongs> albums = albumMap.entries.map((entry) {
      final album = entry.key;
      final songs = entry.value;
      return CategoryModelSongs(category: album, songs: songs);
    }).toList();

    return albums;
  }

  void selectedAlbumIndex(String album) {
    selectedAlbum = album;
    notifyListeners();
  }
}
