import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'package:music_app/models/recent_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/functions.dart';

import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Homescreensongtile extends StatefulWidget {
  Homescreensongtile({
    // required this.index1,
    super.key,
  });

  //int index1;
  @override
  State<Homescreensongtile> createState() => _HomescreensongtileState();
}

//final mostbox = MostplayedBox.getInstance();

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
final List<MostPlayed> mostplayed = mostplayeddb.values.toList();

class _HomescreensongtileState extends State<Homescreensongtile> {
  final box = SongBox.getInstance();
  late List<Songs> songDatabase;
  List<Audio> audios = [];
  @override
  void initState() {
    songDatabase = box.values.toList();

    for (var i in songDatabase) {
      audios.add(
        Audio.file(
          i.songurl!,
          metas: Metas(
            title: i.songname,
            id: i.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Songs> songlistDb = box.values.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: songlistDb.length,
        itemBuilder: (context, index) {
          final currentSong = songlistDb[index];
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
                  MostPlayed mostly = MostPlayed(
                    songname: songlistDb[index].songname!,
                    songurl: songlistDb[index].songurl!,
                    artist: songlistDb[index].artist!,
                    count: 1,
                    id: songlistDb[index].id!,
                  );
                  log('adding to mostly>>>>>>>>.before');
                  log(index.toString());
                  log(mostly.toString());
                  addMostplayed(index, mostly);
                  log('added to mostly>>>>>>>>.after');

                  Recent rently = Recent(
                    songname: songlistDb[index].songname!,
                    songurl: songlistDb[index].songurl!,
                    artist: songlistDb[index].artist!,
                    id: songlistDb[index].id!,
                  );
                  log('adding to recent');
                  log(index.toString());
                  log(rently.toString());
                  addRecently(index, rently);
                  log('added to recently>>>>>>>>.after');

                  player.open(
                    Playlist(audios: audios, startIndex: index),
                    headPhoneStrategy:
                        HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
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
                  currentSong.songname!,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (checkFavorite(index)) {
                            log('fav clicked>>>>>');
                            log(checkFavorite(index).toString());
                            removeFavour(index);
                          } else {
                            addfavour(index);
                            log('fav clicked>>>>>');
                          }
                          //log('pressed remove?????/');
                          //removeFavour(index);
                          setState(() {});
                        },
                        icon: Icon(
                          (checkFavorite(index))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: mywhite,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.library_add)),
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
      ),
    );
  }
}
