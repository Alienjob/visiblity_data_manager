import 'dart:math';

import 'package:calculable_data/max_visible_value_store.dart';
import 'package:calculable_data/random_roll.dart';
import 'package:flutter/material.dart';
import 'package:visiblity_data_manager/visiblity_data_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = MaxVisibleValueStore();

  List<Widget> items = [];
  int count = 0;
  void addItem() {
    count++;
    double value =
        Random().nextDouble() * 30 + count + count * Random().nextDouble();
    final Key key = ValueKey(value);
    items = List<Widget>.from([
      ...items,
      VisiblityManageble(
        key: key,
        initValue: value,
        builder: () => RandomRoll(
          value: value,
          maxValue: store.maxValue,
        ),
      )
    ]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 500; i++) {
      addItem();
    }
  }

  void onChange<TValue, TCommon>(
      {VisiblityCalculableDataStore<TValue, TCommon>? dataStore,
      required VisiblityStore visiblyStore}) {
    if (dataStore is MaxVisibleValueStore) {
      final double? maxValue = (dataStore as MaxVisibleValueStore).calculate(visiblyStore.getVisibleKeys());
      store.update(maxValue??0);
      Future.delayed(Duration.zero, () async{ setState(() {});}); 
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
        body: VisiblityManagerCalculableData.calculable<double, double>(
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
