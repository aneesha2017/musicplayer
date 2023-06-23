import 'package:hive/hive.dart';
import 'package:music_app/models/favorite_model.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'models/recent_model.dart';

late Box<Favourites> favouritedb;
openfavourite() async {
  favouritedb = await Hive.openBox<Favourites>('favorites-box');
}

late Box<MostPlayed> mostplayeddb;
openmostplayeddb() async {
  mostplayeddb = await Hive.openBox<MostPlayed>('Mostplayed');
}

late Box<Recent> recentdb;
openrecent() async {
  recentdb = await Hive.openBox<Recent>('RecentlyPlayed');
}
