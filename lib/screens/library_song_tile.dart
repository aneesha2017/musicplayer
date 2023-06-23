// import 'package:flutter/material.dart';
// import 'package:music_app/screens/mini_player.dart';

// class Library_song_tile extends StatelessWidget {
//   int index;
//   Library_song_tile({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showBottomSheet(
//           context: context,
//           builder: (context) => Miniplayer(),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           padding: const EdgeInsets.only(
//             left: 15,
//             right: 15,
//           ),
//           decoration: const BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(50),
//                 bottomLeft: Radius.circular(50),
//                 topRight: Radius.circular(50)),
//           ),
//           height: 80,
//           child: Center(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 const CircleAvatar(
//                   backgroundImage:
//                       AssetImage('lib/assets/piano-1655558_960_720 (1).jpg'),
//                 ),
//                 const Text("Song Name"),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.play_circle_filled),
//                 ),
//                 IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
