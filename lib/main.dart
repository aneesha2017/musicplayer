import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/favorites.dart';
import 'package:music_app/screens/mostplayed.dart';
import 'package:music_app/screens/nowplaying.dart';
import 'package:music_app/screens/playlisthome.dart';
import 'package:music_app/screens/playllist.dart';
import 'package:music_app/screens/recent_songs.dart';
import 'package:music_app/screens/search_screen.dart';
import 'package:music_app/screens/splash_screen.dart';
import 'package:music_app/widgets/bottom_nav.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongsAdapter());
  }

  await Hive.openBox<Songs>('AllSongs');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const Splashscreen(),
      routes: {
        'bottomnav': (context) => const BottomNavigation(),
        'search': (context) => const SearchScreen(),
        'recent': (context) => const Recent_songs(),
        'favorite1': (context) => const Favorites(),
        'playlist1': (context) => const Playgrid(),
        'playlist': (context) => const Playlist(),
        'mostplay': (context) => const Mostplayed(),
      },
    );
  }
}
