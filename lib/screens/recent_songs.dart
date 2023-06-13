import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/recent_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/widgets/recent_song_tile.dart';

class RecentSongs extends StatefulWidget {
  const RecentSongs({super.key});

  @override
  State<RecentSongs> createState() => _RecentSongsState();
}

class _RecentSongsState extends State<RecentSongs> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];
  List<Recent> recentsongs = [];
  @override
  void initState() {
    List<Recent> rsongs = recentdb.values.toList();
    for (var element in rsongs) {
      songs.add(Audio.file(element.songurl!,
          metas: Metas(
              title: element.songname,
              artist: element.artist,
              id: element.id.toString())));
    }
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myappbar(title: 'Recent Songs', trailing: const SizedBox()),
            const SizedBox(
              child: RecentSongtile(),
            )
          ],
        ),
      ),
    );
  }
}
