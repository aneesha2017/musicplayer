import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/functions.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../const/colors.dart';
import '../dbfunctions.dart';
import '../models/mostplayed_model.dart';
import '../models/songs_model.dart';
import '../widgets/home_screen_song_tile.dart';

class Most_song_tile extends StatefulWidget {
  // int index;
  // String songname;
  // int image;
  // List<Audio> songs;

  Most_song_tile({
    super.key,
    // required this.index,
    // required this.songname,
    // required this.image,
    // required this.songs,
  });

  @override
  State<Most_song_tile> createState() => _Most_song_tileState();
}

class _Most_song_tileState extends State<Most_song_tile> {
  final box = SongBox.getInstance();
  late List<Songs> allDbSongs;
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> convertedMsongs = [];
  List<MostPlayed> mostplayedsongs = [];
  @override
  void initState() {
    allDbSongs = box.values.toList();
    List<MostPlayed> mostsong = mostplayeddb.values.toList();
    int i = 0;
    for (var element in mostsong) {
      if (element.count > 3) {
        mostplayedsongs.insert(i, element);
        i++;
      }
    }
    for (var items in mostplayedsongs) {
      convertedMsongs.add(Audio.file(items.songurl,
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
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: mostplayedsongs.length,
      itemBuilder: (context, index) {
        log(index.toString());
        final currentSong = mostplayedsongs[index];
        int indexMostly =
            allDbSongs.indexWhere((element) => element.id == currentSong.id);
        log(mostplayedsongs.toString());
        log(indexMostly.toString());
        return Container(
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50)),
          ),
          child: Center(
            child: ListTile(
              onTap: () {
                audioPlayer.open(
                  Playlist(audios: convertedMsongs, startIndex: index),
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                  showNotification: true,
                );
                showBottomSheet(
                  context: context,
                  builder: (context) => Miniplayer(),
                );
              },
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(10),
                id: currentSong.id,
                type: ArtworkType.AUDIO,
                artworkQuality: FilterQuality.high,
                quality: 100,
                size: 2000,
                artworkFit: BoxFit.fill,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'lib/assets/images.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                currentSong.songname,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (checkFavorite(indexMostly)) {
                          log('fav clicked>>>>>');
                          log(checkFavorite(indexMostly).toString());
                          removeFavour(indexMostly);
                        } else {
                          addfavour(indexMostly);
                          log('fav clicked>>>>>');
                        }
                        //log('pressed remove?????/');
                        //removeFavour(indexMostly);
                        setState(() {});
                      },
                      icon: Icon(
                        (checkFavorite(indexMostly))
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: mywhite,
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.library_add)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }
}
