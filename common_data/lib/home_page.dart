import 'dart:math';

import 'package:common_data/max_visible_value_store.dart';
import 'package:common_data/random_roll.dart';
import 'package:flutter/material.dart';
import 'package:visiblity_manager/visiblity_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = MaxVisibleValueStore();

  List<Widget> items = [];

  void addItem() {
    double value =
        Random().nextDouble() * 30 + RandomRoll.count + RandomRoll.count * Random().nextDouble();
    final Key key = ValueKey(value);
    items = List<Widget>.from([
      ...items,
      RandomRoll(
        key: key,
        value: value,
      )
    ]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      addItem();
    }
  }

  void onChange<TValue, TCommon>(
      {VisiblityCalculableDataStore<TValue, TCommon>? dataStore,
      required VisiblityStore visiblyStore}) {
    if (dataStore is MaxVisibleValueStore) {
      final int? maxValue = (dataStore as MaxVisibleValueStore).calculate(visiblyStore.getVisibleKeys());
      store.update(maxValue??0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Max visible value: ${store.maxValue}'),
            actions: [
              IconButton(onPressed: addItem, icon: const Icon(Icons.add))
            ]),
        body: VisiblityManagerCalculableData.calculable<int, int>(
          store: store,
          onChange: onChange,
          child: ListView(
            children: items,
          ),
        ),
      ),
    );
  }
}
