import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Increased horizontal padding for width
        minimumSize: Size(200, 50),  // Minimum width and height for the button
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}
