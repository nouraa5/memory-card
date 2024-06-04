import 'package:flutter/material.dart';
import 'package:memory_card_app/ui/pages/memory_match_page.dart';
import 'package:memory_card_app/ui/widgets/game_button.dart';
import 'package:memory_card_app/utils/constants.dart';

class GameOptions extends StatelessWidget {
  const GameOptions({
    super.key,
  });

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel, int row, int column) {
    return MaterialPageRoute(
      builder: (_) {
        return MemoryMatchPage(row: row,column:column, gameLevel: gameLevel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.map((level) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GameButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                _routeBuilder(context,level['level'], level['rows'] ,level['columns']),
                    (Route<dynamic> route) => false),
            title: level['title'],
            color: level['color']![700]!,
            width: 250,
            height: 60,
            textStyle: gameLevelTextStyle, // Apply custom text style
          ),
        );
      }).toList(),
    );
  }
}