import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final Duration time;
  const GameTimer({
    super.key,
    required this.time,
  });

  String _formatDuration(Duration duration) {
    String hours = (duration.inHours % 60).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

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
      color: Colors.red[700],
      child: Padding(
        padding: const EdgeInsets.all(5.2),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.timer,
                size: 30,
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  _formatDuration(time),
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
