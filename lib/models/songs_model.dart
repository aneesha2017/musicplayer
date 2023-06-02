import 'package:hive/hive.dart';
part 'songs_model.g.dart';

@HiveType(typeId: 0)
class Songs extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? songname;

  @HiveField(2)
  String? artist;

  @HiveField(3)
  String? songurl;

  Songs({
    required this.id,
    required this.songname,
    required this.artist,
    required this.songurl,
  });
}

class SongBox {
  static Box<Songs>? _box;
  static Box<Songs> getInstance() {
    return _box ??= Hive.box('Allsongs');
  }

  static put(int? id, Songs song) {}
}
