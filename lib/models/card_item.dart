import 'package:flutter/material.dart';

enum CardState { hidden, visible, guessed }

class CardItem {
  CardItem({
    required this.value,
    required this.imageData,
    required this.color,
    this.state = CardState.hidden,
  });

  final int value;
  final String imageData;
  final Color color;
  CardState state;
}
