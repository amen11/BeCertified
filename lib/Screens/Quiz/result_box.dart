import 'package:becertified/Screens/Quiz/constant.dart';
import '../Quiz/result_box.dart';
import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.onPressed,
    required this.questionLength,
  });
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF113F67),
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: Color(0xFFF8F1F1), fontSize: 22.0),
            ),
            const SizedBox(height: 20.0),
            CircleAvatar(
              child: Text(
                '$result/$questionLength',
                style: TextStyle(fontSize: 30.0, color: Color(0xFFF8F1F1)),
              ),
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Color(0xFFF87474) // kif tebda result half of the questions
                  : result < questionLength / 2
                      ? incorrect
                      : correct,
            ),
            const SizedBox(height: 20.0),
            Text(
              result == questionLength / 2
                  ? 'Almost There' // kif tebda result half of the questions
                  : result < questionLength / 2
                      ? 'Try Again ? '
                      : 'Great!',
              style: TextStyle(color: Color(0xFFF8F1F1)),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'Start Over',
                style: TextStyle(
                  color: Color(0xFF16C79A),
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
