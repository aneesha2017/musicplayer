import 'package:flutter/material.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/widgets/mydrawer.dart';
import '../const/colors.dart';
import '../screens/library.dart';
import '../screens/screenHome.dart';
import '../screens/search_screen.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentindex = 0;
  final tabs = [
    ScreenHome(),
    const SearchScreen(),
    const LibraryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Mydrawer(),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: myappbar(
              title: 'MyTunes',
              trailing: IconButton(
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () {},
              ))),
      backgroundColor: mybackgroundColor,
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        selectedItemColor: const Color.fromARGB(255, 33, 11, 68),
        unselectedItemColor: Colors.greenAccent,
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 17, 15, 85)),
        unselectedIconTheme: const IconThemeData(color: Colors.orange),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music_sharp), label: 'Library'),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
