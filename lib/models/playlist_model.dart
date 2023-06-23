import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/models/songs_model.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlaylistSongs {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<Songs>? playlistsong;
  PlaylistSongs({required this.playlistname, required this.playlistsong});
}

class PlaylistSongsbox {
  static Box<PlaylistSongs>? _box;
  static Box<PlaylistSongs> getInstance() {
    return _box ??= Hive.box('playlist');
  }
}
