import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';

class Myappbar extends StatelessWidget {
  Myappbar({Key? key, required this.title, required this.trailing})
      : super(key: key);
  String title;
  Widget trailing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mywhite,
      title: Text(title),
      centerTitle: true,
      actions: [trailing],
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed('settings');
      //       },
      //       icon: Icon(Icons.menu))
      // ],
    );
  }
}
