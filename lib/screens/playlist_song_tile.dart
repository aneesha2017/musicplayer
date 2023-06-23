import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'functions.dart';

class PlaylistSongTtile extends StatefulWidget {
  int index;
  String playlistname;
  PlaylistSongTtile({
    super.key,
    required this.index,
    required this.playlistname,
  });

  @override
  State<PlaylistSongTtile> createState() => _PlaylistSongTtileState();
}

class _PlaylistSongTtileState extends State<PlaylistSongTtile> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> converted = [];

  @override
  void initState() {
    final playlistbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs> playlistsong = playlistbox.values.toList();

    for (var i in playlistsong[widget.index].playlistsong!) {
      converted.add(Audio.file(i.songurl!,
          metas:
              Metas(title: i.songname, artist: i.artist, id: i.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playlistbox = PlaylistSongsbox.getInstance();
    final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    List<PlaylistSongs> playlistsong = playlistbox.values.toList();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Myappbar(title: 'Playlist', trailing: const SizedBox()),
            ValueListenableBuilder(
              valueListenable: playlistbox.listenable(),
              builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                List<PlaylistSongs> playsong = playlistsongs.values.toList();
                List<Songs>? playlsong =
                    playlistsong[widget.index].playlistsong;
                return playlsong!.isNotEmpty
                    ? ListView.builder(
                        itemCount: playlsong.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: (context) => Miniplayer(
                                  index: index,
                                ),
                              );
                              audioPlayer.open(
                                Playlist(audios: converted, startIndex: index),
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                                showNotification: true,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                      topRight: Radius.circular(50)),
                                ),
                                height: 80,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      QueryArtworkWidget(
                                        artworkBorder:
                                            BorderRadius.circular(10),
                                        id: playlsong[index].id!,
                                        type: ArtworkType.AUDIO,
                                        artworkQuality: FilterQuality.high,
                                        quality: 100,
                                        size: 2000,
                                        artworkFit: BoxFit.fill,
                                        nullArtworkWidget: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.asset(
                                            'lib/assets/images.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          width: 140,
                                          child: Text(
                                            playlsong[index].songname!,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: IconButton(
                                            onPressed: () {
                                              //deletefromplaylist(index);
                                              playlsong.removeAt(index);
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No Songs in this playlist'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
