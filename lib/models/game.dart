import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart'; // Import ChangeNotifier
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memory_card_app/models/card_item.dart';

class Game extends ChangeNotifier { // Extend ChangeNotifier
  Game(this.rows, this.columns) {
    generateCards();
  }

  final int rows;
  final int columns;
  int numberOfTries = 0;
  List<CardItem> cards = [];
  bool isGameOver = false;

  Future<void> generateCards() async {
    final response =
    await http.get(Uri.parse('http://192.168.8.193/memory_card_photos/conn1.php'));
    if (response.statusCode == 200) {
      List<String> imageDataList = List<String>.from(json.decode(response.body));
      imageDataList.shuffle(Random());
      cards = [];
      final List<Color> cardColors = Colors.primaries.toList();
      for (int i = 0; i < (rows * columns / 2); i++) {
        final cardValue = i + 1;
        final String imageData = imageDataList[i];
        final Color cardColor = cardColors[i % cardColors.length];
        final List<CardItem> newCards = _createCardItems(imageData, cardColor, cardValue);
        cards.addAll(newCards);
      }
      cards.shuffle(Random());
      cards.forEach((card) => card.state = CardState.visible);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1500)); // Adjust the duration as needed
      cards.forEach((card) => card.state = CardState.hidden);
      notifyListeners();
    }

    else {
      throw Exception('Failed to load images');
    }
  }

  void resetGame() {
    generateCards();
    isGameOver = false;
    numberOfTries = 0;
    notifyListeners(); // Notify listeners when the game state changes
  }

  int bestScore = 999999; // Assuming a high score is lower is better
  bool isNewHighScore = false;

  void onCardPressed(int index) {
    // Check if the card is hidden or visible but not guessed before revealing it
    if (cards[index].state != CardState.guessed) {
      cards[index].state = CardState.visible;
      final List<int> visibleCardIndexes = _getVisibleCardIndexes();
      if (visibleCardIndexes.length == 2) {
        final CardItem card1 = cards[visibleCardIndexes[0]];
        final CardItem card2 = cards[visibleCardIndexes[1]];
        if (card1.value == card2.value) {
          Future.delayed(const Duration(milliseconds: 300), () {
            card1.state = CardState.guessed;
            card2.state = CardState.guessed;
            // Check if the game is over
            isGameOver = _isGameOver();
            if (isGameOver && numberOfTries < bestScore) {
              bestScore = numberOfTries;
              isNewHighScore = true;
            }
          });
            // If the cards match, set their state to guessed

        } else {
          // If the cards don't match, delay before hiding them again
          Future.delayed(const Duration(milliseconds: 500), () {
            card1.state = CardState.hidden;
            card2.state = CardState.hidden;
            // Notify listeners when the game state changes
            notifyListeners();
          });
        }
        numberOfTries++;
      }
    }
  }

  List<CardItem> _createCardItems(String imageData, Color cardColor, int cardValue) {
    return List.generate(
      2,
          (index) => CardItem(
        value: cardValue,
        imageData: imageData,
        color: cardColor,
      ),
    );
  }

  List<int> _getVisibleCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.visible)
        .map((entry) => entry.key)
        .toList();
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }
}
