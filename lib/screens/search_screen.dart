import 'package:flutter/material.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/search_song_tile.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String searchText;
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBarAnimation(
              textEditingController: search,
              isOriginalAnimation: true,
              trailingWidget: const Icon(Icons.search),
              secondaryButtonWidget: const Icon(Icons.close),
              buttonWidget: const Icon(Icons.search),
              buttonColour: Colors.orange,
              buttonShadowColour: Colors.red,
              durationInMilliSeconds: 10000,
              onChanged: (val) {},
            ),
            Container(
              height: 600,
              child: ListView.builder(
                itemBuilder: (context, index) => const Search_song_tile(),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
