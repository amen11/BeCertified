import '../Home/learn_more.dart';
import 'package:flutter/material.dart';

class CatigoryW2 extends StatefulWidget {
  String image;
  String text;
  String desc;
  Color color;
  String id;

  CatigoryW2({
    super.key,
    required this.image,
    required this.text,
    required this.color,
    required this.desc,
    required this.id,
  });

  @override
  State<CatigoryW2> createState() => _CatigoryW2State();
}

class _CatigoryW2State extends State<CatigoryW2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF87C0CD),
      ),
      child: Column(
        children: [
          Image.network(
            widget.image,
            width: 72,
            height: 72,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.text,
            style: TextStyle(color: widget.color, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          MaterialButton(
            color: const Color(0xFF226597),
            height: 20,
            minWidth: 100,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Color(0xFF226597))),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Learnmore(
                            text: widget.text,
                            desc: widget.desc,
                            image: widget.image,
                            id: widget.id,
                          )));
            },
            child: const Text(
              "Learn more »",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
