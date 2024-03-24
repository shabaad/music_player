import 'package:flutter/material.dart';
import 'package:music_player/model/album_model.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistController with ChangeNotifier {
  OnAudioQuery audioQuery = OnAudioQuery();

  List<MySongsModel> songs = [];
  List<ArtistModel> artists = [];

  String selectedArtist = "";

  Future<List<ArtistModel>> getArtists() async {
    artists = await audioQuery.queryArtists(
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: ArtistSortType.ARTIST,
        ignoreCase: true,
        uriType: UriType.EXTERNAL);
    return artists;
  }

  Future<List<MySongsModel>> getArtistSongs(String artist) async {
    final songs = await audioQuery.queryAudiosFrom(
        AudiosFromType.ARTIST, artist,
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: SongSortType.ARTIST);
    return songs
        .map((song) => MySongsModel(
              id: song.id,
              title: song.title,
              artist: song.artist!,
              album: song.album!,
              url: song.uri!,
              data: song.data,
              duration: song.duration,
              displayName: song.displayNameWOExt,
            ))
        .toList();
  }

  List<CategoryModelSongs> convertToAlbumModel(List<MySongsModel> songs) {
    final Map<String, List<MySongsModel>> artistMap = {};

    for (final song in songs) {
      final artist = song.artist;
      if (artistMap.containsKey(artist)) {
        artistMap[artist]!.add(song);
      } else {
        artistMap[artist] = [song];
      }
    }

    final List<CategoryModelSongs> artists = artistMap.entries.map((entry) {
      final artist = entry.key;
      final songs = entry.value;
      return CategoryModelSongs(category: artist, songs: songs);
    }).toList();

    return artists;
  }

  void selectedArtistIndex(String artist) {
    selectedArtist = artist;
    notifyListeners();
  }
}
