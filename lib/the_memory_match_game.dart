import 'package:flutter/material.dart';
import 'package:memory_card_app/ui/pages/startup_page.dart';

class TheMemoryMatchGame extends StatelessWidget {
  const TheMemoryMatchGame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartUpPage(),
      title: 'The MemoryMatch Game',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
