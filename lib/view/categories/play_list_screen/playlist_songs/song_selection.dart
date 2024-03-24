import 'package:flutter/material.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/categories/widgets/playListSelecTile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Playlist_SongSelection extends StatelessWidget {
  const Playlist_SongSelection({super.key, required this.playlistName});
  final String playlistName;

  @override
  Widget build(BuildContext context) {
    Provider.of<PlaylistController>(context, listen: false).fetchDeviceSongs();
    PlaylistController playListProvider =
        Provider.of<PlaylistController>(context);

    return Scaffold(
        backgroundColor: ConstantColors.themeBlueColor,
        appBar: AppBar(
          titleSpacing: 0,
          iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
          backgroundColor: ConstantColors.themeBlueColor,
          title: Text(
            "Select Songs",
            style: TextStyle(
              color: ConstantColors.themeWhiteColor,
            ),
          ),
        ),
        body: ListView.separated(
          itemCount: playListProvider.allSongsList.length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (playListProvider.playlistSongsadd
                  .contains(playListProvider.allSongsList[index].id)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "This song is already in the playlist",
                    style: TextStyle(color: ConstantColors.themeBlueColor),
                  ),
                  backgroundColor: ConstantColors.themeWhiteColor,
                  duration: Duration(seconds: 1),
                ));
              } else {
                playListProvider
                    .addSongToPlalist(playListProvider.allSongsList[index]);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "New song added",
                    style: TextStyle(color: ConstantColors.themeBlueColor),
                  ),
                  backgroundColor: ConstantColors.themeWhiteColor,
                  duration: Duration(seconds: 1),
                ));
              }
            },
            child: PlaylistSelectionTile(
              songTitle: playListProvider.allSongsList[index].displayName,
              artist: playListProvider.allSongsList[index].artist,
              image: QueryArtworkWidget(
                id: playListProvider.allSongsList[index].id,
                type: ArtworkType.AUDIO,
                keepOldArtwork: true,
                artworkBorder: BorderRadius.circular(10),
                nullArtworkWidget: Image.asset(ConstantImage.mainLogoPng),
              ),
            ),
          ),
        ));
  }
}
