import 'package:flutter/material.dart';
import 'package:memory_card_app/ui/widgets/game_options.dart';
import 'package:share/share.dart'; // Import for sharing functionality

class StartUpPage extends StatelessWidget {
  const StartUpPage({Key? key}) : super(key: key);

  // Method to show game rules and information dialog
  void _showGameInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Rules and Information'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add your game rules and information here
                Text(
                    'Memory Match is a card matching game. '
                        'Select a level, tap cards to reveal images, and find pairs. '
                        'The score is based on the number of tries. '
                        'The game ends when all pairs are matched. '
                        'Aim to beat your best score!'
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Method to share the game
  void _shareGame(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      'Check out this awesome memory match game!',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'MEMORY MATCH',
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(3, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    // Add the GameOptions widget or other UI elements as needed
                    GameOptions(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.info_outline, color: Colors.white, size: 40),
                onPressed: () {
                  _showGameInfoDialog(context);
                },
              ),
            ),
            Positioned(
              top: 70,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.share, color: Colors.white, size: 40),
                onPressed: () {
                  _shareGame(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
