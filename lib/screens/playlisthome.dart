import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/const/variables.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/playllist.dart';

class Playgrid extends StatelessWidget {
  const Playgrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: Column(
        children: [
          myappbar(
            title: 'Playlist Home',
            trailing: Container(
              child: IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {},
                  icon: const Icon(Icons.edit)),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('playlist');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(ssimage)),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                    child: const Center(
                      child: Text(
                        'Album Names',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
