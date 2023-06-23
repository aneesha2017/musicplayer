import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/favorite_model.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/mostplayed_model.dart';
import '../models/songs_model.dart';
import '../screens/functions.dart';

class FavouriteSongTile extends StatefulWidget {
  FavouriteSongTile({
    super.key,
  });

  @override
  State<FavouriteSongTile> createState() => _FavouriteSongTileState();
}

class _FavouriteSongTileState extends State<FavouriteSongTile> {
  List<Favourites> likedsongs = [];
  final box = SongBox.getInstance();
  late List<Songs> allDbSongs = [];
  List<Audio> Favsongs = [];
  @override
  void initState() {
    allDbSongs = box.values.toList();
    likedsongs = favouritedb.values.toList().reversed.toList();
    for (var element in likedsongs) {
      Favsongs.add(Audio.file(element.songurl.toString(),
          metas: Metas(
            artist: element.artist,
            title: element.songname,
            id: element.id.toString(),
          )));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: likedsongs.length,
      itemBuilder: (context, index) {
        final currentSong = likedsongs[index];
        log(likedsongs.toString());
        return Container(
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50)),
          ),
          child: Center(
            child: ListTile(
              onTap: () {
                MostPlayed mostly = MostPlayed(
                  songname: likedsongs[index].songname!,
                  songurl: likedsongs[index].songurl!,
                  artist: likedsongs[index].artist!,
                  count: 1,
                  id: likedsongs[index].id!,
                );
                int indexMostly = allDbSongs.indexWhere((element) =>
                    element.songname == likedsongs[index].songname);
                addMostplayed(indexMostly, mostly);
                player.open(
                  Playlist(audios: Favsongs, startIndex: index),
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                  showNotification: true,
                );
                showBottomSheet(
                  context: context,
                  builder: (context) => Miniplayer(
                    index: index,
                  ),
                );
              },
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(10),
                id: currentSong.id!,
                type: ArtworkType.AUDIO,
                artworkQuality: FilterQuality.high,
                quality: 100,
                size: 2000,
                artworkFit: BoxFit.fill,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'lib/assets/images.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                currentSong.songname!,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        log('pressed remove?????/');
                        int allSongsIndex = allDbSongs.indexWhere(
                          (element) => element.id == likedsongs[index].id,
                        );
                        log(allSongsIndex.toString());
                        log(index.toString());
                        await removeFavour(allSongsIndex);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: mywhite,
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
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }
}
