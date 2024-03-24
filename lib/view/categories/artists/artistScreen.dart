import 'package:flutter/material.dart';
import 'package:music_player/controller/artistController.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/categories/albums/albumTile.dart';
import 'package:music_player/view/categories/artists/artistSongs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ArtistController>(context, listen: false).getArtists();
    final artistProvider = Provider.of<ArtistController>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
          backgroundColor: ConstantColors.themeBlueColor,
          title: Text(
            "Artists (${artistProvider.artists.length})",
            style: TextStyle(
                color: ConstantColors.themeWhiteColor,
                fontWeight: FontWeight.bold),
          ),
          titleSpacing: 0,
        ),
        backgroundColor: ConstantColors.themeBlueColor,
        body: FutureBuilder<List<ArtistModel>>(
          future: artistProvider.getArtists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No Albums Found");
            } else {
              final artists = snapshot.data!;
              return ListView.builder(
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  final artist = artists[index];
                  return GestureDetector(
                    onTap: () {
                      artistProvider.selectedArtistIndex(artist.artist);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArtistSongs(
                                artist, artistProvider.selectedArtist),
                          ));
                    },
                    child: AlbumTile(
                      songTitle: artist.artist,
                      artist: artist.numberOfTracks! < 2
                          ? "${artist.numberOfTracks} Song"
                          : "${artist.numberOfTracks} Songs",
                      image: QueryArtworkWidget(
                        id: artist.id,
                        type: ArtworkType.ARTIST,
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
