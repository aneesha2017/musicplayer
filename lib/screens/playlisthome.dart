import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/functions.dart';
import '../widgets/home_screen_song_tile.dart';
import 'playlist_song_tile.dart';

class Playgrid extends StatefulWidget {
  Playgrid({
    Key? key,
  }) : super(key: key);

  @override
  State<Playgrid> createState() => _PlaygridState();
}

class _PlaygridState extends State<Playgrid> {
  final playlistbox = PlaylistSongsbox.getInstance();
  late List<PlaylistSongs> playlistsongs = playlistbox.values.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: Column(
        children: [
          Myappbar(
            title: 'Playlist Home',
            trailing: IconButton(
                color: Colors.white,
                iconSize: 20,
                onPressed: () {
                  showplaylistOptionsadd(context);
                },
                icon: const Icon(Icons.add)),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<PlaylistSongs>>(
                valueListenable: playlistbox.listenable(),
                builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                  List<PlaylistSongs> playlistsong =
                      playlistsongs.values.toList();

                  return playlistsong.isNotEmpty
                      ? GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(
                            playlistsong.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return PlaylistSongTtile(
                                      index: index,
                                      playlistname: playlistsong[index]
                                          .playlistname
                                          .toString(),
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'lib/assets/images.jpg',
                                      ),
                                      fit: BoxFit.fill),
                                  color: Colors.grey,
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        playlistsong[index].playlistname!,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          deleteplaylist(index);
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text('Play list is Empty'),
                        );
                }),
          ),
        ],
      ),
    );
  }
}
