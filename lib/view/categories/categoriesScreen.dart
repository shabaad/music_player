import 'package:flutter/material.dart';
import 'package:music_player/controller/albumController.dart';
import 'package:music_player/controller/artistController.dart';
import 'package:music_player/controller/genre_controller.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/png_icons.dart';
import 'package:music_player/view/categories/albums/albums_screen.dart';
import 'package:music_player/view/categories/artists/artistScreen.dart';
import 'package:music_player/view/categories/favorites_screen/favorites_screen.dart';
import 'package:music_player/view/categories/genres/genre_screen.dart';
import 'package:music_player/view/categories/play_list_screen/play_list_screen.dart';
import 'package:music_player/view/categories/widgets/category_container.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plalistProvider = Provider.of<PlaylistController>(context);
    final albumProvider = Provider.of<AlbumController>(context);
    final artistProvider = Provider.of<ArtistController>(context);
    final genreProvider = Provider.of<GenreController>(context);

    return Scaffold(
      backgroundColor: ConstantColors.themeBlueColor,
      appBar: AppBar(
        title: Text("Categories"),
        titleTextStyle: TextStyle(
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: ConstantColors.themeWhiteColor),
        backgroundColor: ConstantColors.themeBlueColor,
        elevation: 0,
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 200),
        children: [
          CategoryContainer(
              name: "Playlists",
              count: "${plalistProvider.playlists.length} playlists",
              icon: IconsPng.playLsitPng,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PlayListScreen()));
              }),
          CategoryContainer(
              name: "Favorites",
              count: "${plalistProvider.favorites.length} songs",
              icon: IconsPng.heartPng,
              iconScale: 20,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoriteScreen()));
              }),
          CategoryContainer(
              name: "Albums",
              count: "${albumProvider.albums.length} Albums",
              icon: IconsPng.albumsPng,
              iconScale: 7,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AlbumsScreen()));
              }),
          CategoryContainer(
              name: "Artists",
              count: "${artistProvider.artists.length} Artists",
              icon: IconsPng.artistPng,
              iconScale: 7,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ArtistScreen()));
              }),
          CategoryContainer(
              name: "Genres",
              count: "${genreProvider.genres.length} songs",
              icon: IconsPng.musicNotePng,
              iconScale: 9,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GenreScreen()));
              }),
        ],
      ),
    );
  }
}
