import 'package:flutter/material.dart';
// import 'package:memory_card_app/ui/widgets/web/game_board.dart';
import 'package:memory_card_app/ui/widgets/game_board_mobile.dart';

class MemoryMatchPage extends StatelessWidget {
  const MemoryMatchPage({
    required this.gameLevel,
    required this.row,
    required this.column,
    super.key,
  });

  final int gameLevel;
  final int row;
  final int column;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.jpg'), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: GameBoardMobile(
            gameLevel: gameLevel,
            row: row,
            column: column,
          ),
        ),
      ),
    );
  }
}