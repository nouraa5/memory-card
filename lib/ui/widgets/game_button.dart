import 'package:flutter/material.dart';
class GameButton extends StatelessWidget {
  const GameButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.height = 40,
    this.width = double.infinity,
    this.fontSize = 25, // Set font size to 25
    this.textStyle,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final double height;
  final double width;
  final double fontSize; // Font size property
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(height / 2),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize, // Apply the font size here
          ).merge(textStyle), // Merge with any additional text style
        ),
      ),
    );
  }
}
