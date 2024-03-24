import 'package:flutter/material.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/utils/png_icons.dart';
import 'package:music_player/view/categories/favorites_screen/favorite_list_tile.dart';
import 'package:music_player/view/play_now_screen/play_now_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayNowController>(context);
    final playlistProvider = Provider.of<PlaylistController>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
        title: Text(
          "Favorites",
          style: TextStyle(
              color: ConstantColors.themeWhiteColor,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: ConstantColors.themeBlueColor,
      ),
      backgroundColor: ConstantColors.themeBlueColor,
      body: playlistProvider.favorites.isEmpty
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Image.asset(
                    IconsPng.heartPng,
                    scale: 15,
                    color: Colors.white12,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No Favorite Songs added",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white12,
                    ),
                  )
                ]))
          : ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: playlistProvider.favorites.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  playerProvider.playSong(
                      playlistProvider.favorites[index].url, index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlaynowScreen(songData: playlistProvider.favorites),
                      ));
                },
                child: FavoriteListTile(
                  songTitle: playlistProvider.favorites[index].displayName,
                  artist: playlistProvider.favorites[index].artist,
                  image: QueryArtworkWidget(
                    id: playlistProvider.favorites[index].id,
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(10),
                    nullArtworkWidget: Image.asset(ConstantImage.mainLogoPng),
                  ),
                ),
              ),
            ),
    );
  }
}
