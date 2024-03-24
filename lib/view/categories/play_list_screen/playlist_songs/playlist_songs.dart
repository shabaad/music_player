import 'package:flutter/material.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/categories/play_list_screen/playlist_songs/playlistSongsTile.dart';
import 'package:music_player/view/categories/play_list_screen/playlist_songs/song_selection.dart';
import 'package:music_player/view/play_now_screen/play_now_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs(
      {super.key, required this.playlistName, required this.index});

  final String playlistName;
  final int index;

  @override
  Widget build(BuildContext context) {
    final playListProvider = Provider.of<PlaylistController>(context);
    final playerProvider = Provider.of<PlayNowController>(context);
    // final playlist = playListProvider.playlists.firstWhere(
    //   (playlist) => playlist.name == playlistName,
    //   orElse: () => PlayListModelList(name: playlistName),
    // );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
        backgroundColor: ConstantColors.themeBlueColor,
        title: Text(
          "${playListProvider.playlists[index].name}",
          style: TextStyle(color: ConstantColors.themeWhiteColor),
        ),
        titleSpacing: 0,
      ),
      backgroundColor: ConstantColors.themeBlueColor,
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: playListProvider.playlistSongsadd.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              playerProvider.playSong(
                  playListProvider.playlistSongsadd[index].url, index);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaynowScreen(
                        songData: playListProvider.playlistSongsadd),
                  ));
            },
            child: PlaylistSongsTile(
              songTitle: playListProvider.playlistSongsadd[index].displayName,
              artist: playListProvider.playlistSongsadd[index].artist,
              image: QueryArtworkWidget(
                id: playListProvider.playlistSongsadd[index].id,
                type: ArtworkType.AUDIO,
                keepOldArtwork: true,
                artworkBorder: BorderRadius.circular(10),
                nullArtworkWidget: Image.asset(ConstantImage.mainLogoPng),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Playlist_SongSelection(playlistName: playlistName),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
