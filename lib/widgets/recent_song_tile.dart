import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/models/recent_model.dart';
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
  final box = RecentlyPlayedBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> convertedsongs = [];
  @override
  void initState() {
    final List<Recent> recentsongs = box.values.toList().reversed.toList();
    for (var i in recentsongs) {
      convertedsongs.add(Audio.file(i.songurl.toString(),
          metas:
              Metas(title: i.songname, artist: i.artist, id: i.id.toString())));
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Recent>>(
      valueListenable: box.listenable(),
      builder: (context, Box<Recent> dbrecent, child) {
        List<Recent> recentsongs = dbrecent.values.toList().reversed.toList();
        if (recentsongs.isEmpty) {
          return const Center(
            child: Text(
              'No recent songs found.',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentsongs.length,
            itemBuilder: (context, index) {
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
                        headPhoneStrategy:
                            HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        showNotification: true,
                      );
                      showBottomSheet(
                        context: context,
                        builder: (context) => Miniplayer(
                          index: index,
                        ),
                      );
                    },
                    leading: QueryArtworkWidget(
                      artworkBorder: BorderRadius.circular(10),
                      id: recentsongs[index].id!,
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
                      recentsongs[index].songname.toString(),
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
                              //removeFavour(indexMostly);
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
          );
        }
      },
    );
  }
}
