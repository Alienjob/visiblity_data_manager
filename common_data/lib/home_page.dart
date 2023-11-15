import 'package:common_data/random_roll.dart';
import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  final store = NumOfVisibleStore();

  List<Widget> items = [];

  void addItem() {
    final Key key = UniqueKey();
    items = List<Widget>.from([...items, RandomRoll()]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addItem();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: addItem, icon: const Icon(Icons.add))
        ]),
        body: ListView(
          children: items,
        ),
      ),
    );
  }
}
