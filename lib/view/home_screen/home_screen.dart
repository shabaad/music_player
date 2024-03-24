import 'package:flutter/material.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/utils/png_icons.dart';
import 'package:music_player/view/authentication/login_screen.dart';
import 'package:music_player/view/home_screen/widgets/song_list_tile.dart';
import 'package:music_player/view/play_now_screen/play_now_screen.dart';
import 'package:music_player/view/search_screen/search_screen.dart';
import 'package:music_player/view/settings_screen/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final kHeight10 = SizedBox(height: 10);
    // final kHeight5 = SizedBox(height: 5);
    // final kWidth10 = SizedBox(width: 10);
    final kWidth5 = SizedBox(width: 5);
    PlayNowController playerController =
        Provider.of<PlayNowController>(context);

    return Scaffold(
      backgroundColor: ConstantColors.themeBlueColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.themeBlueColor,
        elevation: 0,
        title: Text(
          "Hey, User",
          style: TextStyle(
              fontFamily: "Gilroy",
              fontWeight: FontWeight.bold,
              color: ConstantColors.themeWhiteColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
            },
            child: Image.asset(
              IconsPng.searchPng,
              color: ConstantColors.themeWhiteColor,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            child: Icon(Icons.logout),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "My Songs",
              style: TextStyle(
                  color: ConstantColors.themeWhiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            kHeight10,
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 25,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  playerController.playSong(
                      playerController.allSongsList[index].url, index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaynowScreen(
                            index: index,
                            songData: playerController.allSongsList),
                      ));
                },
                child: SongListTile(
                  songTitle: playerController.allSongsList[index].displayName,
                  artist: playerController.allSongsList[index].artist,
                  image: QueryArtworkWidget(
                    id: playerController.allSongsList[index].id,
                    type: ArtworkType.AUDIO,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(10),
                    nullArtworkWidget: Image.asset(ConstantImage.mainLogoPng),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
