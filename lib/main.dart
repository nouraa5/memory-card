import 'package:flutter/material.dart';
import 'package:memory_card_app/the_memory_match_game.dart';
// import 'package:memory_card_app/audio_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{

  runApp(TheMemoryMatchGame());

  final pref = await SharedPreferences.getInstance();
  await pref.clear();
  // AudioManager().playMusic(); // Start playing music
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TheMemoryMatchGame(),
//       title: 'The MemoryMatch Game',
//       theme: ThemeData.dark(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
