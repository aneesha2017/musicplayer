// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../const/colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final box = SongBox.getInstance();
  List<SongModel> devicesongs = [];
  List<SongModel> fetchedsongs = [];
  @override
  void initState() {
    requestPermission();
    songfetchingfunction();
    gotohome();

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  songfetchingfunction() async {
    devicesongs = await audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.DESC_OR_GREATER,
      ignoreCase: true,
      uriType: UriType.EXTERNAL,
    );

    for (var song in devicesongs) {
      if (song.fileExtension == 'mp3') {
        fetchedsongs.add(song);
      }
    }

    for (var audio in fetchedsongs) {
      final song = Songs(
          id: audio.id,
          songname: audio.displayNameWOExt,
          artist: audio.artist,
          songurl: audio.uri);
      await SongBox.put(song.id, song);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: Center(
        child: Image.asset('lib/assets/logo.jpeg'),
      ),
    );
  }

  Future<void> gotohome() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed('bottomnav');
  }
}
