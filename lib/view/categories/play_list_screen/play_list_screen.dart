import 'package:flutter/material.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/png_icons.dart';
import 'package:music_player/view/categories/play_list_screen/playlist_songs/playlist_songs.dart';
import 'package:provider/provider.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final playlistName = TextEditingController();
    PlaylistController playlistController =
        Provider.of<PlaylistController>(context);

    return Scaffold(
      backgroundColor: ConstantColors.themeBlueColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
        backgroundColor: ConstantColors.themeBlueColor,
        titleSpacing: 0,
        title: Text(
          "Your PlayLists",
          style: TextStyle(
            color: ConstantColors.themeWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: playlistController.playlists.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    IconsPng.playLsitPng,
                    scale: 6,
                    color: Colors.white12,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No Playlist Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white12,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: playlistController.playlists.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistSongs(
                          playlistName: playlistName.text, index: index),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.asset(
                    IconsPng.playLsitPng,
                    color: ConstantColors.themeWhiteColor,
                    scale: 15,
                  ),
                  title: Text(
                    playlistController.playlists[index].name,
                    style: TextStyle(
                      color: ConstantColors.themeWhiteColor,
                    ),
                  ),
                  subtitle: Text(
                    "${playlistController.playlistSongsadd.length} songs",
                    style: TextStyle(color: ConstantColors.lightblueColor),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      playlistController.removePlaylist(index);
                    },
                    child: Icon(
                      Icons.delete,
                      color: ConstantColors.themeWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pass the index value when calling the alertBoxPlaylist function
          alertBoxPlaylist(context, playlistName, playlistController, index: 0);
        },
        backgroundColor: ConstantColors.themeWhiteColor,
        child: Icon(
          Icons.add,
          color: ConstantColors.themeBlueColor,
        ),
      ),
    );
  }

  Future<dynamic> alertBoxPlaylist(BuildContext context,
      TextEditingController playlistName, PlaylistController playlistController,
      {required int index}) {
    return showDialog(
      context: context,
      builder: (
        context,
      ) =>
          AlertDialog(
        backgroundColor: ConstantColors.themeBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: ConstantColors.themeWhiteColor),
        ),
        title: Text(
          "New Playlist",
          style: TextStyle(color: ConstantColors.themeWhiteColor),
        ),
        content: SizedBox(
          height: 50,
          child: TextField(
            style: TextStyle(color: ConstantColors.themeWhiteColor),
            controller: playlistName,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: "Playlist Name",
              hintStyle: TextStyle(color: ConstantColors.themeWhiteColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColors.themeWhiteColor),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              playlistController.newPlaylist(playlistName.text);
              playlistName.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "New Playlist created",
                  style: TextStyle(color: ConstantColors.themeBlueColor),
                ),
                backgroundColor: ConstantColors.themeWhiteColor,
                duration: Duration(seconds: 2),
              ));
            },
            child: Text(
              "Create",
              style: TextStyle(color: ConstantColors.themeWhiteColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: ConstantColors.themeWhiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
