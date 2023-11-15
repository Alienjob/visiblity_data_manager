import 'dart:math';

import 'package:flutter/material.dart';

class RandomRoll extends StatefulWidget {
  RandomRoll({super.key, required this.value}) {
    count += 3;
  }

  static int count = 0;
  final double value;

  @override
  State<RandomRoll> createState() => _RandomRollState();
}

class _RandomRollState extends State<RandomRoll> {
  late final Color _color;
  @override
  void initState() {
    super.initState();
    _color = Color.fromARGB(
      255,
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthConstrain = MediaQuery.of(context).size.width;
    double width = min(widthConstrain * widget.value / 100, widthConstrain);
    return Row(
      children: [
        SizedBox(
          width: width,
          child: ColoredBox(
            color: _color,
            child: Text('${widget.value.ceil()}'),
          ),
        ),
      ],
    );
  }
}
