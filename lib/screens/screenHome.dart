import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/screens/playlisthome.dart';
import 'package:slide_drawer/slide_drawer.dart';
import '../models/songs_model.dart';
import '../widgets/home_screen_song_tile.dart';
import 'common widget/myappbar.dart';
import 'homescreen/widget/horizontal_home_scrolling.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final box = SongBox.getInstance();
  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed('favorite1'),
                        child: Newcontainer(
                            folder: 'Favorites',
                            image: 'lib/assets/Untitled design (1).png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed('recent'),
                        child: Newcontainer(
                          folder: 'Recent Songs',
                          image: 'lib/assets/Untitled design (2).png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Playgrid();
                          },
                        )),
                        child: Newcontainer(
                            folder: 'Playlist',
                            image: 'lib/assets/Untitled design (1).png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed('mostplay'),
                        child: Newcontainer(
                            folder: 'mostplayed',
                            image: 'lib/assets/Untitled design.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Homescreensongtile(),
        ],
      ),
    );
  }
}
