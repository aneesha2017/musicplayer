import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/home_screen_song_tile.dart';

class Musicplayer {
  static songNext() {
    player.next();
  }

  static songPrevious() {
    player.previous();
  }

  static songPlay() {
    player.play();
  }

  static songPause() {
    player.pause();
  }

  static songShuffle() {
    player.toggleShuffle();
  }

  // List<Audio> miniplayersongs =;

  // final box = SongBox.getInstance();
  //  for (var i in songDatabase) {
  //     miniplayersongs.add(
  //       Audio.file(
  //         i.songurl!,
  //         metas: Metas(
  //           title: i.songname,
  //           id: i.id.toString(),
  //         ),
  //       ),
  //     );
  //   }
}
