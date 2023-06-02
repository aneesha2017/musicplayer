import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mywhite,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                const Text('Share'),
              ],
            ),
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                ),
                const Text('About'),
              ],
            ),
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.privacy_tip_outlined),
                ),
                const Text('PrivacyPolicy'),
              ],
            ),
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.gavel_outlined),
                ),
                const Text('Terms and Conditions'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
