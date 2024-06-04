import 'package:flutter/material.dart';
import 'package:memory_card_app/ui/pages/startup_page.dart';
import 'package:memory_card_app/ui/widgets/game_button.dart';
import 'package:memory_card_app/utils/constants.dart';

class GameControlsBottomSheet extends StatelessWidget {
  const GameControlsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'PAUSE',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          GameButton(
            onPressed: () => Navigator.of(context).pop(false),
            title: 'CONTINUE',
            color: continueButtonColor,
            width: 250,
            textStyle: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          GameButton(
            onPressed: () => Navigator.of(context).pop(true),
            title: 'RESTART',
            color: restartButtonColor,
            width: 250,
            textStyle: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          GameButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const StartUpPage();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            title: 'QUIT',
            color: quitButtonColor,
            width: 250,
            textStyle: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
