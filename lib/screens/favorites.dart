import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/models/favorite_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/widgets/favorite_song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../dbfunctions.dart';
import 'functions.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Favourites> likedsongs = [];
  final box = SongBox.getInstance();
  late List<Songs> allDbSongs = [];
  List<Audio> Favsongs = [];
  @override
  void initState() {
    allDbSongs = box.values.toList();
    likedsongs = favouritedb.values.toList().reversed.toList();
    for (var element in likedsongs) {
      Favsongs.add(Audio.file(element.songurl.toString(),
          metas: Metas(
            artist: element.artist,
            title: element.songname,
            id: element.id.toString(),
          )));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    likedsongs = favouritedb.values.toList().reversed.toList();
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              myappbar(title: 'Favorites', trailing: const SizedBox()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: FavouriteSongTile(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
