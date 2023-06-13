// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../const/colors.dart';
import '../dbfunctions.dart';
import '../models/mostplayed_model.dart';

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

  void requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    log(status.toString());
  }

  songfetchingfunction() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    log(permissionStatus.toString());
    if (!permissionStatus) {
      // check for permission
      await audioQuery.permissionsRequest();
    }
    devicesongs = await audioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.DESC_OR_GREATER,
      ignoreCase: true,
      uriType: UriType.EXTERNAL,
    );
    log(devicesongs.toString());

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
      //await SongBox.put(song.id, song);
      await box.add(song);
      log('added>>>.');
      //log(box.values.toList().toString());
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
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacementNamed('bottomnav');
  }
}
