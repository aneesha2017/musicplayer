import 'package:flutter/material.dart';
import 'libraryhome.dart';

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
                  itemCount: 1,
                  itemBuilder: (context, index) => const LibraryHome()
                  //Library_song_tile(),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
