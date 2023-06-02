import 'package:flutter/material.dart';

class Newcontainer extends StatelessWidget {
  Newcontainer({Key? key, required this.folder, required this.image})
      : super(key: key);
  String folder;
  String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 100,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.contain)),
          ),
          Text(folder)
        ],
      ),
    );
  }
}
