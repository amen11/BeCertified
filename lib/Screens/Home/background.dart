import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const Color black = Color.fromARGB(255, 0, 0, 0);
const Color white = Color(0xFFFFFFFF);
const Color bgColor = Color(0xFF113F67);
const Color selectColor = Color(0xFFFFFFFF);

const TextStyle bntText = TextStyle(
  color: black,
  fontWeight: FontWeight.w500,
);

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      origin: const Offset(30, -60),
      angle: 2.4,
      child: Container(
        margin: const EdgeInsets.only(
          left: 75,
          top: 40,
        ),
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [Color(0xFF113F67), Color(0xFF87C0CD)],
          ),
        ),
      ),
    );
  }
}
