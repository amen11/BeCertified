import 'package:becertified/Screens/Home/background.dart';
import 'package:flutter/material.dart';

import 'details_screen.dart';

class CatigoryW extends StatefulWidget {
  String image;
  String text;
  Color color;
  final Function OnPressed;

  CatigoryW(
      {super.key,
      required this.image,
      required this.text,
      required this.color,
      required this.OnPressed});

  @override
  State<CatigoryW> createState() => _CatigoryWState();
}

class _CatigoryWState extends State<CatigoryW> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white70 //Color(0xFF87C0CD),
            ),
        child: Wrap(
          children: [
            Center(
              child: Image.network(
                widget.image,
                height: 100,
                width: 120,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.text,
              style: TextStyle(color: widget.color, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
