import 'package:flutter/material.dart';
import 'package:music_player/controller/genre_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/categories/albums/albumTile.dart';
import 'package:music_player/view/categories/genres/genre_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<GenreController>(context, listen: false).getGenre();
    final genreProvider = Provider.of<GenreController>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
          backgroundColor: ConstantColors.themeBlueColor,
          title: Text(
            "Albums (${genreProvider.genres.length})",
            style: TextStyle(
                color: ConstantColors.themeWhiteColor,
                fontWeight: FontWeight.bold),
          ),
          titleSpacing: 0,
        ),
        backgroundColor: ConstantColors.themeBlueColor,
        body: FutureBuilder<List<GenreModel>>(
          future: genreProvider.getGenre(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No Albums Found");
            } else {
              final genres = snapshot.data!;
              return ListView.builder(
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return GestureDetector(
                    onTap: () {
                      genreProvider.selectedGenreIndex(genre.genre);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GenreSongs(genre, genreProvider.selectedGenre),
                          ));
                    },
                    child: AlbumTile(
                      songTitle: genre.genre,
                      artist: genre.numOfSongs < 2
                          ? "${genre.numOfSongs} Song"
                          : "${genre.numOfSongs} Songs",
                      image: QueryArtworkWidget(
                        id: genreProvider.genres[index].id,
                        type: ArtworkType.GENRE,
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
