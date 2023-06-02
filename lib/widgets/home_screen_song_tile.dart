import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/songs_model.dart';

import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/screens/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Homescreensongtile extends StatefulWidget {
  int image;
  String songname;
  String songurl;
  int index;
  Homescreensongtile({
    required this.image,
    required this.index,
    required this.songname,
    required this.songurl,
    super.key,
  });

  @override
  State<Homescreensongtile> createState() => _HomescreensongtileState();
}

AssetsAudioPlayer player = AssetsAudioPlayer();

class _HomescreensongtileState extends State<Homescreensongtile> {
  final box = SongBox.getInstance();
  List<Audio> audios = [];
  @override
  void initState() {
    List<Songs> songDatabase = box.values.toList();

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
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) => const Miniplayer(),
        );
        player.open(
          Playlist(audios: audios, startIndex: widget.index),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
          showNotification: true,
        );
        // scree.currentvalue.value = index;
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
          height: 70,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(30),
                    id: widget.image,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'lib/assets/images.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      //'song',
                      widget.songname, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_outlined),
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
  }
}
