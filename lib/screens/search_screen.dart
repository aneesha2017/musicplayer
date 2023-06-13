import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/search_song_tile.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Songs> dbAllSongs = [];
  List<Songs> searchNew = [];
  List<Audio> convertedaudio = [];
  final box = SongBox.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSongs();
  }

  void fetchSongs() async {
    dbAllSongs = box.values.toList();
    searchNew = List.from(dbAllSongs);
    for (var element in searchNew) {
      convertedaudio.add(Audio.file(element.songurl.toString(),
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
  }

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
              secondaryButtonWidget: IconButton(
                  onPressed: () {
                    search.clear();
                    searchNew = List.from(dbAllSongs);
                    setState(() {});
                  },
                  icon: Icon(Icons.clear)),
              buttonWidget: const Icon(Icons.search),
              buttonColour: Colors.orange,
              buttonShadowColour: Colors.red,
              durationInMilliSeconds: 10000,
              onChanged: (val) {
                filteringSongs(val);
                setState(() {});
              },
            ),
            Container(
              height: 600,
              child: ListView.builder(
                itemBuilder: (context, index) => Search_song_tile(
                  index: index,
                  searchnew: searchNew,
                  convertedaudio: convertedaudio,
                ),
                itemCount: searchNew.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filteringSongs(String text) {
    if (text.isEmpty) {
      // If search text is empty, display all songs
      searchNew = List.from(dbAllSongs);
    } else {
      // Filter songs based on search text
      searchNew = dbAllSongs
          .where((element) =>
              element.songname!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    convertedaudio.clear();
    for (var element in searchNew) {
      convertedaudio.add(Audio.file(element.songurl.toString(),
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
  }
}
