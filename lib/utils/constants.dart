import 'package:flutter/material.dart';

const Color continueButtonColor = Color.fromRGBO(235, 32, 93, 1);
const Color restartButtonColor = Color.fromRGBO(243, 181, 45, 1);
const Color quitButtonColor = Color.fromRGBO(39, 162, 149, 1);

const TextStyle gameLevelTextStyle = TextStyle(
  color: Colors.black, // Set the text color to black
  // Add any other text style properties you want to customize here
);

const List<Map<String, dynamic>> gameLevels = [
  {'title': 'Easy', 'rows': 3, 'columns': 4, 'level':1,'color': Colors.lightBlueAccent},
  {'title': 'Medium', 'rows': 4, 'columns': 4, 'level':2,'color': Colors.lightGreenAccent},
  {'title': 'Hard', 'rows': 4, 'columns': 5, 'level':3,'color': Colors.yellowAccent},
  {'title': 'Difficult', 'rows': 5, 'columns':6, 'level':4, 'color': Colors.orange},
  // {'title': 'Expert', 'rows': 5, 'columns':6, 'level':5, 'color': Colors.redAccent},

];

const String gameTitle = 'MEMORY MATCH';
