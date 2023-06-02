import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/playlist_song_tile.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myappbar(title: 'My Playllist', trailing: const SizedBox()),
            Container(
              height: 700,
              child: ListView.builder(
                itemBuilder: (context, index) => const playlist_song_tile(),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
