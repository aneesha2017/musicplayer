import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'package:music_app/models/recent_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/functions.dart';

import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/playlist_model.dart';

class Homescreensongtile extends StatefulWidget {
  const Homescreensongtile({
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
  //Recent? recentsong;
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

                  Recent recent = Recent(
                    id: songlistDb[index].id,
                    artist: songlistDb[index].artist,
                    songname: songlistDb[index].songname,
                    songurl: songlistDb[index].songurl,
                  );
                  addRecently(recent);
                  // Recent rently = Recent(
                  //   songname: songlistDb[index].songname!,
                  //   songurl: songlistDb[index].songurl!,
                  //   artist: songlistDb[index].artist!,
                  //   id: songlistDb[index].id!,
                  // );
                  // log('adding to recent');
                  // log(index.toString());
                  // log(rently.toString());
                  // addRecently(index, rently);
                  // log('added to recently>>>>>>>>.after');

                  player.open(
                    Playlist(audios: audios, startIndex: index),
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
                          onPressed: () {
                            showPlaylistOptions(context, index);
                          },
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

showPlaylistOptions(BuildContext context, int songindex) {
  final box = PlaylistSongsbox.getInstance();
  final songbox = SongBox.getInstance();
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: mybackgroundColor,
              alignment: Alignment.bottomCenter,
              content: SizedBox(
                height: 200,
                width: vwidth,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<Box<PlaylistSongs>>(
                            valueListenable: box.listenable(),
                            builder: (context, Box<PlaylistSongs> playlistSong,
                                child) {
                              List<PlaylistSongs> playlistsong =
                                  playlistSong.values.toList();
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: playlistsong.length,
                                  itemBuilder: ((context, index) {
                                    return ListTile(
                                      onTap: () {
                                        PlaylistSongs? playlsong =
                                            playlistSong.getAt(index);
                                        List<Songs> playsongdb =
                                            playlsong!.playlistsong!;
                                        List<Songs> songdb =
                                            songbox.values.toList();
                                        bool isAlreadyAdded = playsongdb.any(
                                            (element) =>
                                                element.id ==
                                                songdb[songindex].id);
                                        if (!isAlreadyAdded) {
                                          playsongdb.add(
                                            Songs(
                                              songname:
                                                  songdb[songindex].songname,
                                              artist: songdb[songindex].artist,
                                              songurl:
                                                  songdb[songindex].songurl,
                                              id: songdb[songindex].id,
                                            ),
                                          );
                                        }
                                        playlistSong.putAt(
                                            index,
                                            PlaylistSongs(
                                                playlistname:
                                                    playlistsong[index]
                                                        .playlistname,
                                                playlistsong: playsongdb));
                                        print(
                                            'song added to${playlistsong[index].playlistname}');
                                        Navigator.pop(context);
                                      },
                                      title: Text(
                                        playlistsong[index].playlistname!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }));
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }));
}

showplaylistOptionsadd(BuildContext context) {
  final myController = TextEditingController();
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: mywhite,
            alignment: Alignment.bottomCenter,
            content: Container(
              height: 250,
              width: vwidth,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'New Playlist',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 250, 249, 249)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: vwidth * 0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: myController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white10,
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Enter Playlist Name:',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              // alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: vwidth * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: const Text('Cancel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: vwidth * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              newplaylist(myController.text);
                              Navigator.pop(context);
                            },
                            label: const Text(
                              'Done',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
}
