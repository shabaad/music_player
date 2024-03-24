import 'package:flutter/material.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile(
      {super.key, required this.songTitle, required this.artist, this.image});
  final String songTitle;
  final String artist;
  final QueryArtworkWidget? image;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              child: image,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: ConstantColors.themeWhiteColor, fontSize: 18),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      artist,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: ConstantColors.themeWhiteColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
