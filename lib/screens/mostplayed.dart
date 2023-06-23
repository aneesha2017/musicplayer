import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/most_song_tile.dart';
import 'package:music_app/widgets/home_screen_song_tile.dart';

class MostPlayedScreen extends StatefulWidget {
  const MostPlayedScreen({super.key});

  @override
  State<MostPlayedScreen> createState() => _MostPlayedScreenState();
}

class _MostPlayedScreenState extends State<MostPlayedScreen> {
  //final box = MostplayedBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];
  List<MostPlayed> mostplayedsongs = [];
  @override
  void initState() {
    List<MostPlayed> mostsong = mostplayeddb.values.toList();
    int i = 0;
    for (var element in mostsong) {
      if (element.count > 3) {
        mostplayedsongs.insert(i, element);
        i++;
      }
    }
    for (var items in mostplayedsongs) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Myappbar(title: 'Most Played', trailing: const SizedBox()),
            SizedBox(
              child: Most_song_tile(),
            )
          ],
        ),
      ),
    );
  }
}
