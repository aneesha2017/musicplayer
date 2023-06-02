import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/most_song_tile.dart';

class Mostplayed extends StatelessWidget {
  const Mostplayed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myappbar(title: 'Most Played', trailing: const SizedBox()),
            SizedBox(
              height: 700,
              child: ListView.builder(
                itemBuilder: (context, index) => const Most_song_tile(),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
