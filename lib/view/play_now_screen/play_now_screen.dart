import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/model/my_song_model.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/utils/png_icons.dart';
import 'package:music_player/view/play_now_screen/playlist_bottomsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaynowScreen extends StatefulWidget {
  const PlaynowScreen({
    super.key,
    required this.songData,
    this.index,
  });
  final List<MySongsModel> songData;
  final int? index;

  @override
  State<PlaynowScreen> createState() => _PlaynowScreenState();
}

class _PlaynowScreenState extends State<PlaynowScreen> {
  double currentSliderValue = 20;
  @override
  void initState() {
    getData();

    super.initState();
    iconImage = Image.asset(
      isPlayingSong ? IconsPng.pausePng : IconsPng.playButton,
      color: ConstantColors.themeWhiteColor,
    );
  }

  Future<void> getData() async {
    Provider.of<PlayNowController>(context, listen: false).durationControl();
    // Provider.of<PlayNowController>(context, listen: false).fetchDeviceSongs();
    // Provider.of<PlayNowController>(context, listen: false).playSong(
    //     widget.songData[Provider.of<PlayNowController>(context).playIndex].url,
    //     Provider.of<PlayNowController>(context).playIndex);
  }

  bool isPlayingSong = true;

  Image iconImage = Image.asset(IconsPng.pausePng);
  final playlistName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kHeight10 = SizedBox(height: 10);
    final kHeight5 = SizedBox(height: 5);
    final kWidth10 = SizedBox(width: 10);

    PlayNowController playerController =
        Provider.of<PlayNowController>(context);

    final playlistProvider = Provider.of<PlaylistController>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
        backgroundColor: ConstantColors.themeBlueColor,
        elevation: 0,
        title: Text("Playing Now"),
        titleTextStyle: TextStyle(
            fontFamily: "Gilroy",
            fontSize: 20,
            color: ConstantColors.themeWhiteColor,
            fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      backgroundColor: ConstantColors.themeBlueColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Container(
                  height: 263,
                  width: 263,
                  child: QueryArtworkWidget(
                    id: widget.songData[playerController.playIndex].id,
                    artworkQuality: FilterQuality.high,
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(10),
                    nullArtworkWidget: Image.asset(ConstantImage.mainLogoPng),
                  ),
                )),
            kHeight10,
            kHeight10,
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              widget.songData[playerController.playIndex]
                                  .displayName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ConstantColors.themeWhiteColor,
                                  fontSize: 24),
                            ),
                            kHeight5,
                            Text(
                              widget.songData[playerController.playIndex]
                                          .displayName ==
                                      "<unknown>"
                                  ? "Unknown Artist"
                                  : widget.songData[playerController.playIndex]
                                      .displayName,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: ConstantColors.lightblueColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playlistProvider.favoriteSongs(
                            widget.songData[playerController.playIndex]);
                      },
                      child: playlistProvider.favorites.contains(
                              widget.songData[playerController.playIndex])
                          ? Icon(
                              Icons.favorite,
                              size: 28,
                            )
                          : Icon(
                              Icons.favorite_outline,
                              color: ConstantColors.unSelectedIndex,
                              size: 28,
                            ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        IconsPng.volumePng,
                        color: ConstantColors.unSelectedIndex,
                        height: 27,
                        width: 27,
                      ),
                      kWidth10,
                      // Image.asset(
                      //   IconsPng.playLsitPng,
                      //   color: ConstantColors.unSelectedIndex,
                      //   height: 20,
                      //   width: 20,
                      // ),
                      InkWell(
                        onTap: () {
                          playlistSheet(context, playlistProvider,
                              playerController, widget.songData, playlistName);
                        },
                        child: Icon(
                          Icons.playlist_add,
                          color: ConstantColors.themeWhiteColor,
                          size: 27,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<PlayNowController>(context, listen: false)
                              .toggleLoopMode();
                        },
                        child: Image.asset(
                          IconsPng.repeatPng,
                          color: playerController.isRepeatEnabled
                              ? ConstantColors.themeWhiteColor
                              : ConstantColors.unSelectedIndex,
                          height: 27,
                          width: 27,
                        ),
                      ),
                      kWidth10,
                      InkWell(
                        onTap: () {
                          Provider.of<PlayNowController>(context, listen: false)
                              .shuffleSong();
                        },
                        child: Image.asset(
                          IconsPng.shufflePng,
                          color: playerController.audioPlayer.shuffleModeEnabled
                              ? ConstantColors.themeWhiteColor
                              : ConstantColors.unSelectedIndex,
                          height: 27,
                          width: 27,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    playerController.position.toString().split(".")[0],
                    style: TextStyle(
                        fontSize: 14, color: ConstantColors.lightblueColor),
                  ),
                  Text(playerController.duration.toString().split(".")[0],
                      style: TextStyle(
                          fontSize: 14, color: ConstantColors.lightblueColor)),
                ],
              ),
            ),
            // Slider
            Slider(
              value: playerController.position.inSeconds.toDouble(),
              max: playerController.duration.inSeconds.toDouble(),
              min: 0.0, // Adjusted to be a double value
              activeColor: ConstantColors.themeWhiteColor,
              inactiveColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  playerController.changeToSeconds(value.toInt());
                });
              },
              onChangeEnd: (value) {
                playerController.seek(Duration(seconds: value.toInt()));
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<PlayNowController>(context, listen: false)
                        .previousSong(
                            playerController.playIndex, widget.songData.length);
                    Provider.of<PlayNowController>(context, listen: false)
                        .playSong(
                            widget.songData[playerController.prevIndex].url,
                            playerController.prevIndex);
                  },
                  child: Image.asset(
                    IconsPng.nextBackwardPng,
                    color: ConstantColors.themeWhiteColor,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                InkWell(
                    onTap: () async {
                      if (playerController.isPlaying == true) {
                        Provider.of<PlayNowController>(context, listen: false)
                            .pauseSong();
                        setState(() {
                          iconImage = Image.asset(
                            IconsPng.playButton,
                            color: ConstantColors.themeWhiteColor,
                          );
                        });
                      } else if (playerController.isPlaying == false) {
                        Provider.of<PlayNowController>(context, listen: false)
                            .resumeSong();
                        setState(() {
                          iconImage = Image.asset(
                            IconsPng.pausePng,
                            color: ConstantColors.themeWhiteColor,
                          );
                        });
                      }
                    },
                    child: iconImage),
                SizedBox(
                  width: 60,
                ),
                InkWell(
                  onTap: () {
                    Provider.of<PlayNowController>(context, listen: false)
                        .nextSong(
                            playerController.playIndex, widget.songData.length);

                    Provider.of<PlayNowController>(context, listen: false)
                        .playSong(
                            widget.songData[playerController.nextIndex].url,
                            playerController.nextIndex);
                  },
                  child: Image.asset(
                    IconsPng.nextForwardPng,
                    color: ConstantColors.themeWhiteColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
