import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';

import 'library_song_tile.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 600,
              child: ListView.builder(
                itemBuilder: (context, index) => const Library_song_tile(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
