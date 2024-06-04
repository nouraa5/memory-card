import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_card_app/ui/widgets/game_best_tries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memory_card_app/models/game.dart';
import 'package:memory_card_app/ui/widgets/game_confetti.dart';
import 'package:memory_card_app/ui/widgets/memory_card.dart';
import 'package:memory_card_app/ui/widgets/game_timer.dart';
import 'package:memory_card_app/ui/widgets/restart_game.dart';
import 'package:share/share.dart'; // Import for sharing functionality


class GameBoardMobile extends StatefulWidget {
  const GameBoardMobile({
    required this.gameLevel,
    required this.row,
    required this.column,

    super.key,
  });

  final int gameLevel;
  final int row;
  final int column;



  @override
  State<GameBoardMobile> createState() => _GameBoardMobileState();
}

class _GameBoardMobileState extends State<GameBoardMobile> {
  late Timer timer;
  late Game game;
  late Duration duration;
  // int bestTime = 0;
  int bestTries = 0;
  bool showConfetti = false;

  @override
  void initState() {
    super.initState();
    game = Game(widget.row, widget.column);
    duration = const Duration();
    startTimer();
    // getBestTime();
    getBestTries();
  }

  void _shareHighScore() {
    final String message = 'I just got a new high score of ${game.bestScore} tries in Memory Match!';
    Share.share(message);
  }

  //
  // void getBestTime() async {
  //   SharedPreferences gameSP = await SharedPreferences.getInstance();
  //   if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
  //     bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
  //   }
  //   setState(() {});
  // }

  void getBestTries() async {
    SharedPreferences gameSP = await SharedPreferences.getInstance();
    if (gameSP.getInt('${widget.gameLevel.toString()}BestTries') != null) {
      bestTries = gameSP.getInt('${widget.gameLevel.toString()}BestTries')!;
    }
    setState(() {});
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });

      if (game.isGameOver) {
        timer.cancel();
        SharedPreferences gameSP = await SharedPreferences.getInstance();
        if (gameSP.getInt('${widget.gameLevel.toString()}BestTries') == null ||
            gameSP.getInt('${widget.gameLevel.toString()}BestTries')! >
                game.numberOfTries) {
          gameSP.setInt(
              '${widget.gameLevel.toString()}BestTries', game.numberOfTries);
          setState(() {
            showConfetti = true;
            bestTries = game.numberOfTries;
          });
        }
        // if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
        //     gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
        //         duration.inSeconds) {
        //   gameSP.setInt(
        //       '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
        //   setState(() {
        //     showConfetti = true;
        //     bestTime = duration.inSeconds;
        //   });
        // }
      }
    });
  }

  pauseTimer() {
    timer.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
    });
  }



  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20
              ),
              RestartGame(
                isGameOver: game.isGameOver,
                pauseGame: () => pauseTimer(),
                restartGame: () => _resetGame(),
                continueGame: () => startTimer(),
                color: Colors.amberAccent[700]!,
              ),
              GameTimer(
                time: duration,
              ),
              Text(
                'Tries: ${game.numberOfTries}', // Display the number of tries
                style: const TextStyle(fontSize: 24, color: Colors.black45),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: game.columns,
                    childAspectRatio: aspectRatio * 2,
                  ),
                  itemCount: game.cards.length,
                  itemBuilder: (context, index) {
                    return MemoryCard(
                      index: index,
                      card: game.cards[index],
                      onCardPressed: (index) {
                        setState(() {
                          game.onCardPressed(index);
                          if (game.isNewHighScore) {
                            // Trigger the share button to appear
                          }
                          // Increment the number of tries when a pair of cards is opened
                        });
                      },
                    );
                  },
                ),
              ),
              if (game.isNewHighScore)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: _shareHighScore,
                    icon: const Icon(Icons.share, color: Colors.black),
                    label: const Text(
                      'Share High Score',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              GameBestTries(
                bestTries: bestTries,
              ),
            ],
          ),
          showConfetti ? const GameConfetti() : const SizedBox(),
        ],
      ),
    );
  }
}
