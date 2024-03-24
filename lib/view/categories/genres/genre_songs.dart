import 'package:flutter/material.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/controller/genre_controller.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/home_screen/widgets/song_list_tile.dart';
import 'package:music_player/view/play_now_screen/play_now_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GenreSongs extends StatelessWidget {
  const GenreSongs(this.genre, this.selectedGenre);
  final GenreModel genre;
  final String selectedGenre;

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreController>(context);
    final playerProvider = Provider.of<PlayNowController>(context);
    Provider.of<GenreController>(context, listen: false)
        .getGenreSongs(genreProvider.selectedGenre);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
          titleSpacing: 0,
          backgroundColor: ConstantColors.themeBlueColor,
          title: Text(
            "${selectedGenre}",
            style:
                TextStyle(color: ConstantColors.themeWhiteColor, fontSize: 18),
          ),
        ),
        backgroundColor: ConstantColors.themeBlueColor,
        body: FutureBuilder<List<MySongsModel>>(
          future: genreProvider.getGenreSongs(selectedGenre),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No songs found for $selectedGenre.');
            } else {
              List<MySongsModel> songs = snapshot.data!;
              return ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  MySongsModel song = songs[index];
                  return GestureDetector(
                    onTap: () {
                      playerProvider.playSong(songs[index].url, index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlaynowScreen(songData: songs),
                          ));
                    },
                    child: SongListTile(
                      songTitle: song.displayName,
                      artist: song.artist,
                      image: QueryArtworkWidget(
                        id: song.id,
                        type: ArtworkType.AUDIO,
                        keepOldArtwork: true,
                        artworkBorder: BorderRadius.circular(10),
                        nullArtworkWidget:
                            Image.asset(ConstantImage.mainLogoPng),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
