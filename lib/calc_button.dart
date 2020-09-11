
import 'package:flutter/material.dart';

class CalcButtons extends StatelessWidget {

  final Color color;
  final Color textColor;
  final String buttonText;
  final buttonTapped;

  CalcButtons(this.color, this.textColor, this.buttonText, this.buttonTapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(fontWeight: FontWeight.bold, color: textColor,fontSize: 24),),
              ),
            )
        ),
      ),
    );
  }
}