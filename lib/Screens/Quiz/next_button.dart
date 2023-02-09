import 'package:becertified/Screens/Quiz/constant.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: neutre, borderRadius: BorderRadius.circular(50.0)),
      child: Text(
        'Next Question',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          color: Color(0xFFF8F1F1),
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
