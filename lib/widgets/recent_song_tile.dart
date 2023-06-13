import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/recent_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../const/colors.dart';
import '../screens/functions.dart';

class RecentSongtile extends StatefulWidget {
  const RecentSongtile({
    super.key,
  });

  @override
  State<RecentSongtile> createState() => _RecentSongtileState();
}

class _RecentSongtileState extends State<RecentSongtile> {
  final box = SongBox.getInstance();
  late List<Songs> allDbsongs = [];
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Recent> recentsongs = [];
  List<Audio> convertedsongs = [];
  @override
  void initState() {
    allDbsongs = box.values.toList();
    List<Recent> rsongs = recentdb.values.toList();
    for (var element in recentsongs) {
      convertedsongs.add(Audio.file(element.songurl!,
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recentsongs.length,
      itemBuilder: (context, index) {
        log(index.toString());
        final currentSong = recentsongs[index];
        int indexRecently =
            allDbsongs.indexWhere((element) => element.id == currentSong.id);
        log(recentsongs.toString());
        log(indexRecently.toString());
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
                  Playlist(audios: convertedsongs, startIndex: index),
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
                id: currentSong.id!,
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
                currentSong.songname.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (checkFavorite(indexRecently)) {
                          log('fav clicked>>>>>');
                          log(checkFavorite(indexRecently).toString());
                          removeFavour(indexRecently);
                        } else {
                          addfavour(indexRecently);
                          log('fav clicked>>>>>');
                        }
                        //log('pressed remove?????/');
                        //removeFavour(indexMostly);
                        setState(() {});
                      },
                      icon: Icon(
                        (checkFavorite(indexRecently))
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
