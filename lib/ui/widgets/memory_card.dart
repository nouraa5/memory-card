import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:memory_card_app/models/card_item.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({
    required this.card,
    required this.index,
    required this.onCardPressed,
    Key? key,
  }) : super(key: key);

  final CardItem card;
  final int index;
  final ValueChanged<int> onCardPressed;

  // void _handleCardTap() {
  //   if (card.state == CardState.hidden) {
  //     onCardPressed(index);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      if (card.state == CardState.hidden) {
        onCardPressed(index);
      }

      },

      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: _getColorForState(card.state),
        child: Center(
          child: _buildCardContent(),
        ),
      ),
    );
  }

  Widget? _buildCardContent() {
    if (card.state == CardState.hidden) {
      return null;
    } else if (card.state == CardState.visible) {
      return SizedBox.expand(
        child: FittedBox(
          child: Image.memory(
            base64Decode(card.imageData),
          ),
        ),
      );
    } else {
      // Card is guessed, return an empty container to hide it
      return Container();
    }
  }

  Color _getColorForState(CardState state) {
    switch (state) {
      case CardState.hidden:
        return Colors.grey;
      case CardState.visible:
        return card.color;
      case CardState.guessed:
        return Colors.transparent;
    }
  }
}
