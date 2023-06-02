import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/widgets/recent_song_tile.dart';

class Recent_songs extends StatelessWidget {
  const Recent_songs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myappbar(title: 'Recent Songs', trailing: const SizedBox()),
            Container(
              height: 700,
              child: ListView.builder(
                itemBuilder: (context, index) => const recent_song_tile(),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
