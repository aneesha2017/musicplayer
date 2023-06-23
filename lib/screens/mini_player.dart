import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/nowplaying.dart';
import 'package:music_app/widgets/home_screen_song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'functions.dart';

class Miniplayer extends StatefulWidget {
  final int index;
  Miniplayer({
    super.key,
    required this.index,
  });
  //required this.index
  @override
  State<Miniplayer> createState() => _MiniplayerState();
}

class _MiniplayerState extends State<Miniplayer> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  Musicplayer playobj = Musicplayer();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  Navigator.of(context).pushNamed('nowplay');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Nowplaymusic(
                  index: widget.index,
                )));
      },
      child: Container(
          height: 130,
          decoration: const BoxDecoration(color: mywhite),
          child: player.builderCurrent(
            builder: (context, playing) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: QueryArtworkWidget(
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'lib/assets/images.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            player.getCurrentAudioTitle,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                                onPressed: () async {
                                  log('hai i am previous');
                                  await player.previous();
                                  //await Musicplayer.songPrevious();
                                },
                                icon: const Icon(Icons.skip_previous));
                          },
                        ),
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                                onPressed: () async {
                                  log('hai i am previous');
                                  await player.play();
                                  //await Musicplayer.songPlay();
                                },
                                icon: const Icon(Icons.play_arrow_rounded));
                          },
                        ),
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                                onPressed: () async {
                                  log('hai i am previous');
                                  await player.pause();
                                  //await Musicplayer.songPause();
                                },
                                icon: const Icon(
                                    Icons.pause_circle_filled_rounded));
                          },
                        ),
                        PlayerBuilder.isPlaying(
                          player: player,
                          builder: (context, isPlaying) => IconButton(
                              onPressed: () async {
                                await player.next();
                                //await Musicplayer.songNext();
                              },
                              icon: const Icon(Icons.skip_next)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
