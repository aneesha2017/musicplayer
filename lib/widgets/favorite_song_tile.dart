import 'package:flutter/material.dart';
import 'package:music_app/screens/mini_player.dart';

class favorite_song_tile extends StatelessWidget {
  const favorite_song_tile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) => const Miniplayer(),
        );
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
          height: 80,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('lib/assets/piano-1655558_960_720 (1).jpg'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Song Name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
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
