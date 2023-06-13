import 'package:hive/hive.dart';
part 'mostplayed_model.g.dart';

@HiveType(typeId: 4)
class MostPlayed {
  @HiveField(0)
  String songname;
  @HiveField(1)
  String artist;

  @HiveField(2)
  String songurl;
  @HiveField(3)
  int count;
  @HiveField(4)
  int id;

  MostPlayed(
      {required this.songname,
      required this.songurl,
      required this.artist,
      required this.count,
      required this.id});
}
