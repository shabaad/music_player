import 'package:flutter/material.dart';
import 'package:music_player/model/album_model.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenreController with ChangeNotifier {
  OnAudioQuery audioQuery = OnAudioQuery();

  List<MySongsModel> songs = [];
  List<GenreModel> genres = [];

  String selectedGenre = "";

  Future<List<GenreModel>> getGenre() async {
    genres = await audioQuery.queryGenres(
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: GenreSortType.GENRE,
        ignoreCase: true,
        uriType: UriType.EXTERNAL);
    return genres;
  }

  Future<List<MySongsModel>> getGenreSongs(String genre) async {
    final songs = await audioQuery.queryAudiosFrom(AudiosFromType.GENRE, genre,
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: SongSortType.DATE_ADDED);
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
            genre: song.genre))
        .toList();
  }

  List<CategoryModelSongs> convertToAlbumModel(List<MySongsModel> songs) {
    final Map<String, List<MySongsModel>> genreMap = {};

    for (final song in songs) {
      final genre = song.album;
      if (genreMap.containsKey(genre)) {
        genreMap[genre]!.add(song);
      } else {
        genreMap[genre!] = [song];
      }
    }

    final List<CategoryModelSongs> genres = genreMap.entries.map((entry) {
      final genre = entry.key;
      final songs = entry.value;
      return CategoryModelSongs(category: genre, songs: songs);
    }).toList();

    return genres;
  }

  void selectedGenreIndex(String genre) {
    selectedGenre = genre;
    notifyListeners();
  }
}
