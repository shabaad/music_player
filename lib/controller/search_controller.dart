import 'package:flutter/material.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchControllerProvider with ChangeNotifier {
  final audioQuery = OnAudioQuery();
  static List<MySongsModel> allSongsList = [];
  List<MySongsModel> seachListsongs = List.from(allSongsList);
  seachList(String value) {
    seachListsongs = allSongsList
        .where((element) =>
            element.displayName.toLowerCase().contains(value.toLowerCase()))
        .toList();

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
