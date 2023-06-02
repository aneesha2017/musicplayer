import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/widgets/favorite_song_tile.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myappbar(title: 'Favorites', trailing: const SizedBox()),
            Container(
              height: 700,
              child: ListView.builder(
                itemBuilder: (context, index) => const favorite_song_tile(),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
