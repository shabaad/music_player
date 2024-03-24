import 'package:flutter/material.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/png_icons.dart';

Future<dynamic> playlistSheet(
    BuildContext context,
    PlaylistController playlistProvider,
    PlayNowController playerController,
    List<MySongsModel> songData,
    TextEditingController playlistName) {
  return showModalBottomSheet(
    backgroundColor: ConstantColors.themeBlueColor,
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        border: Border(
            left: BorderSide(color: ConstantColors.themeWhiteColor),
            right: BorderSide(color: ConstantColors.themeWhiteColor),
            top: BorderSide(color: ConstantColors.themeWhiteColor)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add to playlist",
                style: TextStyle(
                    color: ConstantColors.themeWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: ConstantColors.themeWhiteColor)),
                  child: Icon(
                    Icons.add,
                    color: ConstantColors.themeWhiteColor,
                    size: 25,
                  )),
              title: Text(
                "Create new playlist",
                style: TextStyle(color: ConstantColors.themeWhiteColor),
              ),
              onTap: () {
                dialogeBox(context, playlistName, playlistProvider, index: 0);
              },
            ),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: playlistProvider.playlists.length,
                  itemBuilder: (context, index) => ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ConstantColors.themeWhiteColor)),
                        child: Image.asset(
                          IconsPng.playLsitPng,
                          color: ConstantColors.themeWhiteColor,
                          scale: 20,
                        ),
                      ),
                      title: Text(
                        playlistProvider.playlists[index].name,
                        style: TextStyle(color: ConstantColors.themeWhiteColor),
                      ),
                      subtitle: Text(
                        "${playlistProvider.playlistSongsadd.length} Songs",
                        style: TextStyle(color: ConstantColors.lightblueColor),
                      ),
                      onTap: () {
                        playlistProvider.addSongToPlalist(
                            songData[playerController.playIndex]);
                        Navigator.pop(context);
                      })),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> dialogeBox(BuildContext context,
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
