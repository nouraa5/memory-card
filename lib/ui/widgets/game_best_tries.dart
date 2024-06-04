import 'package:flutter/material.dart';

class GameBestTries extends StatelessWidget {
  const GameBestTries({
    required this.bestTries,
    super.key,
  });

  final int bestTries;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 60,
      ),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.greenAccent[700],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.celebration,
                size: 40,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'Best Tries: $bestTries',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
