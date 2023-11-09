import 'package:flutter/material.dart';
import 'package:num_of_visible/num_of_visible.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NumOfVisible();
  }
}
