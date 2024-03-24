import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayNowController with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();

  final audioQuery = OnAudioQuery();

  List<MySongsModel> allSongsList = [];
  // List<AudioSource> songsList = [];
  int playIndex = 0;
  int nextIndex = 0;
  int prevIndex = 0;

  bool isPlaying = false;
  bool isRepeatEnabled = false;
  bool isShuffleEnabled = false;

  Duration duration = Duration();
  Duration position = Duration();

  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSong(String? url, int index) async {
    playIndex = index;
    notifyListeners();

    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url!)));
      notifyListeners();

      // audioPlayer.playerStateStream.listen((state) {
      //   if (state == ProcessingState.completed) {
      //     nextSong(currentIndex);
      //   }
      // });

      notifyListeners();
      await audioPlayer.play();
      durationControl();

      notifyListeners();
    } catch (e) {
      print("Error Parsing Song:$e");
    }
  }

  Future<void> pauseSong() async {
    await audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  Future<void> resumeSong() async {
    await audioPlayer.play();
    isPlaying = true;
    notifyListeners();
  }

  void nextSong(int index, int indexLength) {
    nextIndex = index + 1;
    if (nextIndex >= indexLength) {
      nextIndex = 0;
      notifyListeners();
    }
  }

  void previousSong(int index, int indexLength) {
    prevIndex = index - 1;
    if (prevIndex < 0) {
      prevIndex = indexLength - 1;
      notifyListeners();
    }
  }

  void seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  durationControl() {
    audioPlayer.durationStream.listen((d) {
      notifyListeners();
      duration = d!;
    });

    audioPlayer.positionStream.listen((p) {
      notifyListeners();
      position = p;
    });
  }

  void changeToSeconds(int seconds) {
    Duration durationSeek = Duration(seconds: seconds);
    audioPlayer.seek(durationSeek);
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
  }

  void toggleLoopMode() async {
    if (isRepeatEnabled) {
      await audioPlayer.setLoopMode(LoopMode.off);
    } else {
      await audioPlayer.setLoopMode(LoopMode.one);
    }
    isRepeatEnabled = !isRepeatEnabled;
    notifyListeners();
  }

  void shuffleSong() async {
    if (isShuffleEnabled) {
      await audioPlayer.setShuffleModeEnabled(false);
    } else {
      await audioPlayer.setShuffleModeEnabled(true);
    }
    isShuffleEnabled = !isShuffleEnabled;

    notifyListeners();
  }

  Future<void> setShuffleMode() async {
    if (audioPlayer.shuffleModeEnabled == true) {
      audioPlayer.setShuffleModeEnabled(false);
    } else {
      audioPlayer.setShuffleModeEnabled(true);
    }
    notifyListeners();
  }
}
  //  await audioPlayer.setAudioSource(,
  //     ));

    //  for (var element in allSongsList) {
    //     songsList.add(AudioSource.uri(Uri.parse(element.url)));
    //     notifyListeners();
    //   }
    //   audioPlayer.setAudioSource(ConcatenatingAudioSource(children: songsList));

