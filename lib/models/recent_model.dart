import 'package:hive_flutter/hive_flutter.dart';
part 'recent_model.g.dart';

@HiveType(typeId: 3)
class Recent {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  String? artist;
  @HiveField(3)
  String? songurl;
  Recent({
    required this.id,
    required this.songname,
    required this.artist,
    required this.songurl,
  });
}

String recentbox = 'RecentlyPlayed';

class RecentlyPlayedBox {
  static Box<Recent>? _box;
  static Box<Recent> getInstance() {
    return _box ??= Hive.box(recentbox);
  }
}
