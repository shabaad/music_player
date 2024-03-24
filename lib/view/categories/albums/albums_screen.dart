import 'package:flutter/material.dart';
import 'package:music_player/controller/albumController.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/categories/albums/albumTile.dart';
import 'package:music_player/view/categories/albums/album_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AlbumController>(context, listen: false).getAlbums();
    final albumProvider = Provider.of<AlbumController>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
          backgroundColor: ConstantColors.themeBlueColor,
          title: Text(
            "Albums (${albumProvider.albums.length})",
            style: TextStyle(
                color: ConstantColors.themeWhiteColor,
                fontWeight: FontWeight.bold),
          ),
          titleSpacing: 0,
        ),
        backgroundColor: ConstantColors.themeBlueColor,
        body: FutureBuilder<List<AlbumModel>>(
          future: albumProvider.getAlbums(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error:${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No Albums Found");
            } else {
              final albums = snapshot.data!;
              return ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return GestureDetector(
                    onTap: () {
                      albumProvider.selectedAlbumIndex(album.album);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumSongs(album, albumProvider.selectedAlbum),
                          ));
                    },
                    child: AlbumTile(
                      songTitle: album.album,
                      artist: album.numOfSongs < 2
                          ? "${album.numOfSongs} Song"
                          : "${album.numOfSongs} Songs",
                      image: QueryArtworkWidget(
                        id: albumProvider.albums[index].id,
                        type: ArtworkType.ALBUM,
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
