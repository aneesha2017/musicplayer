import 'package:flutter/material.dart';
import 'package:music_app/screens/playlisthome.dart';
import '../models/songs_model.dart';
import 'homescreen/widget/horizontal_home_scrolling.dart';

class LibraryHome extends StatefulWidget {
  const LibraryHome({Key? key}) : super(key: key);

  @override
  State<LibraryHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<LibraryHome> {
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
          GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the desired number of columns
              crossAxisSpacing: 2, // Set the spacing between columns
              mainAxisSpacing: 2, // Set the spacing between rows
            ),
            itemCount: 4, // Replace with the actual number of items
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.of(context).pushNamed('favorite1');
                  } else if (index == 1) {
                    Navigator.of(context).pushNamed('recent');
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Playgrid()),
                    );
                  } else if (index == 3) {
                    Navigator.of(context).pushNamed('mostplay');
                  }
                },
                child: Newcontainer(
                  folder: getFolderName(index),
                  image: getImagePath(index),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String getFolderName(int index) {
    switch (index) {
      case 0:
        return 'Favorites';
      case 1:
        return 'Recent Songs';
      case 2:
        return 'Playlist';
      case 3:
        return 'Most Played';
      default:
        return '';
    }
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'lib/assets/Untitled design (1).png';
      case 1:
        return 'lib/assets/Untitled design (2).png';
      case 2:
        return 'lib/assets/Untitled design (1).png';
      case 3:
        return 'lib/assets/Untitled design.png';
      default:
        return '';
    }
  }
}
