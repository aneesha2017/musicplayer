import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/const/variables.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'functions.dart';
import 'mini_player.dart';

class Nowplaymusic extends StatefulWidget {
  //final List<Songs> nowplaysongs;
  Nowplaymusic({
    super.key,
    // required this.nowplaysongs,
  });

  @override
  State<Nowplaymusic> createState() => _NowplaymusicState();
}

class _NowplaymusicState extends State<Nowplaymusic> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = true;
  int repeat = 0;

  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myappbar(
              title: 'play Beats',
              trailing: const SizedBox(),
            ),
            player.builderCurrent(
              builder: (context, playing) {
                log('/////////////////////');
                log(playing.audio.audio.metas.id!);
                return Stack(
                  children: [
                    Container(
                      height: screenheight,
                      width: screenwidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(bimage),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              player.getCurrentAudioTitle,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              player.getCurrentAudioArtist,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      left: 30,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            color: mywhite,
                            borderRadius: BorderRadius.circular(150),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.orangeAccent,
                                  spreadRadius: 12,
                                  blurRadius: 20,
                                  offset: Offset(0, 3))
                            ]),
                        child: QueryArtworkWidget(
                          id: int.parse(playing.audio.audio.metas.id!),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'lib/assets/images.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 500),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              PlayerBuilder.realtimePlayingInfos(
                                  player: player,
                                  builder: (context, RealtimePlayingInfos) {
                                    duration = RealtimePlayingInfos
                                        .current!.audio.duration;
                                    position =
                                        RealtimePlayingInfos.currentPosition;
                                    return SizedBox(
                                      width: screenwidth,
                                      child: ProgressBar(
                                        baseBarColor: mywhite,
                                        progress: position,
                                        total: duration,
                                        onSeek: (duration) async {
                                          await player.seek(duration);
                                        },
                                      ),
                                    );
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                      color: mywhite,
                                      iconSize: 30,
                                      onPressed: () async {
                                        await Musicplayer.songShuffle();
                                      },
                                      icon: const Icon(Icons.shuffle));
                                },
                              ),
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) => IconButton(
                                    color: mywhite,
                                    iconSize: 30,
                                    onPressed: () async {
                                      await Musicplayer.songPrevious();
                                    },
                                    icon: const Icon(
                                        Icons.skip_previous_outlined)),
                              ),
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) => IconButton(
                                    color: mywhite,
                                    iconSize: 30,
                                    onPressed: () async {
                                      await Musicplayer.songPlay();
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow_outlined,
                                      color: mywhite,
                                    )),
                              ),
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) => IconButton(
                                    color: mywhite,
                                    iconSize: 30,
                                    onPressed: () async {
                                      await Musicplayer.songPause();
                                    },
                                    icon: const Icon(
                                      Icons.pause_circle_filled_outlined,
                                      color: mywhite,
                                    )),
                              ),
                              PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) => IconButton(
                                    color: mywhite,
                                    iconSize: 30,
                                    onPressed: () async {
                                      await Musicplayer.songNext();
                                    },
                                    icon: const Icon(Icons.skip_next_outlined)),
                              ),
                              IconButton(
                                  color: mywhite,
                                  iconSize: 30,
                                  onPressed: () {
                                    if (repeat % 2 == 0) {
                                      player.setLoopMode(LoopMode.single);
                                      repeat++;
                                    } else {
                                      player.setLoopMode(LoopMode.none);
                                      repeat++;
                                    }
                                  },
                                  icon: const Icon(Icons.repeat)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                color: mywhite,
                                iconSize: 30,
                                onPressed: () async {
                                  await Musicplayer.songPlay();
                                },
                                icon: Icon(Icons.playlist_add_circle),
                              ),
                              IconButton(
                                color: mywhite,
                                iconSize: 30,
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border_outlined),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
