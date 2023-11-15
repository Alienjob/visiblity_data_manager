import 'dart:math';

import 'package:flutter/material.dart';

class RandomRoll extends StatefulWidget {
  static int count = 0;
  RandomRoll({super.key}) {
    count+=3;
  }

  @override
  State<RandomRoll> createState() => _RandomRollState();
}

class _RandomRollState extends State<RandomRoll> {
  double value = Random().nextDouble() * 30 + RandomRoll.count;
  final Color _color = Color.fromARGB(
    255,
    Random().nextInt(255),
    Random().nextInt(255),
    Random().nextInt(255),
  );

  @override
  Widget build(BuildContext context) {
    double widthConstrain = MediaQuery.of(context).size.width;
    double width = widthConstrain * value / 100;
    return Row(
      children: [
        SizedBox(
          width: width,
          child: ColoredBox(
            color: _color,
            child: Text('${value.ceil()}'),
          ),
        ),
      ],
    );
  }
}
